---
layout: post
title: "使用 AWS Lambda 建立 Line bot"
description: "Use AWS Lambda to create a line bot"
tags: ['aws', 'python']
---

這篇文章主要是記錄如何透過 AWS Lambda 的服務，同時利用 AWS API Gateway，配合 Line 提供的 Bot API，打造屬於自己的 Line Bot。

## 利用 API Gateway 及 Lambda 建立 webhook 用於接收 Line API 發送的資訊

Please refer: [Creating an AWS Lambda Function and API Endpoint - Slack](https://api.slack.com/tutorials/aws-lambda)

## 建立一個 Line bot

在正式使用 Line Bot 前，首先會需要一個 Line developer 的帳戶，並且建立一隻 Line 的帳戶。

首先登入 [Line developer console][line-developer-console] 建立一個使用 Messaging API 的帳戶。

如果是第一次建立，會需要新增一個 Provider ，用來提供使用 Line Messaging API 的帳戶的相關資訊。

詳細的快速建立步驟可以[參考官方的文件][line-developer-getting-started]。

創建完 Channel 後，有幾項選項可以在設定內看到:
- Channel access token (long-lived) : 用來操作 Channel 的 token
- Use webhooks : 開啟或關閉 Webhook 選項，接續下面的 Webhook URL 設定
- Webhook URL : 若有向機器人發送訊息、邀請加入聊天室等都會觸發到我們自訂的 Webhook 位址，並傳送對應的 API 訊息
- Allow bot to join group chats : 是否允許 Bot 加入群組聊天

為了測試發送訊息的功能，只要在 webhook 一欄填入前面建立的 API Gateway endpoint，並且利用其他帳戶發送訊息或是加入到群組內，

就會觸發 Lambda 接收相關的資訊，可以在 Cloudwatch 內獲得對應的 User ID

Send messages:

```bash
curl -X POST \
-H 'Content-Type:application/json' \
-H 'Authorization: Bearer {ENTER_ACCESS_TOKEN}' \
-d '{
    "to": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "messages":[
        {
            "type":"text",
            "text":"Hello, world1"
        },
        {
            "type":"text",
            "text":"Hello, world2"
        }
    ]
}'
```

## 利用 virtualenv 包裝 python 相依的套件 


```bash
mkdir ~/linebot
docker run -v ~/linebot:/root/linebot python:3.6.3 /bin/bash
```

install.sh
```bash
#!/bin/bash

curl -sL https://bootstrap.pypa.io/get-pip.py -O
python get-pip.py
pip install virtualenv
```

利用 virtualenv 建立 Lambda 部署套件

```bash
mkdir /root/linebot/virtualenv
virtualenv /root/linebot/virtualenv
source /root/linebot/virtualenv/bin/activate
pip install requests json
exit
```

完成建立後，就可以離開 virtualenv 的 shell，進入 `~/linebot/virtualenv/lib/python3.6/site-packages` 將主程式 `lambda_function.py` 放入並進行打包:

```bash
cp ~/linebot/lambda_function.py ~/linebot/virtualenv/lib/python3.6/site-packages/
cd ~/linebot/virtualenv/lib/python3.6/site-packages/
zip -r linebot.zip .
```

完成打包之後，將打包的程式上傳至 AWS Lambda 即可。

Reference:

- [Line developer: Send push message][line-developer-push-message]
- [AWS Lambda: Creating a Deployment Package (Python)][aws-creating-a-python-deployment-package]

[line-developer-console]: https://developers.line.me/console/
[line-developer-getting-started]: https://developers.line.me/en/docs/messaging-api/getting-started/
[line-developer-push-message]: https://developers.line.me/en/docs/messaging-api/reference/#send-push-message
[aws-creating-a-python-deployment-package]: http://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html
