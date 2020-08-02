---
layout: post
title: "中華電信hinet 申請及設定IPv6 (DSL-7740C)"
description: "中華電信Hinet設定IPv6, 以D-Link DSL-7740C為例"
og_image: "/assets/images/posts/2016/11/hinet-ipv6/ping-facebook-v6.png"
tags: [hinet, ipv6, dlink]
---

{% include figure image_path="/assets/images/posts/2016/11/hinet-ipv6/ping-facebook-v6.png" caption="Ping facebook using IPv6" alt="Ping facebook IPv6" %}

## 前情提要

因為近期hinet的路由走國外海纜一直發生掉包的情形,

不管是facebook, slideshare很多有走相關國外CDN都傳出災情，

所以就不小心申請了IPv6,

希望這陣子藉著走IPv6的路由節點壓壓驚,

當然最主要的原因還是想申請IPv6玩玩看,

申請的程序也不需要跑中華電信營業門市,

藉這個機會就給他申請了.

> 後來神人我朋友[魯哲](https://lucher.club/) 
>
> [分享了一篇hinet的公告](http://www.hinet.net/notifyPage.html?id=1581ecec33a000004a4f&type=0)
>
> 看來會不平靜一陣子.


## 申請IPv6

這部份原本想截圖, 不過發現申請過後沒辦法照正常的程序跑一遍,

所以申請步驟還是麻煩詳細參照一下[這邊的步驟](https://sofree.cc/hinet-ipv6/),

後面就主要著墨在Router端的設定,

當初11/3半夜線上申請,

以為收到mail通知申請程序就以為馬上就開通IPv6 dual stack的功能了,

還在傻傻的想說設定怎麼跑出來,

隔天11/4早上課上到一半hinet透過電話主動通知我,

告知機房已經完成IPv6 dual stack的設定了,

效率其實蠻快的.

## 進入D-Link DSL-7740C設定頁面

當初申請光世代100M/40M裝機人員所使用的機種正是D-Link DSL-7740C

我目前申請的位置沒辦法直接跑100M/40M,

必須透過50M兩條並行傳輸, 對我來說是蠻新鮮的,

特別是拿到Router後, 一連進去設定頁面發現其實功能蠻強大的,

只是一直沒有好好玩它XD

(要連進去小烏龜通常使用192.168.1.1這組IP在LAN的環境下應該就能正常進入)

(若不行則要先檢查一下default gateway是什麼去找出小烏龜的IP)

相關的帳號密碼會依據申請hinet的營業位置有不同的設定,

> 帳號: cht  
> 密碼(北區): chtnvdsl  
> 密碼(中區): chtcvdsl  
> 密碼(南區): chtsvdsl

## 確認設定的帳號

申請hinet網路服務後, 營業處應該都會發一組**HN號碼**及**HN密碼**,

用於PPPoE驗證連線使用,

一般光世代浮動用戶帳號格式為: HN號碼@hinet.net (固定ip用戶則為@ip.hinet.net)

礙於個資法規定, 通常hinet裝機人員到府裝機設定時都會用一組**@wifi.hinet.net**的帳號密碼,

**wifi.hinet.net**跟**hinet.net**兩組的密碼是不同的,

**wifi.hinet.net**是方便裝機人員能直接進行網路設定, 密碼通常只有該營業處能得知,

而且稍微爬過資料得知這組帳號可能會發生**沒有辦法拿到IPv6位址的情況** (當然說不定也可以),

帳號設定就請使用@hinet.net為主,

## WAN介面及帳號設定

進到WAN Setup頁面可以看到4個interface (WAN1_4是我自己設定的),

{% include figure image_path="/assets/images/posts/2016/11/hinet-ipv6/wan.png" caption="WAN設定" alt="WAN設定" %}

其中WAN1_2是原本hinet裝機人員設定的,

裡面設定的帳戶就是@wifi.hinet.net.

{% include figure image_path="/assets/images/posts/2016/11/hinet-ipv6/wan1_2.png" alt="WAN1_2" %}

因為在設定的時候不希望影響原有的網路設定,

在WAN Setup頁面按下Add按鈕,

**另外新增了一個interface WAN1_4**, 帳號使用@hinet.net,

{% include figure image_path="/assets/images/posts/2016/11/hinet-ipv6/wan1_4.png" alt="WAN1_4設定" %}

以下是相關設定 (**如果是直接更改原本就有的 wifi.hinet.net 帳號則只須更改 2. 即可**)

1. WAN Setting 選擇 PPPoE
2. username填入 HN號碼@hinet.net
3. password/confirm password填入對應的密碼
4. Default Route打勾 (確定能正常connect之後建議再將這個選項打勾)
5. Connect mode select 

    (可以先選Manual, 確認測試沒問題再設定成Connect-on demand)

> 若要手動測試interface可不可以正確透過PPPoE獲得IP,
>
> 至 STATUS > INTERNET STATUS 內的 Connection 選擇對應的界面後,
>
> 按下Connect / Disconnect按鈕進行測試

## 設定IPv6

1. 確認帳戶設定沒問題後, **將新增的interface設定為Defalt Route** (參照前面的帳號設定步驟 4.)

    (**若是直接改裝機人員預設的帳號密碼則不用做這個動作, 因為預設就有勾選這個設定**)

2. 原本上網的介面就會被設定為新介面上網, 確認是否有正確從hinet機房獲得到IPv4的位址

3. 進入IPv6設定頁面, 照以下方式設定

    - IPV6 CONNECTION TYPE
        - My IPv6 Interface is : 設定hinet帳戶的介面 (預設就是Default Route)
        - My IPv6 Connection is : PPPoE (以PPP連線進行驗證並以dual stack方式上網)
        - IPv6 Enable : 勾選

    - IPV6 DNS SETTINGS
        - 選擇 Use the following IPv6 DNS servers
        - Primary IPv6 DNS Address : 2001:4860:4860::8888    (Google public IPv6 DNS)
        - Secondary IPv6 DNS Address : 2001:4860:4860::8844  (Google public IPv6 DNS)

    - LAN IPV6 ADDRESS SETTINGS
        - Enable DHCP-PD : 勾選

    - ADDRESS AUTOCONFIGURATION SETTINGS
        - Autoconfiguration Type : SLAAC+Stateless DHCP (也可以使用不同的方式, 建議使用SLAAC+Stateless DHCP, 支援的設備較多)

    設定參考
    {% include figure image_path="/assets/images/posts/2016/11/hinet-ipv6/ipv6-settings.png" alt="IPv6 設定" %}

4. 按下 Add/Apply

5. Reboot 重新啟動 DSL-7740C

6. 進入STATUS > IPv6就會顯示相關IPv6資訊了

    {% include figure image_path="/assets/images/posts/2016/11/hinet-ipv6/ipv6-status.png" caption="IPv6 Status" alt="IPv6 Status" %}

7. 至[test-ipv6.com](http://test-ipv6.com)進行測試

    {% include figure image_path="/assets/images/posts/2016/11/hinet-ipv6/test-ipv6.png" alt="Test IPv6" %}

## 部份問題

- 透過Wi-Fi上網的設備有時候可能會發生DHCP無法正確給DNS的狀況,  
  可能是DSL-7740C firmware bug, 建議手動綁一下DNS就可以解決了.

