---
layout: post
title: "AWS Certified DevOps Engineer - Professional 認證考試準備及心得"
description: "AWS Certified DevOps Engineer - Professional Preparation"
og_image: "aws-devops-pro-cert.png"
tags: ['aws', 'certificate', 'DevOps']
---

{% include figure image_path="/assets/images/aws-devops-pro-cert.png" alt="https://www.certmetrics.com/amazon/public/badge.aspx?i=5&t=c&d=2017-12-10&ci=AWS00264275" caption="AWS Certified DevOps Engineer - Professional" %}

## 關於考前準備

相比前面的 [Solution Architect][aws-saa]、[Developer][aws-da] 及 [SysOps][aws-sysops] 均屬於 Associate 級別的考試，考試內容相對通用且內容固定，大部分屬於問答式選擇題。

而 Professional 級別的考試難度是不同的檔次，題目不僅長且全部都是情境題，做題時間不僅拉長，做題前更是需要多花一點時間做準備。

## 認證有效期

與 [Solution Architect Associate][aws-saa]、[Developer Associate][aws-da]、[SysOps][aws-sysops] 一樣是**兩年**。


## 費用

考試費用為 `300 USD` (建議大家可以準備充裕點再去考試才不會白白浪費了錢)

## 考試地點

今年度九月開始 AWS 官方授權的考試代理商從 Kryterion 轉為 PSI ，台北的[恆逸教育訓練中心][map] 有提供相關的認證考場，地點靠近捷運站，於是乎我就選擇了恆逸作為考試地點。

## 測驗語文、形式、題數及時間

- 考試語言：英文
- 考試形式：選擇題、多選題
- 考試題數：約 80 題
- 考試時間：170 分鐘 (考試時間幾乎是 Associate 級別的兩倍，同時考驗作答時的耐性與穩定性)
- 及格分數：建議及格分數抓在 70% 比較保險。

[範例試題][example-exam]

## 考試報名

可以透過官方的界面 [AWS training](https://www.aws.training/) 進行考試的報名，考試代理商為 [PSI exam](https://candidate.psiexams.com/)，


## 重點準備

考試前建議先了解一次考試的幾個大方向，考試官方頁面可以參考 [AWS 官方的認證頁面][aws-devops-introduction] ，[Blueprint][aws-devops-blueprint] (必讀)。

- Domain 1: Continuous Delivery and Process Automation (55%)
- Domain 2: Monitoring, Metrics, and Logging (20%)
- Domain 3: Security, Governance, and Validation (10%)
- Domain 4: High Availability and Elasticity (15%)

Introduction
The AWS DevOps Engineer - Professional exam is intended for individuals who perform a DevOps role.

This exam validates an examinee’s ability to:
Implement and manage continuous delivery systems and methodologies on AWS
- Understand, implement, and automate security controls, governance processes, and compliance

validation
- Define and deploy monitoring, metrics, and logging systems on AWS
- Implement systems that are highly available, scalable, and self-healing on the AWS platform
- Design, manage, and maintain tools to automate operational processes

The knowledge and skills required at the professional level include the majority of the following AWS and
general IT knowledge areas:

Prerequisites
- AWS Certified SysOps Administrator – Associate or AWS Certified Developer – Associate

AWS Knowledge
- AWS Services: Compute and Network, Storage and CDN, Database, Analytics, Application
Services, Deployment, and Management
- Minimum of two years hands-on experience with production AWS systems
- Effective use of Auto Scaling
- Monitoring and logging
- AWS security features and best practices
- Design of self-healing and fault-tolerant services
- Techniques and strategies for maintaining high availability

General IT Knowledge
- Networking concepts
- Strong system administration (Linux/Unix or Windows)
- Strong scripting skillset
- Multi-tier architectures: load balancers, caching, web servers, application servers, databases, and
networking
- Templates and other configurable items to enable automation
- Deployment tools and techniques in a distributed environment
- Basic monitoring techniques in a dynamic environment

準備 DevOps Engineer Professional 前，必須理解 Continuous Delivery and Process Automation 涵蓋了非常大的比重，考試前我會推薦熟悉以下服務：

- [CodeDeploy](https://aws.amazon.com/tw/codedeploy/)
- [CloudFormation](https://aws.amazon.com/tw/cloudformation/)
- [OpsWorks](https://aws.amazon.com/tw/opsworks/)
- [Elastic Beanstalk](https://aws.amazon.com/tw/elasticbeanstalk/)
- [CodeCommit](https://aws.amazon.com/tw/codecommit/)
- [CodeBuild](https://aws.amazon.com/tw/codebuild/)
- [CodePipeline](https://aws.amazon.com/tw/codepipeline/)
- [Elastic Container Services](https://aws.amazon.com/tw/ecs/)

**同樣推薦大家仔細閱讀過幾個重點服務的 FAQ 常見問答集，因為常見的問題確實就是成為考題的必要。**

就我的考試經驗，CloudFormation 和 Elastic Beanstalk 兩個服務有非常大的機會和題目比重。

這張認證最重要的在於在 AWS 上實踐 DevOps 工作和最佳實務，所以會有很多版本控制、自動化測試整合以及 Deployment strategies 等等相關的問題，由於題目都是情境題，會有不同的實踐方式，所以必須要先對於上述 AWS 基本服務有個了解才比較能選擇最佳的實踐方式。

如果對於 AWS 的使用並不熟悉經驗，可以透過 [acloud guru][acloud-guru] 推出 [AWS Certified DevOps Engineer - Professional][acloud-guru-devops] 來快速入門，

能夠有系統性的幫助入門了解 AWS 各式各樣的服務，完整的濃縮。

此外，準備 Professional 有非常重要的一點，我認為務必完整規劃讀書計畫和時間管理。例如，安排一個月後考試，務必每週的目標和 30 天的讀書計畫，積極實踐，利用每天固定觀看 acloud.guru 的 2 至 3 個影音外也需要花點時間閱讀文件和複習。同時，我也十分推薦上 YouTube 挑選對於 AWS DevOps 相關的 re:Invent 、 Tech talk 影音、閱讀 Whitepapers 等增強對於實務上的最佳實踐：

- [Whitepapers: Introduction to DevOps on AWS](https://aws.amazon.com/tw/whitepapers/introduction-to-devops-on-aws/)
- [My DevOps professional playlist](https://www.youtube.com/playlist?list=PL0v-DPRZ8f3a4_JUeTcnBaDThm1iMxpi6)

## 還有

考試中建議大家遇到太長或是不懂的題目先做標記跳過，特別是 DevOps 題目非常落落長，十分考驗耐心，平均每個題目的作答時間僅有 1 分鐘，先把握拿到比較容易拿的分數，做過一遍後再回來檢查也會比較沒壓力。

祝大家順利通過認證！


[aws-saa]: /posts/aws-certified-solution-architect-associate-preparation
[aws-da]: /posts/aws-developer-associate-preparation
[aws-sysops]: /posts/aws-sysops-administrtor-associate-preparation

[aws-devops-introduction]: https://aws.amazon.com/tw/certification/certified-sysops-admin-associate/
[aws-devops-blueprint]: http://awstrainingandcertification.s3.amazonaws.com/production/AWS_certified_sysops_associate_blueprint.pdf
[map]: https://goo.gl/maps/FwvXMZpu7JL2
[example-exam]: https://d1.awsstatic.com/training-and-certification/docs/AWS_certified_DevOps_Engineer_Professional_SampleExam.pdf
[acloud-guru]: https://acloud.guru/
[acloud-guru-devops]: https://acloud.guru/learn/aws-certified-devops-engineer-professional
