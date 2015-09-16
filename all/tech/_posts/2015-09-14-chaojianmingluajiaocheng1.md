---
title: 超简明lua教程（1）——基本语法
date: Mon Sep 14 15:07:49 JST 2015
layout: post
categories:
  - tech
tags:
  - lua
---
## Hello Wrold!
直接在命令行中运行：
	
<pre class="brush: bash;">
➜  luastudy  lua
Lua 5.2.4  Copyright (C) 1994-2015 Lua.org, PUC-Rio
> print("Hello World!")
Hello World!
</pre>

在文件中运行：

<pre class="brush: bash;">
➜  luastudy  cat hello.lua
print("Hello World!")
print("Hello World!");
➜  luastudy  lua hello.lua
Hello World!
Hello World!
</pre>

or：

<pre class="brush: bash;">
➜  luastudy  cat hello.lua
#!/usr/local/bin/lua
print("Hello World!")
print("Hello World!");
➜  luastudy  chmod +x hello.lua
➜  luastudy  ./hello.lua
Hello World!
Hello World!
</pre>

## 变量
坑点：

* 数值只有64bit的double型，并不分int/float/double等等
* 对于bool型，只有**false**和**nil**才是*FALSE*，数字0、空字符串等等都是*TRUE*
* 变量没有类型，但值有类型
* 可以多个变量同时赋值，此时右侧的值会先计算再分别赋值给左边

Test file *variable.lua*:

<pre class="brush: cpp;">
-- 数值只有64bit的double型
print("============== try numbers ==============")
num = 1024
print(num)
num = 1024.0
print(num)
num = 0x400
print(num)

--[[
字符串支持：
    使用单引号/双引号
    使用转义
    使用\[\[\]\]支持换行
]]--
print("============== try strings ==============")
str = 'I\'m a big fan of "BloodBorn"\n\t--Leon'
print(str)
str = "I'm a big fan of \"BloodBorn\"\n\t--Leon"
print(str)
str = [[I'm a big fan of "BloodBorn"
	--Leon]]
print(str)

--[[
bool类型：
	false：	false / nil
	true：	true / everything else （包括数字0、""等等）
]]--
print("============== try bool ==============")
if not flag then
    print("nil is false")
end

flag = false
if not flag then
    print("false is false")
end

flag = true
if flag then
    print("true is true")
end

flag = 0
if flag then
    print("0 is true")
end

flag = ''
if flag then
    print("'' is true")
end

-- 多个变量同时赋值
print("============== try mutiple-assignment ==============")
v1, v2, v3 = 1, 2
print(v1)
print(v2)
print(v3)
v1, v2 = v2, v1 -- 我说什么来着
print(v1)
print(v2)
</pre>

运行：

<pre class="brush: bash;">
➜  luastudy  lua variable.lua
============== try numbers ==============
1024
1024
1024
============== try strings ==============
I'm a big fan of "BloodBorn"
	--Leon
I'm a big fan of "BloodBorn"
	--Leon
I'm a big fan of "BloodBorn"
	--Leon
============== try bool ==============
nil is false
false is false
true is true
0 is true
'' is true
============== try mutiple-assignment ==============
1
2
nil
2
1
</pre>


## 循环语句

lua中的循环语句包括while / for / repeat-until  
坑点：

* lua中并不存在 += ++ ---- 这样的运算符
* for index = start, end (, step)语句中，当step > 0（< 0）时，跳出条件为index > end（< end）（而非>=、<=）

Test file *loop.lua*:

<pre class="brush: cpp;">
index = 0
max = 100
sum_even = 0

-- while ... do ... end
while index <= max do
     sum_even = sum_even + index        -- no `sum += index`
     index = index + 2                  -- no `index++`
end
print("sum_even = " .. sum_even)

-- for index = start, end (, step) do ... end
sum_even = 0
for index = 0, max, 2 do
    sum_even = sum_even + index
end
print("sum_even = " .. sum_even)
sum_even = 0
for index = max, 0, -2 do
    sum_even = sum_even + index
end
print("sum_even = " .. sum_even)

-- for ... in ... 的用法后面再讲

-- repeat ... until ...
index = 0
sum_even = 0
repeat
    sum_even = sum_even + index
    index = index + 2
until index > max
print("sum_even = " .. sum_even)
</pre>

运行：

<pre class="brush: bash;">
➜  luastudy  lua loop.lua
sum_even = 2550
sum_even = 2550
sum_even = 2550
</pre>


## if/else分支
坑点：

* “不等于”是**~=**
* “非”是**not**
* 逻辑“与”和“或”是**and**和**or**

Test file *ifelse.lua*:

<pre class="brush: cpp;">
print("> Input your language (cn, Chinese, en, English, etc. Input 'end' to exit)")
lang = io.read("*l")
while lang ~= 'end' do
    print("> Input your age")
    age = io.read("*n")
    io.read()

    if lang == 'cn' or lang == 'Chinese' then
        if age < 20 then
            print("但是你们呀，毕竟还是too young")
        elseif age >= 60 then
            print("今天我作为一个长者")
        else
            print("闷声发大财")
        end
    elseif lang == 'en' or lang == 'English' then
        print("Excited!!!")
    elseif lang ~= 'jp' and lang ~= 'Japanese' then
        print("I can't speak " .. lang .. ", but let's just rock with Lua, " .. age .. "-year-old man!!!")
    else
        print("馬鹿め！")
    end
    print "==================================================="

    print("> Input your language (cn, en, jp, etc. Input 'end' to exit)")
    lang = io.read("*l")
