---
layout: post
title: "在 Laravel 中簡易的擴充 Blade Helper function"
description: "Extend blade helper function in laravel"
og_image: "/assets/images/posts/2017/02/laravel-5.4-work-with-vue-notice/laravel.png"
tags: [php, laravel]
---

在 `App/Providers/AppServiceProvider.php` 檔案內 `register()` 新增 loader 程式碼。

```php
<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        // Reigister each helper files
        foreach (glob(app_path().'/Helpers/*.php') as $filename){
            require_once($filename);
        }

    }
}
```

搜尋 `config/app.php` 中的 `providers` 陣列，確認有正確載入 `AppServiceProvider`。

```php
'providers' => [

    /*
     * Application Service Providers...
     */
    App\Providers\AppServiceProvider::class,

]
```

在 `app/Helpers/` 內新增自訂的 helper function 即可。(注意不要與官方提供的 [helper function][laravel-5.3-helper-function] 衝突)

Helper function 可以很方便的用來像自訂時間顯示格式

`app\Helpers\TimeElapsedString.php`

```php
<?php

/**
 * Get time eplapsed string (4 months, 2 weeks, 3 days, 1 hour, 49 minutes, 15 seconds ago)
 *
 * Example:
 *     echo time_elapsed_string('2013-05-01 00:22:35');
 *     echo time_elapsed_string('@1367367755'); # timestamp input
 *     echo time_elapsed_string('2013-05-01 00:22:35', true);  // get full string
 *
 * @param  Datetime  $datetime
 * @param  boolean   $full
 * @return string
 */
function time_elapsed_string($datetime, $full = false) {
    $now = new DateTime;
    $ago = new DateTime($datetime);
    $diff = $now->diff($ago);

    $diff->w = floor($diff->d / 7);
    $diff->d -= $diff->w * 7;

    $string = array(
        'y' => 'year',
        'm' => 'month',
        'w' => 'week',
        'd' => 'day',
        'h' => 'hour',
        'i' => 'minute',
        's' => 'second',
    );
    foreach ($string as $k => &$v) {
        if ($diff->$k) {
            $v = $diff->$k . ' ' . $v . ($diff->$k > 1 ? 's' : '');
        } else {
            unset($string[$k]);
        }
    }

    if (!$full) $string = array_slice($string, 0, 1);
    return $string ? implode(', ', $string) . ' ago' : 'just now';
}
```

在 Blade 內只要使用

{% raw %}
```php
{{ time_elapsed_string($time) }}
```
{% endraw %}

即可很容易的顯示出自訂的時間格式。

當然，利用寫為 Service 能夠將容易重用的 method 自訂為 Helper function。

以下是用於自訂 Response json 格式的 Helper function 範例

`app\Helpers\Response.php`

```php
<?php

/**
 * Response messages json format
 *
 * @param  integer  $code
 * @param  string   $messages
 * @param  array    $extend
 * @return \Illuminate\Http\Response
 */
function responseJSON($code, $messages, $extend = [])
{
    $data = [
        'code'  =>  $code,
        'messages'  =>  $messages,
    ];

    return response()->json(array_merge($data, $extend));
}
```

另一種作法則是透過 `composer.json` 設定 `autoload` 載入自訂的 Helper，

缺點則是較為缺乏彈性，若有多個 Helper 需要新增較不易管理及修改。

在 `composer.json` 中找到 `autoload` 選項後新增

```
"autoload": {
    "files": [
        "app/BladeHelper.php"
    ]
},
```

並且新增 `app/BladeHelper.php` 檔案，在裡面新增自訂的 Helper function 即可。

[laravel-5.3-helper-function]: https://laravel.com/docs/5.3/helpers#available-methods
