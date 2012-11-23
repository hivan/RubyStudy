## 语法快览

#### 注释与分行
有单行和多行两种
    ＃单行注释

    =begin
      多行注释可以用=begin 和 =end;
    =end

Rdoc是内嵌在Ruby代码之中的，可以转换成HTML文档说明。函数说明、类说明应该放置在=begin和=end之中。"=begin"一定要卸载行首，也就是说，这一行的前六个字符是"=begin"，不允许有空格在这之前。

Ruby中用分号“；”来表示一个语句的结束。一行如果有多个语句，每个语句用分号隔开，儿最后一个语句可以省略分号。换行符表示一行结束。如果语句太长，可以用"\"连接下一行。

    puts 3/5; puts 3/5.0
    puts "This is a "\
    "test"

#### 分隔符

* ； 分号  用来分隔一行中的多个语句
* ()  圆括号 提高优先级；定义方法时容纳参数列表
* " " 空格  分隔字符；在柯省略()的地方，代替()
* , 逗号  隔开多个参数
* . 点 讲对象与他的方法隔开
* :: 紧连的两个冒号  域作用符，讲模块(类)与它的常量隔开

#### 关键字
* 模块定义: module
* 类定义： class
* 方法定义： def， undef
* 检查类型： defined？
* 条件语句： if, then, else, elsif, case, when, unless
* 循环语句： for, in, while, until, next, break, do, redo, retry, yield
* 逻辑判断： not, and, or
* 逻辑值和空值： true, false, nil
* 异常处理： rescue, ensure
* 对象饮用: super, self
* 块的起始： begin/end
* 嵌入模块： BEGIN，END
* 文件关联： `_FILE_`, `_LINE_`
* 方法返回： return
* 别名： alias

BEGIN模块相当于C语言中的宏，END模块用来作一些收尾工作。有了require，include，应该取消BEGIN和END的语法定义。

#### 运算符
运算符说明建立表格保存在[Google Docs上](https://docs.google.com/spreadsheet/ccc?key=0AsXNvp-OgTRWdDdEMi00WkF6ekF3RVJUa1dEX1JZUWc)

#### 标识名和变量的作用域
Ruby的标识名用来指向常量,变量,方法,类和模块.




