end
</pre>

运行：

<pre class="brush: bash;">
➜  luastudy  lua ifelse.lua
> Input your language (cn, Chinese, en, English, etc. Input 'end' to exit)
cn
> Input your age
10
但是你们呀，毕竟还是too young
===================================================
> Input your language (cn, en, jp, etc. Input 'end' to exit)
Chinese
> Input your age
90
今天我作为一个长者
===================================================
> Input your language (cn, en, jp, etc. Input 'end' to exit)
en
> Input your age
25
Excited!!!
===================================================
> Input your language (cn, en, jp, etc. Input 'end' to exit)
Japanese
> Input your age
18
馬鹿め！
===================================================
> Input your language (cn, en, jp, etc. Input 'end' to exit)
French
> Input your age
30
I can't speak French, but let's just rock with Lua, 30-year-old man!!!
===================================================
> Input your language (cn, en, jp, etc. Input 'end' to exit)
end
</pre>

## 作用域
坑点：

* 不带local，套多深都是全局变量

Test file *scope.lua*:

<pre class="brush: cpp;">
global1 = "Global 1"
local local1 = "Local 1"
if (true) then
    global2 = "Global 2"
    local local2 = "Local 2"

    print "In if-branch: "
    print(global1)
    print(local1)
    print(global2)
    print(local2)
end

print ("\nOut of if-branch")
print(global1)
print(local1)
print(global2)
print(local2)
</pre>

运行：

<pre class="brush: bash;">
➜  luastudy  lua scope.lua
In if-branch:
Global 1
Local 1
Global 2
Local 2

Out of if-branch
Global 1
Local 1
Global 2
nil
</pre>

## 函数

坑点：

* function也是一个基本数据类型，所以可以随便赋值给变量

Test file *function.lua*:

<pre class="brush: cpp;">
function fib(n)
    if n < 2 then
        return 1
    else
        return fib(n - 1) + fib(n - 2)
    end
end

funfib = fib

print(fib(10))
print(funfib(10))
</pre>

运行：

<pre class="brush: bash;">
➜  luastudy  lua function.lua
89
89
</pre>

## 闭包

闭包（closure），可能是C++程序员接触比较少的概念，我们先来看示例代码*closure.lua*：

<pre class="brush: cpp;">
function closure_counter()
    local cnt = 0
    return function()
        cnt = cnt + 1
        print(cnt)
    end
end

f1 = closure_counter()
print(f1)
print("Call f1 twice...")
f1()
f1()

f2 = closure_counter()
print(f2)
print("Call f2 5 times...")
f2()
f2()
f2()
f2()
f2()

print("Call f1 once more...")
f1()
</pre>

先猜猜会输出什么 ;-P  
运行：

<pre class="brush: bash;">
➜  luastudy  lua closure.lua
function: 0x7fb759c06aa0
Call f1 twice...
1
2
function: 0x7fb759c076e0
Call f2 5 times...
1
2
3
4
5
Call f1 once more...
3
</pre>

猜对了么？  
看起来，这个“闭包”不过是一个返回值是个匿名函数的函数，其实它和函数有着本质的区别：

* **闭包 = 函数 + 引用环境**，在这个closure_counter里，返回的匿名函数就是**函数**，而`local cnt`则构成了所谓引用环境
* 函数（指返回的匿名函数，下同）可以使用闭包中的局部变量，从表相上看来，就是“子函数可以使用父函数的局部变量”，也符合上面“作用域”一节中我们的理解，我们将这样的局部变量称为函数的**upvalue**
* 当我们重复调用函数时，引用环境是固定的，如第12、13行，我们调用了两次f1，输出了1和2；而当函数有多个时，这些函数也共享同一个引用环境（见下面的例子）
* 闭包的参数也是引用环境的一部分哦（见下面的例子）
* 现在是不是有种upvalue看起来有点某些语言中的static变量的感觉？并不是，这也是闭包和函数的最大区别，函数在全局只有一个实例，而闭包可以有多个。比如在第15行，我们获取了一个新的函数f2，随之而来的是一个新的闭包实例。如何证明？如之前所说，闭包 = 函数 + 引用环境：

    函数不同：第10行和第16行的输出不同  
    引用环境不同：连续调用f2五次，是从1开始输出的，不受前面调用f1的影响；又调用一次f1，输出了3，也不受前面调用f2的影响。说明f2和f1有着格子独立的引用环境

再来一个例子，相信这次大家都能说对输出结果啦——当然这次肯定不是猜的

<pre class="brush: cpp;">
function closure_doublefun(i)
    show = function()
        print(i)
    end

    double = function()
        i = i * 2
    end

    return show, double
end

f11, f12 = closure_doublefun(1)
f11()
f12()
f11()
f12()
f11()
f12()
print("==================")
f21, f22 = closure_doublefun(3)
f21()
f22()
f21()
f22()
f21()
f22()
</pre>

运行：

<pre class="brush: bash;">
➜  luastudy  lua closure2.lua
1
2
4
==================
3
6
12
</pre>


## TO BE CONTINUED
