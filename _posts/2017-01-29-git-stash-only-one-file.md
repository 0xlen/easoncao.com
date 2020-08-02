---
layout: post
title: "讓 git 不必 commit 而暫存特定檔案的修改"
description: "利用一些方法讓 git 不必 commit 而暫存檔案的修改，並且只暫存特定檔案。"
og_image: "/assets/images/posts/2017/01/git-stash-only-one-file/git.png"
tags: [git]
---

{% include figure image_path="/assets/images/posts/2017/01/git-stash-only-one-file/git.png" alt="git" %}

git 最常用的指令應該就屬 commit 了，

然而修改特定檔案後 (untrack)，想要回到修改前的狀態 (HEAD)，卻又想暫存現在的修改，

我們並不想要真正 commit ，因為如果只是一點試驗性的修改，就又多一筆 commit 會感覺有點多餘。

這時候常見的作法是 stash ，便能暫存目前的修改。

```bash
git stash
```

要回復只要使用 pop 即可

```bash
git stash pop
```

但是這不是本篇文章的重點，如果一次更改多處程式，只想暫存特定檔案的修改，

最簡單的方式可以利用 diff 達成。

```bash
git diff app.c > stashed.diff
git checkout app.c
```

這樣會多出一個 stashed.diff 檔案，利用 checkout 就能將修改倒帶回去，只要使用 apply 就能回復修改。

```bash
git apply stashed.diff
```

另一種作法則是將要保存修改的檔案全部 `git add` 一遍，透過 `--keep-index` 也能達到同樣暫存特定檔案修改的效果。

```bash
touch FileNotStashed.txt stashed.txt
git add FileNotStashed.txt
git stash --keep-index
```


參考資料：
- [Stash only one file out of multiple files that have changed with Git?](http://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-multiple-files-that-have-changed-with-git)
