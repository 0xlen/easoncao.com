---
layout: post
title: "AWS Certified SysOps Administrator - Associate 認證考試準備及心得"
description: "AWS Certified SysOps Administrator - Associate Preparation"
og_image: "aws-sysops-cert.png"
tags: ['aws', 'certificate']
---

{% include figure image_path="/assets/images/aws-sysops-cert.png" alt="https://www.certmetrics.com/amazon/public/badge.aspx?i=3&t=c&d=2017-10-18&ci=AWS00264275" caption="AWS Certified SysOps Administrator - Associate" %}

## 關於考前準備

相比前面的 [Solution Architect][aws-saa] 及 [Developer 認證][aws-da]，SysOps 比較著重在災難復原和系統監控的部分，比較困難的地方在於這個認證會有比較多長的情境題，做題時需要多花一點時間做準備。

像是 ELB 發生效能瓶頸時會需要看哪些 metrics，基本的 VPC 和 EC2 等還是會考一部分，但是比較多著墨的重點在備份的解決方案以及升級的問題。安全性面，在 Audit 的部分也會考很多 IAM 相關的問題，如果之前跟我一樣有先考過 [Solution Architect Associate][aws-saa] 和 [Developer Associate][aws-da] 準備起來就可以聚焦在比較重點性的服務，像我考試的時候就問到不少關於 CloudWatch 和 OpsWork 之類的問題。

## 認證有效期

與 [Solution Architect Associate][aws-saa]、[Developer Associate][aws-da] 一樣是**兩年**。


## 費用

考試費用為 `150 USD` (建議大家可以準備充裕點再去考試才不會白白浪費了錢)

## 考試地點

今年度九月開始 AWS 官方授權的考試代理商從 Kryterion 轉為 PSI ，這次我選擇的考試在 [Global Education Association in Taiwan (AMP)][map] (對不起我不確定中文叫什麼，應該是托福相關語言中心相關的考試代理商)。因為是語言相關的考試中心，我去考的時候，是本年度第五場，所以考場設備並沒有像恆逸提供隔間的考場，只有一台筆電和約 30 人的小教室考試。

這次考場比較嚴謹需要查驗護照，這部分在試後跟親切的~~監考姊姊~~聊了一下得知前面有三場的應試人因為沒有帶護照被拒絕考試，不過當初恆逸只需要備有身份證件即可，建議大家攜帶護照應考，如果沒有護照建議考前跟考試中心電話確認一下。

當時考試單位在考試的時候沒有提供紙筆是比較困擾的地方，考場若能使用紙筆是非常有用的，特別是題目需要畫出拓墣的時候才能勾勒出對應的系統架構。比較慘的是考試中途網路還發生斷線，虛驚一場。

不過，上述問題在考完之後也跟親切的~~監考姊姊~~反應了一下這些部分，包含反應僅需查驗身份證件和過去不用護照的問題，避免大家不要再踩到跟我一樣的坑啊！


## 測驗語文、形式、題數及時間

- 考試語言：英文 (如果英文怕影響作答可以在報名時選擇中文的試卷)
- 考試形式：選擇題、多選題
- 考試題數：約 55 題
- 考試時間：80 分鐘
- 及格分數：建議及格分數抓在 70% 比較保險。

[範例試題][example-exam]

**作答完會詢問是否要填寫問卷，我一樣直接跳過了。**


## 考試報名

