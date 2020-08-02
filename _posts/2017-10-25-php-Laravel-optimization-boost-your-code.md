---
layout: post
title: "Laravel PHP 優化之路：效能瓶頸的解決方案"
description: "PHP Laravel Optimization, boost your code."
tags: [php, laravel]
---

## 前言

最近在開發一些後端專案程式的時候，遇到了一些效能上的挑戰，從功能實作後到重構整個過程蠻有趣的，藉由文字的紀錄自己的優化過程。

## 案例一：檢查資料庫內重複的資料

在一次的案例中，必須檢查使用者新增的資料在資料庫內是不是有重複的內容，這邊以簡單的留言系統為例，所以就寫了這樣的邏輯並且抽離出 `checkCommentIsDuplicate` 這樣的 method ，用來檢查該筆資料是不是有在資料表內重複：

```php
foreach ($newComments as $key => $comment) {
    // Check the comment is duplicate in database
    if ($this->CommentManager->checkCommentIsDuplicate($comment)) {
        // Do something, like remove the item from array
        unset($newComments[$key]);
    }
}
```

一開始暴力解都是用以下作法：

```php
class CommentManager
{
    public function checkCommentIsDuplicate($insertComment)
    {
        $condition = [
            ['title', '=', $insertComment['title']],
            ['content', '=', $insertComment['content']],
        ];

        return (Comment::where($condition)->count() > 0);
    }
}
```

當然，在本機的資料庫跑得好好的，一切都很理想，連線既沒有延遲，更不用煩惱 PHP Timeout 的問題。

一佈署到 AWS 上，資料庫有小於 100~500 筆的資料看似一切還好，一插入 1000 筆資料問題就來了。

因為 AWS 的 RDS (Relational Database Service) 與 PHP 程式間的連線會有延遲，一個 SQL 查詢其實就是非常昂貴的運算資源。

假設資料庫內有 500 筆資料，今天我要新增 300 筆資料，如果要檢查新增的資料是不是與資料庫有重複。這樣每一筆新增的資料，就要下一次 SQL 查詢，這樣至少要產生 **300** 次 SQL 查詢，就算資料庫可接受的連線時間，PHP 還是很快的就超過預設的 30 秒執行時間，逾時中止了。

就算調大執行時間，新增的資料如果成長成 **1000** 筆、甚至 **5000** 呢？就算程式跑得完使用者不見得等的下去。

於是乎，就會想到，我可以一次查詢後在程式內檢查啊！於是乎程式又被改成了這樣：

```php
class CommentManager
{
    public function checkCommentIsDuplicate($currentCommentInDB, $insertComment)
    {
        foreach ($currentCommentInDB as $currentComment) {
            if ($currentComment['title'] == $insertComment['title'] && $currentComment['content'] == $insertComment['content']) {
                return true;
            }
        }

        return false;
    }
}
```

開心的改好之後在測試機上測試一下，嗯，500 筆好像還行。

但是當新增的資料量超過 1000 筆，當資料庫內有 4000 筆以上的資料，可能的效能瓶頸又出現了。

因為每一筆資料必須與查詢後的 4000 筆資料進行循序比較，這樣最壞的情況 (都沒有重複的資料)，需要比較 1000 * 4000 次，這個運算量還是挺費時的。

### 善用 Hashing 解決大量資料的效能瓶頸

於是，不外乎就試著將資料表內的每筆資料雜湊後作為 Hash key，建立 Hash table，利用這個 Hash table 進行 duplicate 的檢查，這樣大幅減少比較的次數，沒有碰撞的情況下(也不應該會碰撞，資料庫內的資料寫入時不會 Duplicate )，比較的時間複雜度可以優化到 O(1)，在本機的測試環境連接 ap-northeast-1 的 RDS (完全能明顯感受到資料庫連線延遲) 得到不錯的執行時間。

