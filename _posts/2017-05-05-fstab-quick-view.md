---
layout: post
title: "/etc/fstab file Quick view"
description: "Meet with /etc/fstab file in Linux"
tags: [linux]
---

## What is /etc/fstab

> The fstab(5) file can be used to define how disk partitions, various other block devices, or remote filesystems should be mounted into the filesystem.

/etc/fstab 檔案是Linux kernel在開機過程能夠得知有哪些裝置必須被掛載 (`mount`) 的重要系統檔案。

檔案格式如下：

```
# <device>             <dir>         <type>    <options>             <dump> <fsck>
/dev/sda1              /             ext4      defaults,noatime      0      1
/dev/sda2              none          swap      defaults              0      0
/dev/sda3              /home         ext4      defaults,noatime      0      2
```

- `<device>`: 要被掛載的實體裝置，或是遠端的檔案系統。
- `<dir>`: 要掛載的目錄，必須是先建立(`mkdir`)後才能正確掛載。
- `<type>`: 檔案系統格式，如`ext4`、`ext3`、`xfs`、`fat32`等等。
- `<options>`: 掛載選項，一般檔案系統在掛載時至少包含一種掛載選項(`ro` or `rw`)，`ro` 就是 read-only 僅讀取， `rw` 就是 read-write 可讀可寫，
    - `defaults`: use default options: rw, suid, dev, exec, auto, nouser, and async.
    - `noauto`: do not mount when "mount -a" is given (e.g., at boot time)
    - `user`:   allow a user to mount
    - `owner`:  allow device owner to mount
    - `nofail`: do not report errors for this device if it does not exist.
    - comment or x-<name> for use by fstab-maintaining programs

## UUID

一般檔案系統在完成格式化後會產生一組識別碼，稱為UUID (Universally Unique Identifier)，透過UUID掛載的方式能避免裝置因為更換順序(e.g. 更換硬碟的SATA插線順序)，造成原本掛載的設定因為裝置順序不同，產生跟原本預期設定不同的錯誤。

    可以使用 `lsblk -f` 或是 `file -s <device>` 輕鬆查到裝置的UUID。

```bash
$ lsblk -f

NAME   FSTYPE   LABEL      UUID                                 MOUNTPOINT
sda
├─sda1 vfat     ESP        3A32-950C                            /boot/efi
├─sda2 vfat     DIAGS      BCA2-19D3
├─sda3
├─sda4 ntfs     WINRETOOLS ECFAA35AFAA31FB6
├─sda5 ntfs                C03E97DA3E97C7B4
├─sda6 ntfs                B03C63223C62E2B8
├─sda7 ntfs                DEC05B4FC05B2D51
├─sda8 ext4                c3b19071-7163-41ea-9a8c-4069deb13649 /
└─sda9 ntfs     PBR Image  D052AA0C52A9F6FE
```

```bash
$ sudo file -s /dev/sda8
/dev/sda8: Linux rev 1.0 ext4 filesystem data, UUID=c3b19071-7163-41ea-9a8c-4069deb13649 (needs journal recovery) (extents) (large files) (huge files)
```

掛載方式也很簡單，在 `/etc/fstab` 內使用 `UUID=` 即可。

```
# <device>                                <dir> <type> <options>                         <dump> <fsck>
UUID=0a3407de-014b-458b-b5c1-848e92a327a3 /     ext4   rw,relatime,discard,data=ordered   0      1
UUID=b411dc99-f0a0-4c87-9e05-184977be8539 /home ext4   rw,relatime,discard,data=ordered   0      2
UUID=f9fe0b69-a280-415d-a03a-a32752370dee none  swap   defaults                           0      0
```


## Label

如果裝置在格式化時有設定 Label，也能使用 `LABEL=` 進行掛載。

```
# <device>      <dir> <type> <options>                                                                                            <dump> <fsck>
LABEL=EFI       /boot vfat   rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro 0      2
LABEL=SYSTEM    /     ext4   rw,relatime,discard,data=ordered                                                                     0      1
LABEL=DATA      /home ext4   rw,relatime,discard,data=ordered                                                                     0      2
LABEL=SWAP      none  swap   defaults                                                                                             0      0
```


## Reference:

- [archlinux - fstab][1]
- [fstab(5)][2]
- [UUID][2]


[1]: https://wiki.archlinux.org/index.php/fstab
[2]: http://man7.org/linux/man-pages/man5/fstab.5.html
[3]: https://zh.wikipedia.org/wiki/%E9%80%9A%E7%94%A8%E5%94%AF%E4%B8%80%E8%AF%86%E5%88%AB%E7%A0%81

