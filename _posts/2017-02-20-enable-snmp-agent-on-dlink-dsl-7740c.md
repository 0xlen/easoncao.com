---
layout: post
title: "D-Link DSL-7740C 啟用 SNMP"
description: "Enable SNMP Agent on D-Link DSL-7740C step by step."
tags: [dlink, hinet]
---

一般光纖 100M/40M 家用網路的使用者若想要進行網路流量、路由器監控，

可以在中華電信的 DSL-7740C 啟用 SNMP Agent 達到監控的目的。

首先進入 DSL-7740C 設定畫面，相關帳號密碼可詳閱 [上一篇的設定](https://blog.lenlabs.com/posts/setup-hinet-ipv6-with-dsl-7740c)，


- 進入 Advanced > SNMP 頁面

    將 SNMP Agent 設為 `enable`，並自行選擇是否要啟用 SNMP Trap 。

{% include figure image_path="/assets/images/posts/2017/02/enable-snmp-agent-on-dlink-dsl-7740c/snmp-agent-setting.png" caption="DSL-7740C SNMP setting page" alt="DSL-7740C SNMP setting page" %}


- 注意 MAINTENANCE > ACL 頁面

    `Service settings` 底下的 Service，找到 `SNMP` 將 `LAN` 一欄必須勾選 `enable` 才能在區域網路連線中使用 SNMP 協定

    (恰巧用 nmap 發現預設 ACL 會將 SNMP 過濾，踩了很久的雷)

{% include figure image_path="/assets/images/posts/2017/02/enable-snmp-agent-on-dlink-dsl-7740c/acl-settings.png" caption="DSL-7740C ACL setting page" alt="DSL-7740C ACL setting page" %}


# 測試是否正確設定：

以下範例為使用 snmpwalk 進行尋訪 `192.168.1.1`, version `2c`, community 為 `public`。

```bash
snmpwalk -c public -v 2c 192.168.1.1
```

執行結果：

{% include figure image_path="/assets/images/posts/2017/02/enable-snmp-agent-on-dlink-dsl-7740c/snmpwalk-example.png" alt="snmpwalk example" %}

