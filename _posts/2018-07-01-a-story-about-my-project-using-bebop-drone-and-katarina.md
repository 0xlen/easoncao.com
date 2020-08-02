---
layout: post
title: "一個關於我大學專題的故事 - 四軸無人機專案 Parrot Bebop Drone 和 Python library Katarina"
description: "A story about my student project of undergraduate degree, a Bebop Drone and Open Source library - Katarina"
tags: ['python', 'drone']
---

## 前言

大學四年的學習歷程即將告一個段落，邁入人生下個階段，趁著幾天空閒的時間將這些記憶跟過程付諸文章，紀錄自己那些年不凡且獨特的過往。

## 一個關於無人飛機的專案

在台灣普及的大學學程裡面，大部分都納入了專題研究相關的課程內容，一旦升上大三，通常不管是哪個系所，幾乎開始動工進行專題的工作。可能有很多學生或是系所會將專題視為大學四年內的學習成果，非常重視，不過，畢竟每個學期都在完成不同類型的專案，相對於我自己大一每學期都有專案跟每週都有寫不完的程式相比，對於投入專題工作的心情，其實感受不大，覺得只是在未完成清單裡面多加一項「專題」的待辦事項，加上在實習公司內也有其他重要的事情需要完成，所以對於專題的投入比例並沒有太高，純粹當個好玩的業餘項目在研究。偶而有報告或是接近截止日期時相對投入些，所以就更無憂無慮的可以專心研究自己想深鑽的內容。

雖然心裡這樣說說，但是還是會想著：當然可以也稍微努力做一下，有得獎是好事，沒得獎就算了。於是抱持著這樣的心態選定我自己有興趣的專案題目，尤其我對於影像視覺相關的研究領域很感興趣，從高中開始就使用 OpenCV 做相關的應用，不過這個領域並不是我最擅長的項目，於是乎，既然有這樣的研究機會，我二話不說在大三差不多能找專題老師的時機，就跟同學組隊找了影像視覺應用研究領域的教授來指導我們的專題內容。當初與實驗室教授選定專案題目時，異想天開想搞跟電梯有關的專案，不過後來想想還是有點無用所以中途就換了其他題目，當然也是搞個自己想玩的項目：無人機。

這一搞還好，一玩下去不得了，坑特別多。首先，一般市售的家用無人機，基本上是除了飛行之外能應用於研究實驗用的功能真的是極為稀少，我們從實驗室借到的無人機產品是 2015 主打一般消費市場的飛機，基本上，就是一台遙控飛機在天上飛附上一組鏡頭，而對於飛機所擁有的感測器及軟體，有非常大的不足需要克服。

{% include figure image_path="/assets/images/posts/2018/07/bebop-drone-and-katarina/bebop-drone-product.png" caption="Parrot Bebop Drone" alt="Parrot Bebop Drone" %}

