---
layout: post
title: "jQuery Selector 使用逗點之間的差異"
description: "jQuery Selector 逗點之間的區別"
og_image: "/assets/images/posts/2017/01/jquery-selector-using-comma/jquery.png"
tags: [jQuery, javascript]
---

{% include figure image_path="/assets/images/posts/2017/01/jquery-selector-using-comma/jquery.png" caption="jQuery! write less, do more." alt="jQuery! write less, do more." %}

雖然好像有點舊飯重炒了，現在前端也打的這麼火熱，

這些紀錄出來的時機好像有點短，不過接觸 jQuery 也蠻常一段時間了，

好像沒什麼注意到有人區別逗號 "," 這個很特別的存在，也常常是讓初學者混淆摸不著頭緒的一個符號，

jQuery selector 一般常見的寫法都是

```javascript
$('button')
```

如果是選擇 class name 會利用 "." 點符號表示，
id 則是使用 "#" 井字符號表示，跟 css 的 selector 用法一樣。

```javascript
$('.myClass')
$('#id')
```

而逗點如果放在 '' (單引號) 或 "" (雙引號) 間 (兩者在 jQuery 中其實沒有太大區別)，
代表的是 multiple selector，會同時選擇兩個以上的元素 (element)。

```javascript
$('button, div')
```

上述程式同時選擇了 DOM 裡的 `button` 及 `div`。


但要注意的是，如果 "," 逗號放置在 '' (單引號) 或 "" (雙引號) 外，就變成有點像 function(param1, param2) 的概念，成兩個實體參數，

寫法為：

```javascript
jQuery( selector [, context ] )
```

context 可以是 DOM element、Document 或是 jQuery Object，

這樣 jQuery 會縮小選擇範圍，以第二個參數作為選擇對象縮小搜尋，像以下範例。

```javascript
$('div').on('click', function(e) {
    $('p', this).addClass('active');
});
```

也就是說，下段程式碼，均有同等的效果。

- Example 1
```javascript
var $container = $('div');
$('button', $container)
```

- Example 2
```javascript
$('div button')
```

- Example 3
```javascript
$('div').find('button')
```

- Example 4
```javascript
var $container = $('div');
$container.find('button')
```

參考資料：
- [jQuery()](http://api.jquery.com/jQuery/)
- [Multiple Selector (“selector1, selector2, selectorN”)](https://api.jquery.com/multiple-selector/)
