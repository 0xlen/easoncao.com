---
layout: post
title: "Memory Management and Paging Quick Note"
description: "Memory management and paging quick note"
tags: ["operating-system"]
---

## 對於 Paging 的疑惑

在讀[清大作業系統開放式課程 Memory Management - Paging][3] 一章時對於裡面一個範例產生了疑問，在這邊簡單紀錄一下。

> Given 32 bits logical address, 36 bits physical address and 4KB p    age size, what does it means?

- Page table size = 2^32 / 2^12 = 2^20 entries
- Max program memory : 2^32 = 4GB
- Total physical memory size: 2^36 = 64GB
- Number of bits for page number: 2^20 pages, 20bits
- Number of bits for frame number: 2^36 / 2^12 = 2^24, 24bits
- Number of bits for page offset: 4KB page size, 2^12, 12bits

在閱讀這些資料的時候不免疑惑，為什麼是 `2^36 Bytes` (64GB) 的 physical memory，不是 `36 bits` logical address， 應該可用的記憶體應該不是 `2^36 bits` 嗎，而且 Max program memory 可以到 4GB !?

更讓我疑惑的是在計算 Page entries ，明明是不同單位的東西 (`32 bits` 與 4KB, 4KB 應該是 4096 bytes * 8 = `32768 bits`)。

後來經過一些資料的查詢，發現我對於記憶體的管理上有一些誤解，這邊有提到logical address，注意這邊指的是 **address** ，

可參考 [wikipedia][1] 對於 memory address 的解釋：

>  the more bits used, the more addresses are available to the computer. For example, an 8-bit-byte-addressable machine with a 20-bit address bus (e.g. Intel 8086) can address 2^20 (1,048,576) memory locations, or one MiB of memory, while a 32-bit bus (e.g. Intel 80386) addresses 2^32 (4,294,967,296) locations, or a 4 GiB address space. In contrast, a 36-bit word-addressable machine with an 18-bit address bus addresses only 2^18 (262,144) 36-bit locations (9,437,184 bits), equivalent to 1,179,648 8-bit bytes, or 1152 KB, or 1.125 MiB—slightly more than the 8086.

由此可知，代表說一個 physical memory address 對應到的可用空間為 1 byte ，

我們市面上常見的 `32 bits` 或 `64 bits` 處理器指的是處理器核心所能存取及表示的最大記憶體位址，各有 `2^32 bits` 及 `2^64 bits` 種組合，詳見 [\[2\]][2]。


## 總結

所謂的 `36 bits` physical address，可表示實體記憶的位址為 `2^36 bits`，因為一個位址可用的記憶體空間大小為 `1 Byte`，共可用的記憶體大小為 `2^36 Bytes`。


## Reference

- [Memory address][1]
- [how long is a memory address typically in bits][2]
- [國立清華大學開放式課程OpenCourseWare(NTHU, OCW) - 作業系統][4]

[1]: https://en.wikipedia.org/wiki/Memory_address
[2]: https://stackoverflow.com/a/21197097
[3]: http://ocw.nthu.edu.tw/ocw/index.php?page=chapter&cid=141&chid=1862&video_url=http%3A%2F%2Focw.nthu.edu.tw%2Fvideosite%2Findex.php%3Fop%3Dwatch%26id%3D4004%26filename%3D1920_1080_3072.MP4%26type%3Dview%26cid%3D141%26chid%3D1862
[4]: http://ocw.nthu.edu.tw/ocw/index.php?page=course&cid=141