(Photo credit: [Parrot](https://www.parrot.com/us))

Specification
- Video: full HD 1080p
- GPS: Yes
- Processor: Dual core processor with quad-core GPU
- Storage: 8 GB flash storage system
- Video resolution: 1920 x 1080p (30 fps)
- Photo resolution: 4096 x 3072 pixels
- Video encoding: H264
- Wi-Fi 802.11a/b/g/n/ac
- Wi-Fi Aerials: 2.4 and 5 GHz dual dipole aerials
- SDK Release

Product reference
- [Amazon: Parrot Bebop drone](https://www.amazon.com/Parrot-Bebop-Quadcopter-Drone-Red/dp/B00OOR9060)

你可以下載官方提供的 App，就可以透過 Wi-Fi 的方式與無人機進行連線，以手持的方式遙控飛機。那麼一般手持裝置是如何做到控制飛機的？其實背後技術原理是透過發送含有指令的 UDP 封包進行飛機的控制，例如前後左右、旋轉角度等。

一開始打算使用 GitHub 上一些新奇的專案和語言來實做，但是考量我與夥伴由於同時要實習還要兼顧一大堆作業課業報告的緣故，每週能夠開發研究的時間就顯得特別寶貴，於是為了提高開發的速度，我決定使用彼此熟悉的語言和豐富成熟的框架來進行應用的實作：

- Python 2.6
- OpenCV: 負責影像運算和辨識
- [Flask][flask]: 網頁控制介面開發
- Python library for Bebop Drone - [katarina][katarina]: 處理無人機控制飛行和決策

Katarina 是一個開源的 Python 函式庫，是由一群捷克的開發者組成的 Robotika 底下的一項項目，老實說我不是特別清楚團隊的成員背景，但是秉持開源的精神，還是十分感謝他們貢獻這項專案。該項目主要是針對 Parrot 無人機公司釋出的 [SDK][Parrot-SDK3] 提供 Python 的接口，使得 Python 開發者能夠利用熟悉的語言控制該公司的無人機產品。

## 於是，我改改了幾行代碼

但是這個坑一踩，才知道有多大洞。整個專案最讓我詬病的是，飛機本身的限制造成在專案研究過程很大的障礙，需要逐一克服：

- 一旦飛機超出一定範圍，Wi-Fi 連線延遲會拉高，影像的回傳就會產生延遲，此時進行的飛行決策很可能是錯誤的。
- 無人飛機透過四個軸的飛行槳控制，保持飛行的穩定以維持一定的平衡，然而，對於家用的無人機來說，並不能保證其穩定的順暢，很可能因為風阻或是干擾等其他因素飛機會不斷飄移。
- 由於帶動四軸飛行槳時，馬達運轉需要大量的功耗，然而，家用無人機所攜帶的電池飛行的時間有限，一顆要充將近一小時的電池僅夠支撐室內約 15 - 20 分鐘的飛行，往往研究還沒正式開始測試或是取得需要的數據就得先行換備用電池，不斷的在考驗人性。
- 飛機為了保持飛行的穩定，其機身設計採用流線型並且限制重量，一旦超出負重，當在空中起飛並盤旋時，飛機會失去本身機身的穩定，所以難以附掛額外的零組件或是電池。
- 飛機的本身運算能力有限，飛行同時要在飛機本身分析影像內容是一項考驗運算能力和電力的一項挑戰。

同時，最嚴重的是，我發現 Katarina 固然提供豐富的控制方法，然而，他原本使用的影像串流方式十分、十分的慢。回傳的影像可以說是飛機五秒前的位置，一旦 Wi-Fi 傳輸距離與影像串流分析的機器過遠，基本上你就不知道飛機目前飄到那去了。由於我的專案需要即時的影像回饋進行飛機的飛行決策，一旦偵測到目標物體就會往物體靠近飛行並且滯留。如果現在回傳的影像是五秒前的，由於上述提到的致命缺點，飛機很可能因為不穩定已經往左右或其他方向飄移，這時若飛行決策的邏輯還送出飛行指令驅使飛機往該方向前進，一旦附近有障礙物，肯定撞機。所以一旦有幾秒以上的延遲，都是十分致命的。

就算將所有障礙物清空，撇除障礙物問題，還是必須要克服影像串流造成的延遲，因為飛機的位置不一定會是影像當時回饋的相對位置，這都會影響飛行決策是否能正確的往目標物體靠近。但是 Katarina 本身的串流方式就有很大的延遲問題，在 GitHub 上面也有一些關於這個問題的討論：

- [GitHub issue#3: Improving Speed for Receiving Real-Time Image](https://github.com/robotika/katarina/issues/3)

經過一番深入研究和測試，我注意到 Parrot 官方提供的 SDK 內其實有配置 RTP 串流的協議和對應的連線資訊：

```cpp
#define ARDISCOVERY_CONNECTION_JSON_ARSTREAM2_CLIENT_STREAM_PORT_KEY "arstream2_client_stream_port"
#define ARDISCOVERY_CONNECTION_JSON_ARSTREAM2_CLIENT_CONTROL_PORT_KEY "arstream2_client_control_port"
#define ARDISCOVERY_CONNECTION_JSON_ARSTREAM2_SERVER_STREAM_PORT_KEY "arstream2_server_stream_port"
#define ARDISCOVERY_CONNECTION_JSON_ARSTREAM2_SERVER_CONTROL_PORT_KEY "arstream2_server_control_port"
```

- [libARDiscovery](https://github.com/Parrot-Developers/libARDiscovery/blob/2eb8441bd1834928cd77b3ce4f4dddee4434f024/Includes/libARDiscovery/ARDISCOVERY_Connection.h#L58)
- [Parrot-Developers-Stream](https://github.com/Parrot-Developers/application_notes/blob/5fd43c383ad58a2763f31f58c85f5f1e6ab6877b/BebopStreamVLC/BebopDroneStartStream.c#L551)

此外，我也在網路上找到很有趣的一篇文章：[Stream Bebop Video With Python Opencv][rtp-stream-using-python]，這個範例使用 Python 去執行另一個開源一樣提供給 Bebop 以 Node.js 寫成的 [node-bebop][node-bebop] 專案，利用呼叫 Node.js 版本的函式庫內提供的串流方法進行 RTP 串流，實際上，是蠻有趣的作法。

於是，我就嘗試改改了幾行代碼，經過我的測試並應用在我的專題內，送了一個 Pull Request 給了作者，在與無人機連接時送出必要的影像訊息，在執行時能夠使用 RTP 串流的方式接收影像：

- [GitHub pull request#14: Enable RTP Streaming on Bebop and add sample code](https://github.com/robotika/katarina/pull/14)

不久，我就收到了來自 Robotika 的問候：

{% include figure image_path="/assets/images/posts/2018/07/bebop-drone-and-katarina/email-from-robotika-about-katarina.png" caption="Email from Robotika about Katarina project" alt="Email from Robotika about Katarina project" %}

在我回覆不久，Robotika 的 Martin 就將我的 Pull request 合併進專案內，成為該專案目前唯一一個 Pull request。

## 收穫？

串流問題解決了，一般來說，OpenCV 的應用程式往往都是單執行緒的運算方式，獲取單張影像後進行運算和特徵判斷，但是這樣的方法往往會在運算速度的緣故發生一些效能瓶頸。於是，我又透過改寫程式利用一些多執行緒的處理技巧，搭配在應用程式裡面設計 Queue 的邏輯，使得接收串流影像是一個單元，真正進行影像判斷和飛行決策的則是另外的單元，並且加入一些判斷機制，盡可能降低因為串流產生的延遲造成的錯誤飛行決策。

不過由於飛機的限制，並沒有深度等等的感測器，整個專案困難的部分也包含影像飛行對於實際距離換算的方法，經過一系列的微調和測試，完成了一個 PoC 的版本：

{% include video id="n7VqhPPqlpY" provider="youtube" %}

(這個影片給幾個同學看過後，都被開玩笑其實我們的專題不是無人機收費，比較像是無人飛行武器開發，精準投遞摧毀目標 ... lol)

專題展示前幾天至當天早上，我還與夥伴玩起黑客松，逐一的將沒有完成的介面進行收尾以利當天的展示，十分感謝這些年來大大小小專案的磨練，已經練就開始前幾個小時甚至 Demo 當下還在送 Commit / 改程式的功力，不過既然是當成業餘的項目，開心好玩並且從中收穫最重要，比賽反而是其次了。

最後，我並沒有得獎，也許在評審委員教授的眼裡，看見的應用價值是商機和獲獎的必要條件。但是，對我來說，這個專題帶給我的並不是這樣表面的效益和回饋，而是在重重的困難和限制下對於盡力完成研究的方法和價值。我的幾行代碼，卻是貢獻是數個全世界使用 Bebop drone 和 Katarina 的無人機玩家們，即便在不同的國家，我們卻用著相同的語言和同樣的精神在交流、共同解決相同的問題，其所成就感已經超越單一個專題的獎項所帶來的滿足。

我想，這就是一項成就解鎖吧!

[katarina]: https://github.com/robotika/katarina
[flask]: http://flask.pocoo.org/
[Parrot-SDK3]: http://developer.parrot.com/docs/SDK3/
[rtp-stream-using-python]: http://cvdrone.de/stream-bebop-video-with-python-opencv.html
[node-bebop]: https://github.com/hybridgroup/node-bebop
