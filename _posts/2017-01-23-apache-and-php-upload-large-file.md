---
layout: post
title: "Apache / PHP 上傳大檔的注意事項"
description: "Apache / PHP 上傳大檔案的一些基本設定及注意事項"
og_image: "/assets/images/posts/2017/01/apache-and-php-upload-large-file/box.png"
tags: [php, apache]
---

{% include figure image_path="/assets/images/posts/2017/01/apache-and-php-upload-large-file/box.png" alt="Upload large file" %}

現在頻寬越來越大，ISP 提供上傳跟下載的費用也越來越便宜，

以目前大眾常使用的 100Mbps/40Mbps 家用頻寬一次傳個 300MB 的大檔也稀鬆平常。

但是像 Apache 2.4.18 及 php 預設設定仍然還卡在 20M 甚至 8M 內，

有時候應用程式需要傳大檔時這些設定不免成為瓶頸，

並不是程式有 bug ，很可能是設定上需要做一些調整，

所以自己整理一些設定的經驗作為參考，如果未來在做 trubleshooting 時可以朝以下方向著手。

# 追蹤問題

通常可以透過 Debug 錯誤訊息，`/var/log/apache`, `/var/log/apache2/`, `/var/log/httpd` 等等找到相關的錯誤及紀錄。

當問題比較難追蹤，可以試著多模擬幾次同樣的出錯流程。藉由重複產生問題，能在紀錄中找到比較明顯的表徵，並且進一步除錯。

# PHP

`php.ini` : 預設 php 設定檔內可以檢查以下設定

```apacheconf
upload_max_filesize 10M
post_max_size 15M
max_input_time 300
max_execution_time 300
```

- `upload_max_filesize` : 限制最大上傳檔案大小
- `post_max_size` : 這邊指的是 POST method 封包允許的大小，很多設定都設跟 `upload_max_filesize` 一樣，
                    但照[官方的建議][post-max-size]應該是要設得比 `upload_max_filesize` 來得大，
                    而一般來說 `memory_limit` 應該也必須比 `post_max_size` 大，才能分配足夠的記憶體空間給 POST 方法使用的變數。
- `max_input_time` : 最大的上傳允許時間。
- `max_execution_time` : PHP script 正常呼叫時允許的最大執行時間。通常上傳大檔時，因為傳輸頻寬影響，會導致接收檔案的 PHP script 執行時間過長。
                         若太短會讓伺服器中斷仍在執行傳輸的作業，使傳輸連接中斷。

如果是 shared host，主機商沒有提供更動設定檔的權限，也可以試著透過 .htaccess 檔案方式直接設定。

(注意必須要 Apache 內環境設定啟用 `AllowOverride All` 的設定才會生效，若不確定建議直接聯絡主機商確認。)

.htaccess 設定如下

```apacheconf
php_value upload_max_filesize 10M
php_value post_max_size 10M
php_value max_input_time 300
php_value max_execution_time 300
```

# Apache

除了 PHP 本身的設定外，也要注意是不是 apache 本身的設定造成傳輸瓶頸。

## 遇到 apache mod_fcgid: HTTP request length xxxxx (so far) exceeds MaxRequestLen (xxxxx)

因為傳輸大檔超過 apache 允許的最大請求長度，所以 apache 會吐這個問題。

- `/etc/apache2/mods-available/fcgid.conf` (ubuntu / debian)

在設定檔中加入或調整 `MaxRequestLen` 參數即可

```apacheconf
MaxRequestLen 15728640
```

如果環境不同，注意設定檔案通常在以下地方：
- `/etc/apache2/conf-enabled` (ubuntu / debian)
    - 注意是不是有主要的 apache2.conf 會 include `/etc/apache2/conf-available` 底下的設定，
      如果沒意外應該會 link 到 `/etc/apache2/conf-available` 底下。

- `/etc/httpd/conf/httpd.conf` (RedHat / CentOS)
    - 一樣要注意是不是有 `/etc/httpd/conf.d/*` 之類的設定檔，
      通常需要檢查一下主要的設定檔看是不是有 `Include` 關鍵字再進一步去檢查。 (推薦使用`grep -ri 'Include'`指令)


其他關於大檔案上傳的可以參考 ownCloud 官方文件 [Uploading big files > 512MB][owncloud] 一節，

裡面包含了部份 nginx 的設定，十分值得參考。

[owncloud]: https://doc.owncloud.org/server/latest/admin_manual/configuration_files/big_file_upload_configuration.html?highlight=max
[post-max-size]: http://php.net/manual/en/ini.core.php#ini.post-max-size
