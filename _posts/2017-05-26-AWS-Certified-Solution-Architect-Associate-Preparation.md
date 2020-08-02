---
layout: post
title: "AWS Certified Solution Architect Associate 認證考試準備及心得"
description: "AWS Certified Solution Architect Associate Preparation"
og_image: "aws-saa-cert.png"
tags: ['aws', 'certificate']
---

{% include figure image_path="/assets/images/aws-saa-cert.png" alt="https://www.certmetrics.com/amazon/public/badge.aspx?i=1&t=c&d=2017-05-19&ci=AWS00264275" caption="AWS Solutions Architect Associate" %}

## 關於考前準備

自考試之前其實我完全沒有過 AWS ，直到去年年底才開始接觸並且使用 AWS 平台，

準備這張大概花了一個月的時間準備，希望能給有意願準備這張認證的人一點參考方向。


## 認證有效期

因為雲端技術不斷的推陳出新，Amazon Web Services 設定這張認證的有效期為**兩年**。


## 費用

考試費用為 `150 USD` 並不便宜，建議大家可以準備充裕點再去考試才不會白白浪費了錢。


## 測驗語文、形式、題數及時間

- 考試語言：我報名時選擇的是英文 (不過現在也有提供中文的試卷)
- 考試形式：選擇題、多選題
- 考試題數：約 60 題
- 考試時間：80 分鐘
- 及格分數：AWS 認證會依照每次考試的統計分佈進行篩選，當然及格分數抓在 70% 比較保險。

[範例試題][0]

**作答完會詢問是否要填寫問卷，我直接跳過了。**


## 重點準備

準備考試前建議先了解一次考試的幾個大方向，考試官方頁面可以參考 [AWS 官方的認證頁面][1] ，

- (1.0) Designing highly available, cost-efficient, fault-tolerant, scalable systems (60%)
- (2.0) Implementation/Deployment (10%)
- (3.0) Data Security (20%)
- (4.0) Troubleshooting (10%)
 
詳細內容可以讀過一次 [Blueprint][2] 得到更詳細的資訊。

其中我個人考試的經驗，第一項 HA 及 第四項 Security 真的非常重要，當然考什麼樣的應用還是運氣成份為重，

尤其像我考的時候 IAM 的部份考蠻大的比重，連 Active Directory 都出現了，Snapshot、EBS Encryption 等等也考得我滿身汗，

或是像 ec2 instance 如果應用於 MySQL database 的情境，如何同時兼顧 cost-efficient 及 fault-tolerant 等等問題，這部份除了會有用 AWS 的 Solutions 外可能也會出現像是使用 RAID 等等的情境。

如果像我一樣完全沒有使用過 AWS ，非常推薦趁 Udemy 有特價的時候一次買好 [acloud guru][3] 推出的 [AWS Certified Solutions Architect - Associate 2017][4]，

能夠有系統性的幫助入門了解整個 AWS Cloud ，而且 Udemy 時不時有特價及優惠碼，一次購入原價 NTD$ 7, 000 的課程 NTD$ 300 左右就可以買到。

利用 Udemy App ，我每天早上坐捷運的時候就看個一兩個片段，累積半個月下來其實能夠很有效的理解整個 AWS Cloud 。

而且 Solution Architect Associate 的考試範圍非常的廣，廣到一個非常的難以想像，且考試會有非常多的使用情境，個人考試當天做試題也是戰戰兢兢的慎選每個答案。


推薦大家仔細閱讀過幾個重點服務的 FAQ 常見問答集，有些問題很容易被考出來。

- VPC (Internet Gateway / NAT 會出現在 Troubleshooting 的問題)
- EC2 (AMI / AutoScaling / ELB / ALB / Spot, Reserved, On-demand 差別)
- EBS (Snapshot)
- S3 (Glacier / RRS / IA / Eventual Consistency)
- IAM (User / Group / Role)
- RDS
- SQS
- DynamoDB
- Route53 (Alias / Zone Apex / Routing Policies)


## Whitepaper

很多心得可能都推薦大家讀 Whitepaper ，但是 Whitepaper 其實內容不少，所以我考前也是抓 Security Whitepaper 大略看看而已，

當然還是推薦大家仔細閱讀裡面的內容，在解決架構上的設計能有一定的幫助。

- [AWS whitepapers][5]
- [AWS Overview][6]
- [AWS Security Best Practices][7]


考試過程建議大家遇到太長或是不懂的題目先做個 Mark 跳過，先把握拿到比較容易拿的分數，做過一遍後再回來檢查也會比較沒壓力。

最後，祝大家考試順利。


[0]: http://awstrainingandcertification.s3.amazonaws.com/production/AWS_certified_solutions_architect_associate_examsample.pdf
[1]: https://aws.amazon.com/tw/certification/certified-solutions-architect-associate/
[2]: https://d0.awsstatic.com/training-and-certification/docs-sa-assoc/AWS_certified_solutions_architect_associate_blueprint.pdf
[3]: https://acloud.guru/
[4]: https://www.udemy.com/aws-certified-solutions-architect-associate/
[5]: https://aws.amazon.com/tw/whitepapers/
[6]: https://d0.awsstatic.com/whitepapers/aws-overview.pdf
[7]: https://d0.awsstatic.com/whitepapers/Security/AWS_Security_Best_Practices.pdf
