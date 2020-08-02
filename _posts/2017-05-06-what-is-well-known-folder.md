---
layout: post
title: "解析 .well-known 資料夾"
description: "What is /.well-known/ folder? "
tags: [networking]
---

## What is /.well-known/ ?

繼 [Let's Encrypt][1] 提供公眾能夠使用免費SSL簽章服務，在安裝過程發現會產生 `.well-known` 資料夾，於是好奇之下就展開了解答尋找之路。


`.well-known` 目錄正式在 [RFC5785][2] 被提出，

隨著 WWW 的 Protocol 越來越多，

若 Server 與 Client 雙方需要進行資訊交換時通常必須建立在 TCP / IP 的基礎上進行，常見的作法像是 HTTPS 以 443 Port 進行資訊上的交換、Handshake等，

即使是 HTTP / HTTPS Protocol ，共同定義的 Header 無法提供更足夠的資訊滿足不同 Client-side 的需求，

更何況網際網路的傳輸中，一個 Packet 長度基本上是有限的，單純的 Server-side application 越來越無法現今網際網路的環境，

Client 要足以得知 Server side 的 metadata ，便共同定義了 `.well-known` 是被許可的子目錄及 URI。

常見的例子像是：

- `/.well-known/acme-challenge/` : Let's Encrypt 用於驗證憑證所有者的有效性，ACME 指的是 [Automatic Certificate Management Environment][3]
- `/.well-known/assetlinks.json` : [Digital Asset Links][4]，像是用於網站告知 Android 系統應該用什麼樣的 app 開啟
- `/.well-known/apple-app-site-association` : [Universal Links][5]，類似 Digital Asset Links，主要用於 iOS 識別使用的 metadata 。


Reference:

- [For what is the “.well-known”-folder?][6]
- [The “.well-known” directory on webservers (aka: RFC 5785)][7]

[1]: https://letsencrypt.org/
[2]: https://tools.ietf.org/html/rfc5785
[3]: https://github.com/ietf-wg-acme/acme/
[4]: https://developers.google.com/digital-asset-links/v1/getting-started
[5]: https://developer.apple.com/library/content/documentation/General/Conceptual/AppSearch/UniversalLinks.html
[6]: https://serverfault.com/questions/795467/for-what-is-the-well-known-folder
[7]: https://ma.ttias.be/well-known-directory-webservers-aka-rfc-5785/
