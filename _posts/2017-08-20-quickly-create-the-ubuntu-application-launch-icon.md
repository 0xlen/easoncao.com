---
layout: post
title: "快速建立 ubuntu 應用程式啟動圖示"
description: "Quickly create the ubuntu application launch icon"
tags: [ubuntu]
---

## 建立 ubuntu 應用程式啟動圖示

在以下任意目錄建立 `.desktop` 檔案能夠協助你建立 ubuntu 應用程式啟動圖示

- `~/.gnome/apps`
- `~/.local/share/applications/`
- `/usr/share/applications/`

例如: 在 `~/.local/share/applications` 建立 `myapp.desktop`

`myapp.desktop`

```
[Desktop Entry]
Name=MyApp
Comment=Application launcher for my execution
Exec=/path/to/executable_file
Icon=/path/to/icon
Terminal=false
Type=Application
Categories=Network;
```

Reference:

- [ubuntu documentation - UnityLaunchersAndDesktopFiles][1]

[1]: https://help.ubuntu.com/community/UnityLaunchersAndDesktopFiles
