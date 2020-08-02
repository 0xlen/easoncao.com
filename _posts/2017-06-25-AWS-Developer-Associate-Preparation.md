---
layout: post
title: "AWS Certified Developer Associate 認證考試準備及心得"
description: "AWS Certified Developer Associate Preparation"
og_image: "aws-da-cert.png"
tags: ['aws', 'certificate']
---

{% include figure image_path="/assets/images/aws-da-cert.png" alt="https://www.certmetrics.com/amazon/public/badge.aspx?i=2&t=c&d=2017-06-25&ci=AWS00264275" caption="AWS Solutions Architect Associate" %}

## 關於考前準備

相比前一個 SA 認證，其實沒什麼準備，這樣講好像有點不負責任。的確，因為考試時間跟學校期末考疊在一起，所以沒有像考 Solution Architect Associate 那麼仔細的唸。

題目的範圍考比較多 DynamoDB 及 SDK / API 的使用，如果之前跟我一樣有先考過 [Solution Architect Associate][0] 準備起來會比較輕鬆一點。

考試前一定要花點時間了解 DynamoDB 的 Read / Write Provision Throuput 怎麼計算，考試會考非常多的 Global Index / Sencondary Index 相關的問題。


## 認證有效期

與 [Solution Architect Associate][0] 一樣是**兩年**。


## 費用

考試費用為 `150 USD` (建議大家可以準備充裕點再去考試才不會白白浪費了錢)

## 考試地點

恆逸教育訓練中心有提供 AWS 認證的考試考場，詳細內容可以參考考試報名。


## 測驗語文、形式、題數及時間

- 考試語言：英文 (如果英文怕影響作答可以在報名時選擇中文的試卷)
- 考試形式：選擇題、多選題
- 考試題數：約 60 題
- 考試時間：80 分鐘
- 及格分數：建議及格分數抓在 70% 比較保險。

[範例試題][1]

**作答完會詢問是否要填寫問卷，我一樣直接跳過了。**


## 考試報名

AWS 認證目前都從 Kryterion (Webassessor) 的界面移轉到 [AWS training](https://www.aws.training/)，可以透過官方的界面進行考試的報名。


## 重點準備

考試前建議先了解一次考試的幾個大方向，考試官方頁面可以參考 [AWS 官方的認證頁面][2] ，[Blueprint][3] (必讀)。

- (1.0) AWS Fundamentals (10%)
- (2.0) Designing and Developing (40%)
- (3.0) Deployment and Security (30%)
- (4.0) Debugging (20%)
 

Professional experience using AWS technology
- Hands-on experience programming with AWS APIs
- Understanding of AWS Security best practices
- Understanding of automation and AWS deployment tools
- Understanding storage options and their underlying consistency models
- Excellent understanding of at least one AWS SDK 


General IT Knowledge
- Understanding of stateless and loosely coupled distributed applications
- Familiarity developing with RESTful API interfaces
- Basic understanding of relational and non-relational databases
- Familiarity with messaging & queuing services

如果具備 Solution Architect Associate / Professional 的背景的話來考這個基本上可以省一半的力氣，Developer Associate 著墨在 Architect 的部份不會太多，

AWS Fundamentals，涵蓋 EC2 / VPC / DynamoDB / SWF (Simple Work Flow) / S3 (Consistency read-after-write) / 基本的網路Troubleshooting，建議針對這些 Developer 考試內容內重點使用的服務進行比較詳細的了解。可以透過官方文件及常見問題得到很多相關的資訊。

如果像我過去沒有使用過 AWS 的經驗，可以透過 [acloud guru][4] 推出 [AWS Certified Developer - Associate 2017 課程][5] 來快速入門，

能夠有系統性的幫助入門了解 AWS 各式各樣的服務，完整的濃縮。(而且 Udemy 時不時有特價及優惠碼)

**推薦大家仔細閱讀過幾個重點服務的 FAQ 常見問答集，因為常見的問題確實就是成為考題的必要。**

- VPC (Internet Gateway / NAT 會出現在 Troubleshooting 的問題)
- EC2 (AMI / AutoScaling / ELB / ALB / Spot, Reserved, On-demand 差別)
- EBS (Snapshot)
- S3 (Glacier / RRS / IA / Eventual Consistency)
- IAM (User / Group / Role)
- RDS
- SQS
- SWF
- Lambda
- API Gateway
- DynamoDB (Index)
- Route53


## Serverless

目前考試內容我個人是沒有看到太多跟 Serverless 相關的問題，但是畢竟使用雲服務 Serverless 是不可避免的一種解決方案，有興趣的話可以多閱讀 Lambda 等服務相關的資訊。

考試內容會比較多著墨在 SDK 的使用，以及一些會使用的 API，同時 DynamoDB 一直是特別要強調一定會出現的。

考試中建議大家遇到太長或是不懂的題目先做標記跳過，先把握拿到比較容易拿的分數，做過一遍後再回來檢查也會比較沒壓力。


祝大家順利通過認證！


[0]: https://blog.lenlabs.com/posts/aws-certified-solution-architect-associate-preparation
[1]: http://awstrainingandcertification.s3.amazonaws.com/production/AWS_certified_developer_associate_examsample.pdf
[2]: https://aws.amazon.com/tw/certification/certified-developer-associate/
[3]: https://d0.awsstatic.com/training-and-certification/docs-dev-associate/AWS_certified_developer_associate_blueprint.pdf
[4]: https://acloud.guru/
[5]: https://www.udemy.com/aws-certified-developer-associate/
