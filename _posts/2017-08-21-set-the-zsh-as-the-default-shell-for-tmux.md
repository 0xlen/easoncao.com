---
layout: post
title: "設定 zsh 為 tmux 預設的 shell"
description: "Set the zsh as the default shell for tmux"
tags: [Linux]
---

## 設定 tmux 使用的 shell

自從從 screen 無痛轉移到 [tmux](0) 後，tmux 強大的功能性實在是令人愛不釋手，這邊筆記一下如何更換 tmux 啟動新的 session 時預設的 shell 。

in ~/.tmux.conf or . Works on Fedora.

使用編輯器開啟 `~/.tmux.conf`，如果沒有可以新增一個。或是修改 `/etc/tmux.conf` 設定所有使用者預設的 tmux 設定檔。

新增以下內容:
```conf
set-option -g default-shell /bin/zsh
```

如果不是使用 zsh ，也可以將 `/bin/zsh` 換成慣用的 shell，例如: `/bin/bash`、`/bin/csh` 等。



Reference:

- [tmux][0]
- [How can I make tmux use my default shell][1]

[0]: https://tmux.github.io/
[1]: https://superuser.com/questions/253786/how-can-i-make-tmux-use-my-default-shell
