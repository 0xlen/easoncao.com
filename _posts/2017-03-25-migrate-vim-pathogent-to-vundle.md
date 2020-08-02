---
layout: post
title: "從 vim pathogen 無痛轉移到 vundle"
description: "Migrate vim-pathogen to vundle"
tags: [vim]
---

## 取得 Vundle

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## 在 .vimrc 內啟用 vundle 及 要安裝的Plugins

```vim
" be iMproved, required
set nocompatible

" required
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
```

相關範例可以參考[我的vim設定檔][1]得到更多資訊

## 安裝 Plugins

打開 vim 後運行 `:PluginInstall`


Reference:

- [我的vim設定檔][1]
- [Vundle][2]
- [Swapping Pathogen for Vundle][3]

[1]: https://github.com/0xlen/vimrc/blob/master/.vimrc
[2]: https://github.com/VundleVim/Vundle.vim
[3]: http://tilvim.com/2013/12/28/pathogen-for-vundle.html
