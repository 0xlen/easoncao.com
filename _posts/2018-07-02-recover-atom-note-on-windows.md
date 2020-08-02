---
layout: post
title: "救回 Windows 上意外關閉且遺失的 Atom 筆記 (1.27.2 x64)"
description: "Recover Atom note on Windows for version 1.27.2 x64"
tags: ['atom', 'windows']
---

這篇文章主要是記錄下在 Windows 上使用將意外關閉的 [Atom][atom] 筆記復原。

一般來說，Atom 內建自動復原的功能，但是在某些特殊情況遇到不小心意外關閉 Atom 筆記又很不巧沒有存檔，發生難以復原的情形，可以試試以下方式救回筆記 (版本 1.27.2 x64)。

至以下目錄尋找 Atom 的暫存檔案：

```
C:\Users\<UserName>\AppData\Roaming\Atom\IndexedDB\
```

例如可能會看見像是這樣的目錄結構：
```
C:\Users\<UserName>\AppData\Roaming\Atom\IndexedDB\file__0.indexeddb.leveldb
```

在目錄內，若 Atom 有確實的紀錄你的筆記，可以試著找找 `000XXX.log` 相關的紀錄檔案，並且使用 Linux 上的 `dd` 工具將檔案內容復原，就有機會找回遺失的內容：

```bash
dd conv=swab < 000715.log > file.txt
```

Reference:

- [Atom][atom]
- [Unsaved buffers aren't restored if there is no project folder added to the window][recover-atom-unsaved-buffer]

[atom]: https://atom.io/
[recover-atom-unsaved-buffer]: https://github.com/atom/atom/issues/10474#issuecomment-239214969j