可以透過官方的界面 [AWS training](https://www.aws.training/) 進行考試的報名，考試代理商為 [PSI exam](https://candidate.psiexams.com/)，


## 重點準備


考試前一定要花點時間了解一些基本服務的 metrics
- [Elastic Compute Cloud][ec2-metrics]
- [Elastic Block Storage][ebs-metrics]
- [Elastic Load Balancer][elb-metrics]
- [RDS][rds-metrics]


考試前建議先了解一次考試的幾個大方向，考試官方頁面可以參考 [AWS 官方的認證頁面][aws-sysops] ，[Blueprint][aws-sysops-blueprint] (必讀)。

- (1.0) Monitoring and Metrics (15%)
- (2.0) High Availability (15%)
- (3.0) Analysis (15%)
- (4.0) Deployment and Provisioning (15%)
- (5.0) Data Management (12%)
- (6.0) Security (15%)
- (7.0) Networking (13%)

Introduction
The AWS Certified SysOps Administrator – Associate Level exam validates a candidate’s ability to:
- Deliver the stability and scalability needed by a business on AWS
- Provision systems, services and deployment automation on AWS
- Ensure data integrity and data security on AWS technology
- Provide guidance on AWS best practices
- Understand and monitor metrics on AWS

AWS Knowledge
- Minimum of one year hands-on experience with the AWS platform
- Professional experience managing/operating production systems on AWS
- A firm grasp of the seven AWS tenets – architecting for the cloud
- Hands on experience with the AWS CLI and SDKs/API tools
- Understanding of network technologies as they relate to AWS
- Good grasp of fundamental Security concepts with hands on in experience in implementing Security controls and compliance requirements

General IT Knowledge
- 1-2 years’ experience as a systems administrator in a systems operations role
- Experience understanding virtualization technology
- Monitoring and auditing systems experience
- Knowledge of networking concepts (DNS, TCP/IP, and Firewalls)
- Ability to collaborate with developers and the general business team/company wide


AWS Fundamentals，涵蓋 EC2 / VPC / DynamoDB / SWF (Simple Work Flow) / S3 (Consistency read-after-write) / 基本的網路 Troubleshooting，一樣建議針對這些考試內容內重點使用的服務進行比較詳細的了解。可以透過官方文件及常見問題得到很多相關的資訊。

這張認證最重要的在於 HA (High Availability) 和災難復原，所以像是 RDS 會考非常多關於 Backup window / Backup strategies 相關的問題，以及 AutoScaling。

如果對於 AWS 的使用並不熟悉經驗，可以透過 [acloud guru][acloud-guru] 推出 [AWS Certified SysOps Administrator - Associate 2017][acloud-guru-sysops] 來快速入門，

能夠有系統性的幫助入門了解 AWS 各式各樣的服務，完整的濃縮。

**同樣推薦大家仔細閱讀過幾個重點服務的 FAQ 常見問答集，因為常見的問題確實就是成為考題的必要。**

- VPC (Internet Gateway / NAT 會出現在 Troubleshooting 的問題)
- EC2 (AMI / AutoScaling / ELB / ALB / Spot, Reserved, On-demand 差別)
- EBS (Snapshot)
- S3 (Glacier / RRS / IA / Eventual Consistency)
- IAM (User / Group / Role)
- RDS
- SQS
- Lambda
- API Gateway
- DynamoDB (Index)
- Route53
- Cloudwatch
- OpsWork

## 還有

考試中建議大家遇到太長或是不懂的題目先做標記跳過，特別是 SysOps 題目非常落落長，先把握拿到比較容易拿的分數，做過一遍後再回來檢查也會比較沒壓力。

祝大家順利通過認證！


[aws-saa]: /posts/aws-certified-solution-architect-associate-preparation
[aws-da]: /posts/aws-developer-associate-preparation
[elb-metrics]: http://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-cloudwatch-metrics.html
[ec2-metrics]: http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ec2-metricscollected.html
[rds-metrics]: http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/rds-metricscollected.html
[ebs-metrics]: http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ebs-metricscollected.html
[aws-sysops]: https://aws.amazon.com/tw/certification/certified-sysops-admin-associate/
[aws-sysops-blueprint]: http://awstrainingandcertification.s3.amazonaws.com/production/AWS_certified_sysops_associate_blueprint.pdf
[map]: https://goo.gl/maps/Ldk5v8cgrU42
[example-exam]: http://awstrainingandcertification.s3.amazonaws.com/production/AWS_certified_sysops_associate_examsample.pdf
[acloud-guru]: https://acloud.guru/
[acloud-guru-sysops]: https://acloud.guru/course/aws-certified-sysops-administrator-associate