測試環境：
- CPU: Intel Core i7-4510U (2.00 GHz x 4)
- Memory: 8 GB
- OS: ubuntu 16.04 LTS x64 (Linux 4.4.0-97-generic #120-Ubuntu SMP Tue Sep 19 17:28:18 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux)
- PHP 7.0.22-0ubuntu0.16.04.1 (cli) ( NTS )

實測後，新增 **4615** 筆資料，並與與資料庫內 **9230** 筆進行 Duplicate 進行比較，整體從使用者送出 Request 至 Response 執行時間約 `6.558937 s`，因為是在開發端進行連線，連接到 RDS 有蠻大的延遲，佈署到 AWS 上後應該可以更快。

實測本機單元測試的結果，使用 Laravel 內建的 Factory 產生 90010 筆測試資料：

- [1st] stress test: compare 90010 data in database, total use 0.000049 s.
- [2nd] stress test: compare 90010 data in database, total use 0.000004 s.

除了第一次產生 Hash table 稍微耗時需 `0.000049 s` ，第二次開始的執行時間就會明顯降低。

基本上 PHP 的 Array 就是一個很棒能實作 Hash table 的方式，執行速度非常的不錯，以下是實作的概念性程式碼：

```php
class CommentManager
{
    public function __construct()
    {
        $this->CommentHashTable = null;
    }

    /**
     * Check the comment is duplicated in database or not
     *
     * $currentCommentInDB: the comments in the database.
     * $insertComment: the comment will insert, check the
     *                 duplication here.
     *
     * @param  \App\Models\Comment $currentComment
     * @param  array $insertComment
     * @return bool
     */
    public function checkCommentIsDuplicate($currentCommentInDB, $insertComment)
    {
        $hashItem = ['title', 'content'];

        if ($this->CommentHashTable == null) {

            // Normalize the $currentCommentArray
            if ($currentCommentInDB->count() == 0) {
                $currentCommentArray = [];
            } else if ($currentCommentInDB->count() == 1) {
                $currentCommentArray = [ $currentCommentInDB->toArray() ];
            } else {
                $currentCommentArray = $currentCommentInDB->toArray();
            }

            $this->createCommentHashTable($currentCommentArray, $hashItem);
        }

        $insertCommentHashKey = $this->HashKey($insertComment, $hashItem);

        return isset($this->CommentHashTable[$insertCommentHashKey]);
    }
}
```


## 案例二：後端程式使用 Eloquent ORM Relationships 進行資料多重關聯查詢

另一個效能瓶頸在於 Laravel 的 Relationships，[Laravel 5.5 一樣提供了 Eloquent relationships][laravel-5.5-eloquent-relationships] 方便查詢不同資料表內的資訊，以下是使用 Eloquent model 常見的操作：

```php
class UserController extends Controller
{
    public function getLatestUser()
    {
        $users = User::orderBy('id', 'desc')->take(1000)->get();

        foreach ($users as $index => $user) {
            $users[$index]['id'] = $user->id;
            $users[$index]['name'] = $user->name;
            $users[$index]['email'] = $user->email;
            $users[$index]['updated_at'] = $user->updated_at;
            $users[$index]['created_at'] = $user->created_at;
            $users[$index]['recent_post_id'] = $user->posts->first()->id;
            $users[$index]['recent_comment_id'] = $user->comments->first()->id;
            $users[$index]['recent_orders_id'] = $user->orders->first()->id;
        }
    }
}
```

[因為 Eloquent 動態 Property 屬於 lazy loading 的特性][laravel-5.5-eloquent-relationships-methods-vs-dynamic-property]，Laravel Eloquent relationships 的 SQL 查詢是在 `foreach` 迴圈內每次執行時被建立的。

> Dynamic properties are "lazy loading", meaning they will only load their relationship data when you actually access them. Because of this, developers often use eager loading to pre-load relationships they know will be accessed after loading the model. Eager loading provides a significant reduction in SQL queries that must be executed to load a model's relations.

也就是說上述的程式如果被轉譯成 SQL 查詢會像是這樣：

```sql
select * from users

select id from posts where id = 1
select id from comments where id = 1
select id from orders where id = 1

select id from posts where id = 2
select id from comments where id = 2
select id from orders where id = 2

select id from posts where id = 3
select id from comments where id = 3
select id from orders where id = 3

... 略
```

大致列舉查詢的語句，完整語句應該與實際 Laravel 轉譯的結果有些不同。

可見的是，如果今天有 1000 筆的 User 和其關聯性的資料(post, comment, order)，就必須得產生至少 1000 * 3 次的關聯查詢，這樣的做法在 SQL 建立連線和查詢的過程是十分耗時的。

### 使用 Eager Loading 減少 SQL 查詢的次數

Laravel 5.5 提供了 [Eager Loading][laravel-5.5-eloquent-eager-loading] 可以協助平衡這樣的效能瓶頸，使用 `with()` 配合 Eloquent relationships 的優點在於資料的查詢方式是一次性的，Laravel 會預先將所有關聯的資料一次性的完成查詢，避免上述迴圈執行時會再重新建立一個新的 SQL 查詢連線，修改後的邏輯大致上是這樣：

```php
class UserController extends Controller
{
    public function getLatestUser()
    {
        $users = User::orderBy('id', 'desc')->with(['posts', 'comments', 'orders'])->take(1000)->get();

        foreach ($users as $index => $user) {
            $users[$index]['id'] = $user->id;
            $users[$index]['name'] = $user->name;
            $users[$index]['email'] = $user->email;
            $users[$index]['updated_at'] = $user->updated_at;
            $users[$index]['created_at'] = $user->created_at;
            $users[$index]['recent_post_id'] = $user->posts->first()->id;
            $users[$index]['recent_comment_id'] = $user->comments->first()->id;
            $users[$index]['recent_orders_id'] = $user->orders->first()->id;
        }
    }
}
```

在 Query 內使用了 `with(['posts', 'comments', 'orders'])` ，這樣 Laravel 就會在執行查詢時也查詢關聯性的資料。

依照文件上的解釋這樣 Laravel 透過 Eloquent ORM 轉譯成 SQL 語句查詢時會執行像這樣的語句：

```sql
select * from users
select * from posts where id in (1, 2, 3, 4, 5, ...)
select * from comments where id in (1, 2, 3, 4, 5, ...)
select * from orders where id in (1, 2, 3, 4, 5, ...)
```

這樣將原本的查詢縮減到非常小的次數，同時降低資料庫連線建立的成本和避免連線建立延遲放大 PHP 程式等待的速度。

經過這樣小小的更正後，約 600 ~ 1000 筆的資料從原本的處理速度約 10 ~ 20s 不等下降至 0.5ms ~ 2s，這點微妙的時間差就能讓使用者體驗有完全不一樣的感受。使用 Eager Loading 也能減少伺服器查詢的耗時及次數，若有遇到同樣的效能瓶頸可以試著使用這樣的方式來達到效能使用上的平衡。


Reference:

- [Relationship Methods Vs. Dynamic Properties][laravel-5.5-eloquent-relationships-methods-vs-dynamic-property]
- [Laravel Eloquent Eager Loading][laravel-5.5-eloquent-eager-loading]

[laravel-5.5-eloquent-relationships-methods-vs-dynamic-property]: https://laravel.com/docs/5.5/eloquent-relationships#relationship-methods-vs-dynamic-properties
[laravel-5.5-eloquent-eager-loading]: https://laravel.com/docs/5.5/eloquent-relationships#eager-loading
[laravel-5.5-eloquent-relationships]: https://laravel.com/docs/5.5/eloquent-relationships
