---
layout: post
title: "Python threading.Thread 錯誤筆記"
description: "How to fix the error 'TypeError: subProgram() argument after * must be an iterable, not Queue' in python threading programming."
tags: ['python']
---

最近在試著用 Python 寫多線程的程式遇到一點小狀況，範例程式如下：

```python
import time
import threading
from multiprocessing import Queue

def subProgram(queue):
    for i in range(10):
        queue.put(i)

def main():

    queue = Queue()

    thread = threading.Thread(target=subProgram, args=(queue))
    thread.start()

    time.sleep(2)
    while not queue.empty():
        print queue.get()

main()
```

看似沒問題的程式碼，執行後卻發生錯誤：

```
Exception in thread Thread-1:
Traceback (most recent call last):
  File "/usr/lib/python2.7/threading.py", line 801, in __bootstrap_inner
    self.run()
  File "/usr/lib/python2.7/threading.py", line 754, in run
    self.__target(*self.__args, **self.__kwargs)
TypeError: subProgram() argument after * must be an iterable, not Queue
```

在 stackoverflow 找到了類似的問題跟解法：

> You need to add , after s sending just s to args=() is trying to unpack a number of arguments instead of sending just that single arguement.

但是因為對 Python 太不熟了，惡補了一下基本語法跟翻了一下手冊，確定 args 是 tuple 的型態

> class threading.Thread(group=None, target=None, name=None, args=(), kwargs={})
> This constructor should always be called with keyword arguments. Arguments are:
> 
> - group should be None; reserved for future extension when a ThreadGroup class is implemented.
> - target is the callable object to be invoked by the run() method. Defaults to None, meaning nothing is called.
> - name is the thread name. By default, a unique name is constructed of the form “Thread-N” where N is a small decimal number.
> - args is the argument tuple for the target invocation. Defaults to ().
> - kwargs is a dictionary of keyword arguments for the target invocation. Defaults to {}.
> 
> If the subclass overrides the constructor, it must make sure to invoke the base class constructor (Thread.__init__()) before doing anything else to the thread.

tuple 如果只有單一元素 (element) 的話必須加個`,`逗號才行，不然就會被解讀成單一物件。

參考以下範例會比較了解：

```python
>>> a = (111,222)
>>> a
(111, 222)
>>> 
>>> a = (111, 222)
>>> a
(111, 222)
>>> b = (111)
>>> b
111
>>> c = (111,)
>>> c
(111,)
```

可以看到 `b = (111)` 被解讀成 `111` 了，這並不是預期的狀況，改成 `c = (111, )` 就會正常解析成 tuple 型態了。

同理，只要在

```python
thread = threading.Thread(target=subProgram, args=(queue))
```

`args=(queue)` 補上 `,` 符號就解決這項錯誤：

```python
thread = threading.Thread(target=subProgram, args=(queue,))
```

最後修正的程式如下：

```python
import time
import threading
from multiprocessing import Queue

def subProgram(queue):
    for i in range(10):
        queue.put(i)

def main():

    queue = Queue()

    thread = threading.Thread(target=subProgram, args=(queue,))
    thread.start()

    time.sleep(2)
    while not queue.empty():
        print queue.get()

main()
```


Reference:

- [Thread Objects](https://docs.python.org/2/library/threading.html#thread-objects)
- [stackoverflow](https://stackoverflow.com/a/36387628)
