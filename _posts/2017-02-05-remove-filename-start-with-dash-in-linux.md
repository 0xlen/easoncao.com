---
layout: post
title: "在 Linux 底下刪除以連接符號 - (dash) 開頭的檔案"
description: "Remove filename start with dash in Linux"
tags: [Linux]
---

在 Linux 使用 CLI 刪除檔案直覺想到的就是 `rm` 指令，

是非常高頻率使用的程式，像刪除一般檔案的指令

```bash
rm yourfile
```

Linux 預裝程式多數提供許多參數選項，只要加上 `-` 符號 (英文為dash) 以及對應的選項就能發揮對應的功能，

像是 `-r` 可以讓 rm 這隻程式 recursive，`-f` 代表 force，

當放一起成為 `-rf` 參數時可以刪除整個目錄，但使用不慎很可能會發生難以想像的破壞，

```bash
rm -rf /myFolder
```

但如果檔案開頭是以 `-` 符號開始呢？例如(`-sample.txt`)

刪除檔案這種乍看簡單的問題就瞬間變很難了，一般直覺的作法是這樣，

```bash
rm -sample
```

但是這樣就會被 rm 認為是加上 `-sample` 選項，但 rm 並沒有提供對應的功能，而不是以檔名解析，

所以你可能會想到利用 `\` 跳脫，

```bash
rm \-sample
```

其實這有點像是換行而已，但很遺憾的是這樣也沒辦法讓 rm 正常解析為檔名，

正確作法是加上兩個 dash 符號 `--`

```bash
rm -- -sample
```

這樣就能正常刪除了，

或是以這種方式也能夠刪除 (給予絕對路徑)

```bash
rm ./-sample
```
