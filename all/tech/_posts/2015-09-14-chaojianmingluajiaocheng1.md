---
title: 超简明lua教程（1）——语法
date: Mon Sep 14 15:07:49 JST 2015
layout: post
categories:
  - tech
tags:
  - lua
---
## Hello Wrold!
直接在命令行中运行：
	
<pre class="brush: cpp;">
➜  luastudy  lua
Lua 5.2.4  Copyright (C) 1994-2015 Lua.org, PUC-Rio
> print("Hello World!")
Hello World!
</pre>

在文件中运行：

<pre class="brush: cpp;">
➜  luastudy  cat hello.lua
print("Hello World!")
print("Hello World!");
➜  luastudy  lua hello.lua
Hello World!
Hello World!
</pre>

or：

<pre class="brush: cpp;">
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
* 对于bool型，**只有false和nil**才是FALSE，数字0、空字符串等等都是TRUE

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
if (not flag) then
    print("nil is false")
end

flag = false
if (not flag) then
    print("false is false")
end

flag = true
if (flag) then
    print("true is true")
end

flag = 0
if (flag) then
    print("0 is true")
end

flag = ''
if (flag) then
    print("'' is true")
end
</pre>

