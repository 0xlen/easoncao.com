---
layout: post
title: "Laravel 5 自訂分頁 (Pagination) 樣式"
description: "Custom pagination in Laravel 5"
og_image: "/assets/images/posts/2017/02/laravel-5.4-work-with-vue-notice/laravel.png"
tags: [php, laravel]
---

# Laravel 5.3

Laravel 5.3 開始官方將這部份重寫成 method，可以利用 `links('view.name')` 完成自訂分頁。

{% raw %}
```php
{{ $paginator->links('view.name') }}
```
{% endraw %}

透過 `vendor:publish` 指令很快的就能在 `resources/views/vendor` 產生對應的 Blade 。

```bash
php artisan vendor:publish --tag=laravel-pagination
```

詳見 [Laravel 5.3 Customizing The Pagination View][laravel-5.3-pagination]

# Laravel <= 5.2

Laravel 5.2 以下的版本可以利用實做 PresenterContract 類別達成，

重寫 `render`, `getAvailablePageWrapper`, `getDisabledTextWrapper`, `getActivePageWrapper` methods 的樣式。

新增 `App\Pagination\CustomPresenter.php` ， 範例程式如下。

```php
<?php

namespace App\Pagination;

use Illuminate\Contracts\Pagination\Paginator as PaginatorContract;
use Illuminate\Contracts\Pagination\Presenter as PresenterContract;
use Illuminate\Pagination\BootstrapThreeNextPreviousButtonRendererTrait;
use Illuminate\Pagination\UrlWindow;
use Illuminate\Pagination\UrlWindowPresenterTrait;

class CustomPresenter implements PresenterContract
{
    use BootstrapThreeNextPreviousButtonRendererTrait, UrlWindowPresenterTrait;

    /**
     * The paginator implementation.
     *
     * @var \Illuminate\Contracts\Pagination\Paginator
     */
    protected $paginator;

    /**
     * The URL window data structure.
     *
     * @var array
     */
    protected $window;

    /**
     * Create a new Bootstrap presenter instance.
     *
     * @param  \Illuminate\Contracts\Pagination\Paginator  $paginator
     * @param  \Illuminate\Pagination\UrlWindow|null  $window
     * @return void
     */
    public function __construct(PaginatorContract $paginator, UrlWindow $window = null)
    {
        $this->paginator = $paginator;
        $this->window = is_null($window) ? UrlWindow::make($paginator) : $window->get();
    }

    /**
     * Determine if the underlying paginator being presented has pages to show.
     *
     * @return bool
     */
    public function hasPages()
    {
        return $this->paginator->hasPages();
    }

    /**
     * Convert the URL window into Bootstrap HTML.
     *
     * @return string
     */
    public function render()
    {
        if ($this->hasPages()) {
            return sprintf(
                '<ul class="article-pages db">' .
                '<div class="head">%s</div>' .
                '<div class="tail">%s</div>' .
                '<div class="pages">%s</div>' .
                '</ul>',
                $this->getPreviousButton(),
                $this->getNextButton(),
                $this->getLinks()
            );
        }

        return '';
    }

    /**
     * Get HTML wrapper for an available page link.
     *
     * @param  string  $url
     * @param  int  $page
     * @param  string|null  $rel
     * @return string
     */
    protected function getAvailablePageWrapper($url, $page, $rel = null)
    {
        $rel = is_null($rel) ? '' : ' rel="'.$rel.'"';

        return '<li class="pg"><a href="'.htmlentities($url).'"'.$rel.'>'.$page.'</a></li>';
    }

    /**
     * Get HTML wrapper for disabled text.
     *
     * @param  string  $text
     * @return string
     */
    protected function getDisabledTextWrapper($text)
    {
        return '<li class="pg disabled"><span>'.$text.'</span></li>';
    }

    /**
     * Get HTML wrapper for active text.
     *
     * @param  string  $text
     * @return string
     */
    protected function getActivePageWrapper($text)
    {
        return '<li class="pg now"><span>'.$text.'</span></li>';
    }

    /**
     * Get a pagination "dot" element.
     *
     * @return string
     */
    protected function getDots()
    {
        return $this->getDisabledTextWrapper('...');
    }

    /**
     * Get the current page from the paginator.
     *
     * @return int
     */
    protected function currentPage()
    {
        return $this->paginator->currentPage();
    }

    /**
     * Get the last page from the paginator.
     *
     * @return int
     */
    protected function lastPage()
    {
        return $this->paginator->lastPage();
    }
}
```

在 Blade 內利用 `with()` 配合 paginate 物件即可達成，如以下程式碼。

```php
<ul>
@foreach ($items as $item)
  <li class="item">$item</li>
@endforeach
</ul>

{!! with(new \App\Pagination\CustomPresenter($items))->render() !!}
```

[laravel-5.3-pagination]: https://laravel.com/docs/5.3/pagination#customizing-the-pagination-view
