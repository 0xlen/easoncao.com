---
layout: post
title: "在 PHP FastCGI 環境下自訂使用者的 php.ini 設定"
description: "如何在 PHP FastCGI 環境下自訂使用者的 php.ini 設定，使每個使用者有獨立的設定檔"
og_image: "/assets/images/posts/2017/01/php-fastcgi-config-with-custom-php-ini/setting.png"
tags: [php, apache]
---

{% include figure image_path="/assets/images/posts/2017/01/php-fastcgi-config-with-custom-php-ini/setting.png" alt="PHP FastCGI Settings" %}

# 前言

因為自己興趣使然有在玩 VPS，雖然不排斥指令界面，

但有時候會沒睡飽不小心下錯指令，也有時候避免不了各設定檔互向關聯，當腦袋還沒清醒時去動 Production 的機器簡直超級悲劇，

因為玩玩的機器，沒打算買 cPanel 授權，所以我過去一直使用 Kloxo 當作我的 Panel，除了能更直覺的了解現在的設定外也能避免一些設定上的慘案。

自從歷經幾次的 Kloxo 漏洞被打實錄後，有了一些慘痛的教訓，

而且官方團隊也在 6.1.19 版本後正式宣告不維護，所以就跳槽到現在的 webmin + virtualmin 環境一陣子了。

Virtualmin 出乎我意外的好用，而且設定相比 Kloxo 也直覺多了，

從 Kloxo 到現在在用 Virtualmin 的過程中，不免會對設定很好奇，所以花了一點時間研究設定檔，紀錄一下。

# 環境

```bash
Server version: Apache/2.4.6 (CentOS)
PHP: PHP 5.4.16 (Default) / PHP 5.5.21 / PHP 5.6.5
Panel: Webmin (1.831) + Virtualmin (5.05)
```

(關於多個 php 版本的設定有機會再來補個文章，可詳見[Red Hat Software Collections](https://www.softwarecollections.org/en/))

# 設定

Apache (http)

```
<Directory /home/user/public_html>
    Options -Indexes +IncludesNOEXEC +SymLinksIfOwnerMatch +ExecCGI
    allow from all
    AllowOverride All Options=ExecCGI,Includes,IncludesNOEXEC,Indexes,MultiViews,SymLinksIfOwnerMatch
    Require all granted
    AddType application/x-httpd-php .php
    AddHandler fcgid-script .php
    AddHandler fcgid-script .php5
    AddHandler fcgid-script .php5.5
    AddHandler fcgid-script .php5.6
    FCGIWrapper /home/user/fcgi-bin/php5.5.fcgi .php
    FCGIWrapper /home/user/fcgi-bin/php5.fcgi .php5
    FCGIWrapper /home/user/fcgi-bin/php5.5.fcgi .php5.5
    FCGIWrapper /home/user/fcgi-bin/php5.6.fcgi .php5.6
</Directory>
```

新增 wrapper script `/home/user/fcgi-bin/php5.fcgi`

```bash
#!/bin/bash
PHPRC=$PWD/../etc/php5
export PHPRC
umask 022
export PHP_FCGI_CHILDREN
PHP_FCGI_MAX_REQUESTS=99999
export PHP_FCGI_MAX_REQUESTS
SCRIPT_FILENAME=$PATH_TRANSLATED
export SCRIPT_FILENAME
exec /bin/php-cgi
```

複製 `php.ini` 至 `/home/user/etc/php5`

```bash
cd /home/user/etc/php5
cp -a /etc/php.ini .
chown user:user php.ini
```

確認FastCGI wrapper script權限是否設定正確

```bash
chown user:user php5.fcgi && chmod 0755 php5.fcgi
```

重新啟動Apache

```bash
service apache restart
```

參考資料：
- [Using Custom php.ini with PHP5 under FastCGI](https://www.ndchost.com/wiki/cpanel/custom-php-ini-fastcgi)
