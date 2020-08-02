---
layout: post
title: "讓PHPUnit測試單一個程式"
description: "Let PHPUnit run single test"
og_image: "/assets/images/posts/2017/01/let-phpunit-test-only-one-function/phpunit.png"
tags: [phpunit, unit-test, php]
---

{% include figure image_path="/assets/images/posts/2017/01/let-phpunit-test-only-one-function/phpunit.png" caption="PHPUnit" alt="PHPUnit" %}

在跑單元測試總有遇到亮紅燈的時候，健全一點的測試幾十個 assertion 都很正常，

但是如果 phpunit 只有幾個測試沒過全部重測也很浪費時間，所以稍微找了一下怎麼只測特定的 method 。

只測一個單元測試檔案

```bash
phpunit tests/testone.php
```

只跑 test/testone.php 裡的 testMethod()

```bash
phpunit --filter testMethod tests/testone.php
```

`--filter` 也支援 Namespace / Class name

```bash
phpunit --filter 'TestNamespace\\TestCaseClass::testMethod'
phpunit --filter 'TestNamespace\\TestCaseClass'
phpunit --filter TestNamespace
phpunit --filter TestCaseClass
```

正規表達也沒問題

```bash
phpunit --filter '/::testMethod .*"my named data"/'
```

也有快速便捷的測法

```bash
phpunit --filter 'testMethod#2'
phpunit --filter 'testMethod#2-4'
```

其他用法詳見：

- PHPUnit 官方文件 [Filter pattern](https://phpunit.de/manual/current/en/textui.html#textui.examples.filter-patterns)
