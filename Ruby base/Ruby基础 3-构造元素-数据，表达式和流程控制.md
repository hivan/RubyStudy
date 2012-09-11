## Ruby 基础3 构造元素：数据，表达式和流程控制

### 数字与表达式
  
计算机在最底层是基于数字的，所有东西都用数字流表示。Ruby之类的语言将你与计算机内部运算隔离开来。而Ruby中使用的数字与实际生活中使用的数字几乎完全相同！

#### 表达式基础知识
在编程时，表达式（expression）是指数字，运算符（例如+或者-）和变量的组合，当计算机理解此表达式时，我将以某种回答形式得出结果，Ex：

    5
    1+2
    "a"+"b"+"c"
    100-5*(2-1)
    x+y

表达式普遍用于所有计算机程序,不仅仅是数字,然而,一旦理解了表达式和运算符对数字的处理方式,就可以立即明白它们是怎样处理文本,列表和其他东西

#### 变量
由于变量是值和数据的占位符,因此还可以把表达式的值赋给变量,还可以用于表达式本身.

    x=10
    y=x*100
    x += y
    puts x

    age = 24
    puts "You're NOT a teenager" unless age.between?(12, 20)

`unless`关键字是得到相反的结果
`between？`方法，如果对象处于（或等于）指定的两个值之间，则该方法返回true

自己写了长一点的代码：

    class Pet
      attr_accessor :name, :age, :gender
    end

    class Person < Pet
    end

    yuan = Person.new
    yuan.name = "Xiaoyuan"
    yuan.gender = "male"
    yuan.age = 24
    puts "You're a working age man" if yuan.gender = "male" && (yuan.age >= 18 && yuan.age <= 65)

循环打印5次"Test"

`5.times do puts "Test" end 或者  5.times {puts "Test"}`

我们要先习惯花括号的单行代码,但是对于更长代码块也会使用do和end.这是一种值得养成的好习惯,因为几乎所有专业的Ruby开发人员都遵循这种习惯.

Ruby中的一种创建循环的机制,叫做迭代子(iterator).所谓迭代子,是指再列表条目中逐步递进的东西.

EX: 
1.upto(5) {…code to loop here…}
10.downto(5) {…code to loop here…}
0.step(50,5){…code to loop here…}
  
  
    1.upto(5) {|number| puts number}

    1.upto(5) do |number|
      puts number
    end

#### 浮点数
    x=10
    y=3
    puts x.to_f/y.to_f

在此情况下，当进行除法运算的时候，x和y都已用Integer类的to_f方法，转换成浮点的等价形式，同样，浮点数也可以用to_i方法，反向转换成整数。
`puts 5.7.to_i`

#### 常量
需要把数据作为计算机程序的直接组成部分的情况极其罕见,这再大多数情况下是正确的,但考虑一下某些永远不会改变的值--例如圆周率的值.这些不改变的值称为常量(constant),再Ruby中的表示形式是以大写字母开头的变量名:

`Pi = 3.141592`
如果此时尝试修改Pi的值,irb会允许修改,但是会给出警告/
`Pi = 500`
`(irb): warning: already initialized constant Pi`

### 文本与字符串
#### 字面字符串
字符串是一组任意长度文本字符(包括数字,字母,空格和符号)的几何.再Ruby中所有字符串都是String类的对象,正如调用字符串的class方法所发现的那样,它返回结果如下:
`puts "Hello, World!".class`
`>>String`

用前文所示的引号,把字符串直接嵌入在代码中,这种构造就称为字面字符串(String literal).这与另一种字符串不同,后者的数据来自远程源,例如来自用户输入,文件或因特网,而预先嵌入在程序中的文本都是字面字符串.
与数字相似,我们可对字符串进行操作,相加和比较,也可以把字符串赋值给变量:

    x = "Test"
    y = "String"
    puts "Success!" if x+y = "TestString"

引号只适合单行文本,但是如果想扩展到多行,可以试试下面的方法:

    x=%q{This is a test
    of the multi
    line capabilities}

再本例中,引号被替换成%q{和}.当然,不必非得用花括号,也可以用<和>,(和),或只是自选的两个分界符,例如!和!.这段代码可以改写成如下形式,其含义完全相同:

    x=%q!This is a test
    of the multi
    line capabilities!

然而,必须记住一点,如果使用惊叹号作为分界符,那么所引用正文中一旦有惊叹号,就会导致这种方法出错.如果字符串中有分界符符号,则字面字符串会提前终止,Ruby会把后面的文本内容视为错误内容.因此,请慎重选择所用的分界符.

另外一种构建字面字符串的方法,是用引入文档(here document),这个概念出自许多其他编程语言.它的构建方式与上例类似,不同之处在于分界符可用多个字符.如:

    x = <<END_MY_STRING_PLEASE
    This is the string
    And a second line
    END_MY_STRING_PLEASE

本例中,`<<`标记了字面字符串的开始,后跟所选择的分界符.字面字符串从下一行开始.以再次遇到分界符为结束,采用这种方法,就不大可能碰到选错分界符的问题,只要你有足够的创意即可!

#### 字符串表达式
用+号可以把"Test"和"String"这两个字符串连接起来,得到"TestString",从而使下面的比较结果为true,进而向屏幕输出"Success!":
`puts "Success!" if "Test"+"String" == "TestString"`

同样,也可以对字符串进行乘法操作.
`puts "abc" * 5`
也可以进行大于和小于的比较操作:
字符以数值形式驻留再计算机内存中,因此每个字母和符号都有值.称为ASCII值.这些值本身没有特别重要的含义,但是却让我们可以用这种方法,对字母甚至更长的字符串进行比较.如果想知道某个字符的值是多少,可以用如下方法:
`puts ?x` (此方法是Ruby1.8中的方法,如果要再1.9版本中查询ASCII值,则如下:`puts ?x.ord`), 可以用String类的chr方法,得到相反的效果.

#### 插写
puts方法把代码的结果打印输出到屏幕上,但是这个结果需要稍作解释.如果随便哪个用户过来使用你的代码,就不会很清楚将产生什么结果,因为他们没兴趣读你的源代码.就不会很清楚将产生什么结果,因为他们没兴趣读你的源代码,因此,你的程序提供用户友好的输出是一件很重要的事,在本例中可以回头使用数字:

    x=10
    y=20
    puts "#{x}+#{y}=#{x+y}"

这里展示了一个有意思的能力,即可以把表达式(甚至代码逻辑)直接嵌入到字符串中,之一过程称为插写(interpolation).插写是指表达式结果插入字面字符串的过程.再字符串中插写的方式,是把表达式放在#{和}符号中.
Ex:`puts "100 * 5 = #{100*5}"`

代码段#{100*5}把100*5的结果插写到字符串中指定位置,产生如上所示的输出.
当然也可以插写其他字符串:

    x="cat"
    puts "The #{x} in the hat"

或者使用下边更巧妙的办法
`puts "It's a #{"bad " *5}world!`

插写也可以用在字符串赋值中:

    my_string = "It's a #{"bad"*5}world!"
    puts my_string

值得一提的是,不用插写方式,把表达式放在字符串之外,也可以得到和前面相同的结果.

    x=10
    y=20
    puts x.to_s+"x"+y.to_s+"="+(x+y).to_s
    puts "#{x}+#{y}=#{x+y}"

这两个puts代码产生相同的呃输出,第一行代码用字符串相加,把几个不同的字符串链接起来,x和y的数值用其to_s方法转换成字符串.而第二行puts代码则用插写方式,不需要显式的把数字转换成字符串.

#### 字符串方法
##### 对字符串"Test"调用不同方法的结果

  1. "Test"+"Test"  == TestTest
  2. "Test".capitalize == Test
  3. "Test".downcase == test
  4. "Test".chop == Tes
  5. "Test".hash == -98625764
  6. "Test".next == Tesu
  7. "Test".reverse == tseT
  8. "Test".sum == 416
  9. "Test".swapcase == tEST
  10. "Test".upcase == TEST
  11. "Test".upcase.reverse == TSET
  12. "Test".upcase.reverse.next == TESU

第二章用到的另外一个方法是length
`puts "This is a test".length`
这些方法都很有用,但你无法用这些方法对字符串做什么特别令人耳目一新的事情.

#### 正则表达式与字符串操作
要在搞基层面处理字符串,必须学会正则表达式(regular expression).从根本上说,正则表达式就是搜索查询,不要把它与本章讨论过的表达式混淆起来,如果再喜欢的搜索引擎中输入ruby,你是期望看到关于Ruby的信息.同样,如果你的正则表达式是ruby,并对某个很长的字符串运行该查询,则你期望得到的是相匹配的内容.因此,正则表达式是一个字符串,它描述再其他字符串中的匹配元素模式.

##### 替换
对于字符串,经常要做的操作之一,就是把某些内容替换成其他内容.
`puts "foobar".sub('bar', 'foo')`
本例,对字符串调用名为sub的方法,该方法把第一次遇到的'bar'替换成'foo',替换的结果为foofoo. sub方法只对发现的第一个匹配文本做一次替换,而gsub方法则对所有匹配的文本进行多次替换. `puts "this is a test".gsub('i','')`
这里把所有字母'i'都替换成空字符串.

    x="This is a test"
    puts x.sub(/^../, 'Hello')

在本例中,用sub进行了单个替换,传递给sub方法的第一个参数不是字符串,而是正则表达式,斜杠用于表示正则表达式的开始和结尾.在正则表达式中^..,其中^称为锚,表示正则表达式将从字符串中的任一行开头进行匹配.至于两点,每个点都表示"任何字符".综上可知, `/^../` 表示"某行开始的开头两个字符",因此,"This is a test"中的Th被替换成Hello.

同样,入股偶要改变最后两个字母,可以用另外一种锚:

    x = "This is a test"
    puts x.sub(/..$/, 'Hello')

这一次,正则表达式匹配字符串中任一行行尾的两个字符

**注:如果想锚到字符串的绝对开头和结尾,可以相应使用\A和\Z,而^和$则表示各行的开头和结尾.**

##### 用正则表达式进行迭代
在前文中,用过迭代子再数字集合中移动,例如从1计数到10, 如果想在字符串中迭代,并分别访问其各个部分,应该怎么办?scan正式所需要的迭代子方法:

`"xyz".scan(/./) {|letter| puts letter}`

scan方法正如其名,它根据传给它的正则表达式,在字符串中扫描,寻找所有匹配正则表达式的内容.再本例的情况下,提供的正则表达式是每次查找一个字符,这就是分别得到x,y,z输出的原因.查找到的每个字母都被送给代码快,并赋值给letter变量,然后打印到屏幕上.我们再试试下面这个更复杂的例子:

`"This is a test".scan(/../) {|x| puts x} `

这一次,一次扫描了两个字符.
当然,扫描所有字符会产生有些怪异的输出,如空格也混杂在内,我们来调整一下正则表达式,让它值匹配字母和数字,如下:

`"This is a test".scan(/\w\w/){|x| puts x}`

在正则表达式中,有一些特殊字符以反斜杠表示,他们有特殊意义. `\w` 表示"字母表中的任何字符或下划线".还有很多其他字符:

###### 正则表达式中基本的特殊字符和符号
1. ^ 用于行还是的锚
2. $ 用于航结束的锚
3. \A 用于字符开始的锚
4. \Z 用于字符结束的锚
5. . 任一字符
6. \w 任何字母,数字或下划线
7. \W 不匹配\w的任何内容
8. \d 任何数字
9. \D 不匹配\d的任何内容(非数字)
10. \s 空白(空格,制表符,换行符等)
11. \S 非空白(任何可见字符)

利用上边的知识,可以轻易地从字符串中解析出数字

    "The car costs $1000 and the cat costs $10".scan(/\d+/) do |x|
      puts x
    end


    "The car costs $1000 and the cat costs $10".scan(/\d/) do |x|
      puts x
    end

因此,在正则表达式中,字符之后的+表示匹配一个或多个此类字符.还有其他种类的修饰符,如:

1. \* 匹配零次或多次前面紧跟的字符,并尽量多的匹配
2. \+ 匹配一次或多次前面紧跟的字符,并尽量多的匹配
3. \*? 匹配零次或多次前面紧跟的字符,并尽量少的匹配
4. \+? 匹配一次或多次前面紧跟的字符,并尽量少的匹配
5. ? 要么匹配一次,要么全不匹配前面紧跟的字符
6. \{x} 匹配x次前面紧跟的字符
7. \{x,y} 匹配最好x次,最多y次前面紧跟的字符

对于正则表达式,目前需要理解的最后一个重要方面,是字符类别(character classes).这些字符类别让可以针对特定字符集合进行匹配.例如,可以扫描字符串中所有元音字母.
`"This is a test".scan(/[aeiou]/) {|x| puts x}`
[aeiou]表示"匹配任何a,e,i,o或u".还可以在方括号中指定字符的范围,如下所示:
`"This is a test`.san(/[a-m]/) {|x| puts x}
这次扫描匹配a到m之间的所有小写字母.
###### 匹配查询
做替换和从字符串中解析某些文本是很有用的,但有时我们只想检查某个字符串是否匹配所选择的模式.例如,可能想快速得知字符串是否包含原因字母:
`puts "String has vomele" if "This is a test" =~ /[aeiou]/`
在本例中, =~是运算符的另一种形式--匹配查询运算符.如果字符串与运算符后边的正则表达式能够匹配,则该表达式结果为true,当然,也可以做相反的操作:
`puts "String contains o digits" unless "This is a test" =~ /[0-9]/`
这一次,代码的含义是除非0到9的数字匹配测试字符串,否则就告诉用户,字符串中没有数字.

还可以使用String类提供的名为match的方法, =~是根据正则表达式是否匹配字符串,返回true或false,而match方法则提供了许多更强大的能力.下边是一个简单的例子:
`puts "String has vowels" if "This is a test".match(/[aeiou]/)`

这行代码看起来与前面的例子几乎一样,但是由于match方法不需要用正则表达式作为参数,它把提供给它的任何字符串都转换成正则表达式,因此下面这行代码也同样可以:
`puts "String has vowels" if "This is a test".match("[aeiou]")`

如果正则表达式能由用户提供,或从文件及其他外部来源载入,这种功能是非常有用的.

在正则表达式中,如果其中一部分由括号(和)包围,则该部分正则表达式所匹配的数据可以单独使用,与剩余的其他数据不想干.match方法让你可以访问这些数据:

  x = "This is a test".match(/(\w+)(\w+)/)
  puts x[0]
  puts x[1]
  puts x[2]

match 方法返回MatchData对象,该对象的访问方法与数组类似.第一个元素包含整个正则表达式所匹配的数据,但每个后续元素都只包含正则表达式每块但愿所匹配的内容.在本例中,第一块(\W+)匹配This,而第二块(\w+)则匹配is.

**匹配查询可能比上述内容更复杂,当你开始编写第一个完整的Ruby程序时,我将在下一章讨论更搞基的用法.**

#### 数组与列表
在Ruby中,可以用数组(array)来表示对象的有序集合

##### 基本数组
下面是一个基本的数组:
`x = [1,2,3,4]`
这个数组有四个元素,每个元素都是整数,用逗号分割相邻的两个元素,所有元素都包含在方括号中.
可通过元素的索引序号(即其在数组中的位置)来访问它们,要访问特定的元素,数组或包含数组的变量,可通过包含在方括号中的索引,称其为元素引用(element reference).例如:

    x = [1, 2, 3, 4]
    puts x[2]

要改变元素的值,可以直接对其赋予新值,也可以像本章前文中操作数字和字符串一样操作元素.

    x[2] += 1
    puts x[2]

or

    x[2] = "Fish"*3
    puts x[2]

数组不需要设置预定义空间,或手工分配元素.我们可以创建空数组,如: `x[]`
这个数组是空数组,因此如果定位某个元素,例如`x[5]`,将返回空值.然而我们可以用压入数据的方法,向数组末尾加入内容.如:

    x = []
    x << "word"

在此操作之后,数组即包含某个元素:"word"字符串.对于数组来说,<<是把数据放到数组末尾的运算符,也可以调用push方法,他们具有相同的效果.
还可以从数组中一个个的删除数据.传统上讲,数组是个"先进先出"系统,数据既能被压入数组末尾,也能从数组末尾弹出(弹出是从数组末尾检索数据并同事将其删除的过程).

    x = []
    x << "word"
    x << "Play"
    x << "Fun"
    puts x.pop
    puts x.pop
    puts x.length

把"word", "Play"和"Fun"压入到x所持有的数组中,然后在屏幕显示首先被"弹出"的元素.元素从数组末尾倒序弹出,因此Fun首先弹出,然后是Play.为了进行良好的度量,随即调用命名为length的方法(也可以用size方法,结果一样),此时数组的长度为1,因为当前数组中只有"Word".
另一个有用的特点是,如果数组中全都是字符串,可以对该数组调用名为join的方法,如果把所有元素链接起来,则形成一个大字符串:

    x = ["word", "play", "Fun"]
    puts x.join

join方法可接受一个可选参数,放在结果字符串的每个元素之间

    x=["word", "paly", "fun"]
    puts x.join(', ')

这一次,把数组元素链接起来,但在每个元素之间放了逗号和空格.这个输出结果看起来更简洁.

##### 字符串切分成数组
在关于字符串的章节中,用scan方法在字符串内容中迭代扫描,查找匹配正则表达式模式的字符.对于scan方法,你使用了一个代码块,它接受每次查找字符的集合,并将其显示在屏幕上.然而,如果不用代码块进行扫描,它将返回一个数组,包含字符串中所有匹配的内容.如:
`puts "This is a test".scan(/\w/).join(', ')`

首先你定义一个字面字符串,然后对它进行扫描,查找字母表中的字符(用/\w/),最后把返回数组的所有元素链接起来,以逗号分隔.

如果不想扫描特定字符,而是想把字符串切分成几个部分,应该怎么办!?我们可以使用`split`方法,告诉它把字符串按句点切成字符串数组,如下:
`puts "Short sentence. Another. No more.".split(/\./).inspect`

这里有几个要点. 首先,如果你在正则表达式中使用`.`而不是`\.`,则会按每个字符,而不是按整句进行切分.因为在正则表达式中, `.`表示"任何字符",因此你需要在前面加上反斜杠,将其转义(escape)(转义是特别标注某个字符,令其含义清晰的过程).其次,无需链接并带你出结果.通过使用inspect方法,便可以得到更紧凑的结果.

在Ruby中,几乎所有内置类都有inspect方法,它给出对象的文本化表示形式.例如:从上文结果数组的输出可以看出,它与我们自己创建数组的输出是一样的.在摸索试验和调试程序时,inspect是个及其有用的方法!

split也能胜任按换行符或同事按多个字符进行切分,以得到更简洁的结果.
`puts "Words with lots of spaces".split(/\s+/).inspect`

##### 数组迭代
在数组中进行迭代的方法很简单,用each方法即可.each方法遍历数组的每个元素,并把钙元素当作参数,传递给你提供的代码块.例如:
`[1, "test", 2, 3, 4].each {|element| puts element.to_s + "x"}`

尽管each方法可以在数组的元素中进行迭代,你还可以用collect方法,对数组进行实时转换:
`[1, 2, 3, 4].collect {|element| element * 2}`

collect方法在数组中逐个元素的进行迭代,并用代码块中表达式的结果,对该元素进行赋值.在本例中,把元素的值乘以2.

来自非动态语言,甚至非面向对象语言阵营的程序员,可能认为这些技术方法很时髦,如果有必要,也可以用"老式方法"编写Ruby程序:

    a = [1, "test", 2, 3, 4]
    i = 0

    while (i <a.length)
      puts a[i].to_s + "X"
      i += 1
    end

这与前面each例子类似,但对于传统程序员(例如用C或者BASIC语言)来说,更熟悉这种在数组循环的方法.然而,任何人都能立即看出,为什么迭代子,代码块和注入each和collect等方法更适合Ruby,因为它们显著的提升了代码的易读性和可理解度.

##### 数组的其他方法
###### 数组假发和串联
如果有两个数组,我们可以快速合并为一个.

    x = [1, 2, 3]
    y = ["a", "b", "c"]
    z = x+y
    puts z.inspect

###### 数组减法和区分
也可以比较两个数组, 方法是用一个数组减去另一个.这一方法结果是从主数组中删除两个数组中都有的元素:

    x = [1, 2, 3, 4, 5]
    y = [1, 2, 3]
    x = x-y
    puts z.inspect

###### 检查数组是否为空
如果打算在数组中迭代,可能想检查它是否还有元素.可以用`array.size`或`array.length`是否大于0的方法来检查,更流行的快捷方法是用`empty?`:

    x = []
    puts "x is empty" if x.empty?

###### 检查数组是否有某个元素
用`include?`方法,如果给定参数在数组中能找到则返回true,否则返回false:

    x = [1, 2, 3]
    puts x.include?("x")
    puts x.include?(3)

###### 访问数组中第一个和最后一个元素
访问数组中第一个和最后一个元素的方法很简单,可用first和last方法

    x = [1, 2, 3]
    puts x.first
    puts x.last

如果对first或last方法指定数字参数,则得到数组从开始或最末起的n个元素

    x = [1, 2, 3, 4]
    puts x.first(2).join("-")

###### 反转数组元素的顺序
与字符串一样,数组也可以被反转

    x = [1, 2, 3]
    puts x.reverse.inspect

#### 散列表
数组是对象的几何,散列表也是.然而,散列表有不同的存储格式,以及在集合中定义每个对象的不同方法.散列表中的对象不在列表中给定位置,而是给定一个指向对象的键(key),散列表更像字典,而不像列表,因为它没有确定的顺序,只有键和值之间的简单链接,下面是个基本的散列表,其中有两个元素:
`dictionary = { 'cat' => 'feline animal' , 'dog' => 'canine animal' }`
保存散列表的变量名为dictionary,它包含两个元素,我们可以证明一下:
`puts dictionary.size`

其中一个元素的键为cat,值为feline animal; 另一个元素的键为dog,值为canine animal,与数组类似,我们可以用方括号来引用要检索的元素.例如:
`puts dictionary['cat']`

如你所见,散列表可被视为数组,其元素具有名字,而非位置序号.我们甚至可以用与数组想通的方法,来改变散列表的值:

    dictionary['cat'] = "fluffy animal"
    puts dictionary['cat']

###### 虽然以下内容不会马上排上永昌,但是值得一提.键和值都可以是任何类型的对象,因此,可以把数组(甚至是另一个散列表)用作键.当将来想处理更复杂的数据结构时,这一点可能派得上用场

##### 散列表的基础方法
和数组类似,散列表有许多有用的方法.
###### 在散列表元素中迭代
对于数组,可以用each方法在数组元素中迭代.对散列表也可以进行比项操作,但由于散列表每个元素都用键,因此迭代的相应顺序不是固定的:

    x = {"a" => 1, "b" => 2}
    x.each {|key, value| puts "#{key} equals #{value}"}

散列表的each迭代子方法是将两个参数传递给代码块: 第一个是键, 第二个是该键对应的值.在本例中,把它们赋给名为Key和value的变量,并用字符串插写方法,将其内容显示到屏幕上!

###### 检索健
有时我们对散列表中的值并不感兴趣,而对散列表包含什么内容感兴趣.实现此目的的有效方法是查看健.Ruby提供了keys方法,可以很容易的立即查看任何散列表的键:

    x = {"a"=> 1, "b"=>2, "c"=>3}
    puts x.keys.inspect

keys方法返回数组,其中包含散列表中的所有键.如果你状态良好的话,就能想到values方法也会返回数组,其中包含散列表中的所有值.但一般来说,我们会通过键查看值.

###### 删除散列表中的元素
三处散列表元素很简单,用delete方法即可.只需传递键作为参数,该元素即可被删除:

    x = ["a" => 1, "b" => 2]
    x.delete("a")
    puts x.inspect

###### 有条件删除散列表中的元素
假设我们想删除散列表中值小于某个标准的所有元素:

    x = {"a"=>100, "b"=>20}
    x.delete_if{|key, value| value<25}
    puts x.inspect

##### 散列表中的散列表
散列表中可能使用散列表,甚至数组,甚至散列表中的散列表!因为一切都是对象,而散列表和数组可以包括任何类型的对象.因此可以用散列表和数组创建巨大的树结构:

      people = {
      'fred' => {
      'name' => 'Fred Elliott',
      'age' => 63,
      'gender' => 'male',
      'favorite painters' => ['Monet', 'Constable', 'Da Vinci']
    },
      'janet'=>{
      'name' => 'Janet S Proter',
      'age => 55',
      'gender'=>'female'
    }
    }
    puts people ['fred'] ['age']
    puts people ['janet'] ['gender']
    puts people ['janet'].inspect

尽管这个散列表的结构初看起来有些令人迷惑,但当你把它划分为几部分时,就变得相当简单.'fred'和'janet'部分本身是简单的散列表,它们被包装在另一个巨型散列表中,并赋值给people.在查询该巨型散列表的代码时,你只是把每个查询串联起来,形成`puts people['fred']['age']`.这段代码首先得到people['fred'], 返回Fred的散列表,然后再对此三列表访问['age'],得到结果63.
甚至反问嵌在Fred散列表中的数组也很简单:

    puts people['fred'] ['favorite painters'].length
    puts people['fred'] ['favorite painters'].join(", ")

#### 流程控制
在本章中,我们用if和unless,根据条件执行不同的操作,并对其进行比较.if和unless对单行代码很有效,当它们与打断代码合并使用时,将变得更有威力.本节将带你见识Ruby怎样用这些程序和其他语法结构,来控制程序流程.

##### if与unless
本章首次使用if的是下面的例子:

    age=10
    puts "You're too young to use this system" if age < 18

如果age的值小于18,则把字符串打印输出到屏幕上,下面代码的功能与此完全想通:

    age = 10
    if age <18
      puts "You're too young to use this system"
    end

这段代码看起来似乎很熟悉,如果表达式为true就执行if和end之间的代码,而不是把if表达式放在但行代码的末尾.此外,这种结构可以在if语句和end行之间放置任意多行代码:

    age = 10
    if age < 18
      puts "You're too young to use this system"
      puts "So we're going to exit your program now"
      exit
    end

值得一提的是,unless可以实现相同的效果,因为unless正式if的反义词:

    age = 10
    unless age >= 18
      puts "You're too young to use this system"
      puts "So we're going to exit your program now"
      exit
    end

也可以嵌套代码逻辑,如下:

    age = 19
    if age < 21
      puts "You can't drink in most of the United States"
      if age >= 18
        puts "But you can in the United Kingdom!"
      end
    end

if和unless也提供了else条件,用来界定主表达式为false时想执行的代码:

    age = 10
    if age < 18
      puts "You're too young to use this system"
    else
      puts "You can use this system"
    end

##### ?:, 三元运算符
三元运算符可以让表达式包含小型if/else语句,构建这一运算符,完全是为了可选用途.有些开发人员完全把它遗忘了.但由于它可以用来生成紧凑的代码,因此值得早点学会.

    age = 10
    type = age<18?"chile":"adult"
    puts "You are a "+type

第二行包含三元运算符,它是以把表达式的结果赋值给变量type开始,表达式是age<18?"child":"adult",其结构规则如下:
`<condition>?<result if condition is true>:<result if condition is false>`

例子中,age<18返回true,因此返回第一个结果"child"并赋值给type.但如果age<18是false,则返回"adult"结果.

我们来看另一种实现方法:
    
    age = 10
    type = 'child' if age < 18
    type = 'adult' unless age < 18
    puts "You are a "+type

两次比较让这段代码更难阅读.另一种实现方法是用多行的if/else选项

    age = 10
    if age < 18
      type = 'child'
    else
      type = 'adult'
    end
    puts "You are a "+type

三元运算符显示了其简洁而能立即得到的好处,由于它可以再一行代码中构建表达式,因此可以很容易地使用方法调用或再其他表达式中调用,这是if语句无法做到的.我们来看本节开头的更简单版本.

    age = 10
    puts "You are a "+(age < 18? "child" : "adult")

##### elsif与case
有时需要用同一个变量用作几次比较,也可以用前面提到的if语句来实现:

    fruit = "orange"
    color = "orange" if fruit == "orange"
    color = "green" if fruit == "apple"
    color = "yellow" if fruit == "banana"

如果fruit不等于orange,apple或banana,我们又想用else来赋值,那么很快就会弄得一团糟.因为你需要创建if块来检查这些词是否出现,然后执行和前面一样的比较.另一种方法是用elsif,表示"否则如果:"

    fruit = "orange"
    if fruit == "orange"
      color = "orange"
    elsif fruit == "apple"
      color = "green"
    elsif fruit == "banana"
      color = "yellow"
    else
      color = "unknown"
    end

elsif块和else块类似,区别在于你可以指定要执行的全新比较表达式,如果都不匹配,则指定要执行的常规else块.
这种技术方法的另一种变化形式是用case块.把我们前面的例子用case块来改写,如下:

    fruit = "orange"
    case fruit
      when "orange"
        color = "orange"
      when "apple"
        color = "green"
      when "banana"
        color = "yellow"
      else
        color = "unknown"
      end

除了语法更清晰外,这段代码与if块类似.case块首先处理表达式,然后找出匹配该表达式的when块并执行,如果找不到匹配的when块,则转而执行case块中的else块.
case还有另外一个巧妙的手法,由于所有Ruby表达式都返回结果,因此可以把上例改的更短:

    fruit = "orange"
    color = case fruit
      when "orange"
        "orange"
      when "apple"
        "green"
      when "banana"
        "yellow"
      else
        "unknown"
      end

再本例中,我们用了case块,然而把任何被执行内部块的结果直接赋值给color

##### while与until
在前面的章节中,我们已经演示用迭代子方法进行循环,如下:
`1.upto(5) {|unmber| puts number}`
但也可以用其他方法来循环代码.while和until根据每次循环的比较结果,来循环代码:

    x=1
    while x<100
      puts x
      x = x*2
    end

再本例中,有个while块,它标示了一段循环代码,只要满足x<100表达式,这段代码就反复循环下去.因此,再每次循环之后,x的值翻倍并打印输出到屏幕.一旦x等于或超过100,则循环结束.

until提供了相反的功能,直到某个条件满足才循环:

    x = 1
    until x > 99
      puts x
      x = x*2
    end

也可以再一行代码中使用while和until,与if和unless的用法类似:

    i = 1
    i = i*2 until i > 1000
    puts i

i的值一遍遍地翻倍,知道结果超过1000,此时循环才终止.

##### 代码块
本章已经多次用到代码块,例如:

    x - [1, 2, 3]
    x.each {|y| puts y}

each方法接受单个代码块作为参数,该代码块的定义位于{和}符号之间,或位于do和end分界线之间:

    x = [1, 2, 3]
    x.each do |y|
      puts y
    end

再{和}之间活do和end之间的代码是代码块,本质上是匿名的,无名的方法活函数.这段代码传递给each方法,由后者对于数组的每个元素运行该代码块.
我们可以编写自己的方法,来处理代码块:

    def each_vowel(&code_block)
      %w{a e i o u}.each {|vowel| code_block.call(vowel)}
    end

    each_vowel {|vowel| puts vowel}

each_vowel接受代码块参数,再其方法定义中,code_block参数名之前的宏符号(&),表示该参数是代码块.该方法对字面数组%w{a e i o u}的每个元音字母进行迭代,并调用code_block的call方法,对每个元音字母执行代码块,将元音字母作为vowel变量参数,传递给call方法.

###### 以这种方法传递的代码块,产生的结果是对象,它有许多自己的方法.例如call,请记住,再Ruby中一切都是对象!

另一种技术方法是用yield方法,它能自动检测传递给它的代码块,并将控制权移交给该代码块:

    def each_vowel
      %w{a e i o u}.each{|vowel| yield vowel}
    end

    each_vowel {|vowel| puts vowel} 

本例的功能与上例完全相同,尽管看起来不太明显,在函数定义中看不到它是如何接受任何代码块的.到底用哪种方法,选择权再你.

###### 一次只能传递一个代码块,任何方法都不可能接受两个活多个代码块作为参数.但是,但吗快本身可以接受零个,一个或多个参数!

也可以用lambda方法,把代码块存储再变两种:

    print_parameter_to_screen = lambda {|x| puts x}
    print_parameter_to_screen.call(100)

与方法接受代码块类似,用lambda对象的call方法来执行代码块,以及接受传递来的任何参数.

###### 用lambda一词是因为它再其他地方和其他编程语言中很流行,你当然可以继续称其为代码块,有时也叫它过程(Proc).

#### 其他有用的构造元素
到目前为止,本章讨论了数字,字符串,数组和散列表等主要的内置类.这集中类型的对象可以让你做很多事情,并将它们广泛用于所有程序中.第六章将对对象进行深入讨论,但在此之前,还有几个其他重点内容需要先介绍一下.

##### 日期与时间
在许多计算机程序中,有个有用的概念叫时间,其表示形式是日期和时间.Ruby提供了名为Time的类来处理这些概念.
Time的内部机制是用微秒值来保存时间,这是根据UNIX的时间基准里程碑(UNIX time epoch): 格林尼治标准时间(GMT) /协调世界时(UTC) 1970年元月1日0时0分0秒.有了这个时间基准里程碑,就可以很容易用标准的标胶运算符.例如`<`和`>`,进行时间的比较.
我们来看怎样使用Time类:
`puts Time.now`

Time.now创建了Time类的实例,该实例的时间被设为当前时间.但由于我们要把它打印输出的屏幕,因此它被转换成上述字符串.
我们还可以用增加活减少秒数的方法来操作时间对象.例如:

    puts Time.now
    puts Time.now-10
    puts Time.now + 86400

在第一个例子中,我们先打印输出当前时间,然后把当前时间减去10秒,再把当前时间加上86400秒(正好一整天).由于时间如此容易操作,所以有些开发人员对Fixnum类进行扩展,加上某些辅助方法,让日期操作更容易:

    class Fixnum
      def seconds
        self
      end
      def minutes
        self *60
      end
      def hours
        self *60 *60
      end
      def days
        self *60 *60 *24
      end
      end

    puts Time.now
    puts Time.now+10.minutes
    puts Time.now+16.hours
    puts Time.now-7.days    

如果这段代码看起来不是很熟悉,且令人迷惑,请别担心,因为我们将再后续章节进一步讨论这种类型的技术方法.但请务必注意最后几个puts语句的风格,有了这些辅助方法,日期操作就变得很容易.

Time类还允许根据任意日期创建Time对象:
`Time.local(year, month, day, hour, min, sec, msec)`

上述代码更具当前(本地)市区创建Time对象,从month开始的所有参数都是可选的,默认值为1或0.你还可以指定月份数值(1~12)或英文月份名的三字母缩写.
`Time.gm(year,month, day, hour, min, sec, msec)`

上述代码根据CMT/UTC来创建Time对象,所需参数与Time.local相同.
`Time.utc(year, month, day, hour, min, sec, msec)`

上述代码与Time.gm同义,尽管有些人可能更喜欢这个方法的名字
你还可以把Time对象转换成整数形式,其值是自UNIX时间基准里程碑以来的秒数:
`Time.gm(2007, 05).to_i`

同样,你也可以把基准时间转换回Time对象.如果要把时间和日期保存到文件,或某种只需整数而非整个Time对象的格式,这种方法就很有用:

    epoch_time = Time.gm(2007, 5).to_i
    t = Time.at(epoch_time)
    puts t.year, t.month, t.day

除了展示再Time对象和基准时间之间的转换,这段代码还展示了Time对象拥有检索某个阶段日期/时间的方法,这些方法的列表如:

###### 3-6 Time对象用于房分日期/时间属性的方法

1.  hour  表示24小时格式的数字(例如21表示下午9点)
2.  min   整点之后经过的分钟数
3.  sec   整分钟之后经过的秒数
4.  usec  整秒之后经过的微秒数(一秒钟有一百万微妙)
5.  day   日期是该月的第几天
6.  mday  与day方法同义,被视为"月份"天数
7.  wday  按周计的天数(星期天是0, 星期六是6)
8.  yday  按年计的天数
9.  month 日期的月份数值(例如11表示11月)
10. year  日期关联呃年份
11. zone  返回时间关联的时区名
12. utc?  根据时间/日期是否再UTC/GMT失去,返回true活false
13. gmt?  与utc?方法同义,供喜欢GMT一词的人使用

请注意,这些方法是从日期或时间中检索其相应属性,而不能用于设置属性.如果你想修改日期或时间,要么增加活减少秒数,要么用Time.gm或Time.local方法创建信的Time对象.

###### 注: 再第16章节中,你会看到有个名为Chronic(惯用法)的Ruby程序库,它能让你以自然的英语风格指定日期和时间,并将其转换成合法的Time对象.

##### 大数字
我们通过Ruby用迭代子和一些插写功能,创建一下一个模拟程序:

    rice_on_square = 1
    64.times do |square|
      puts "On square #{square +1}are #{rice_on_square}grain(s)"
      rice_on_square *=2
    end

这个证明了Ruby能够处理及其巨大的数字,而且与许多其他编程语言不同,Ruby没有任何不方便的限制.
其他语言常常有数字大小的限制,通常是32个二进制位,即强制使用32位整数的语言最大值极限大约为42亿.大多数操作系统和计算机架构体系也有类似的限制.而Ruby与众不同,它能在计算机原生(即容易的)处理的数字,和需要更多预处理的数字之间,进行无缝的转换.此外,它是用不同的类来完成这一工作的,一个叫做Fixnum类,表示容易管理的较小数字;另一个叫做Bignum类,表示Ruby需要内部管理的"大"数字.再大多数系统中,边界值数字是`1 073 741 823`,你可以用irb来体验一下.
`puts 1073741823.class`,`puts 1073741824,class`  

如果得到的结果有所不同,请别担心,Ruby会帮你处理Bignum和Fixnum数字,也可以进行算数和其他运算,不会有任何问题.这一结果根据计算机体系架构而有所不同,但无须担心.这些变化都完全由Ruby来处理.

##### 范围
在某些情况下,能够保存列表的概念,而不是保存其实际内容,是一件很有用的事.例如:如果想表示A到Z的所有字母,可以创建数组,如:
`x = ['A', 'B', 'C', 'D', 'E' .. and so on..]`
这的确不错,尽管它只保存了"A到Z之间的所有内容"这一概念,而运用范围(Range)也可以做到:
`('A'..'Z')`
就本身来说,范围没有太大用处,但Range类提供了简单的to_a方法,可把范围转换成数组:
`('A'..'Z').to_a.each {|letter| print letter}`
这段代码很紧凑,但确实完成了工作.它把'A'到'Z'的范围转换成26个元素的数组,每个元素包含字母表中的一个字母,然后用前面数组章节用过的each方法,对每个元素进行迭代,把值传给了letter,然后把letter打印输出到屏幕.

###### 注: 因为用的是print方法而不是puts,字母将一个接一个的打印输出再同一行,而puts方法则每次从新行开始打印输出.

检验某数据是否包含再范围指定的对象集合中,有时也是很有用的.例如: 有了('A'...'Z')范围,你可以用include方法,检查R是否再此范围内:
`print "R is within A to Z!" if ('A'..'Z').include?('R')`
然而,"r"是小写字母,因此不在此范围内:
print "R is within A to Z!" if ('A'..'Z').include?('r')

还可以把范围当成数组的索引,一次选择多个元素

    a = [2, 4, 6, 8, 10, 12]
    puts a[1..3].inspect

同样,也可以用范围来一次设置多个元素:

    a[1..3] = ["a", "b", "c"]
    puts a.inspect

此外,你可以对隶属许多不同类的对象使用范围,包括自己创建的类的对象.

##### 符号
在主流语言中,符号(Symbol)是Ruby相当独特的概念(尽管LISP和Erlang语言也有类似的概念.)符号的威力强大,大多数专业Ruby开发人员都用它,尽管大多数初学者容易迷糊不解,然而它值得学习:

    current_situation = :good
    puts "Everything is fine" if current_situation == :good
    puts "PANIC!" if current_situation == :bad

在本例中,:good和:bad都是符号.符号不包含值活对象,不像变量那样,而是用作代码中固定的名字.例如:前面的代码中你可以方便的把符号替换成字符串:

    current_situation = "good"
    puts "Everything is fine" if current_situation == "good"
    puts "PANIC!" if current_situation == "bad"

这段代码的结果与上一段代码相同,但效率不高.本例中,每次提到"good"和"bad"时,都在内存中分别创建了新对象,而符号则仅是引用值,只初始化一次.在第一个代码示例中,只存在:good和:bad,而第二个代码示例中,有"good","good"和"bad"三个完整的字符串占用内存.

符号还让代码在很多情况下看起来更简洁.有时你常常会用符号来指定方法的参数名,因为把不同的字符串数据和固定信息用符号来表示,会产生更容易阅读的代码.

你可能要把符号看成是无值的字面常量,但符号的名字是最重要的因素.如果你把:good符号赋值给变量,并在后边的代码中将该变量与:good相比较,将会得到匹配的结果.因此,在不需要保存实际值,只需保存概念或选项的情况下,符号很有用.

符号在创建散列表时特别有用,可以用它来区分键和值:
`s = {:key => 'value'}`

这种方法还可用于规约或统一使用哪个键名的情况下:

    person1 = {:name => "Fred", :age => 20, :gender => :male}
    person2 = {:name => "Laura", :age => 23, :gender => :female}

Ruby提供的类中,有许多方法采用这种风格来传入信息(也常常用于返回值),在本书中你将一直看到这种构造方法的例子.

##### 类间转换
数字,字符串,符号和其他类型的数据,都是隶属于不同类的对象.数字属于Fixnum,Bignum,Float或Integer类,字符串是String类的对象,符号是Symbol类的对象,诸如此类.

在大多数情况下,我们可以在不同的类之间转换对象,因此数字可变成字符串,而字符串也可变成数字:

    puts "12" + "10"
    puts 12 + 10

第一行代码把两个字符串加起来,它们正好表示数字,得到1210的结果.第二行把两个数字加起来,得到22的结果.
然而,可以把这些对象转换成不同的类的表示形式:
    
    puts "12".to_i + "10".to_i
    puts 12.to_s + 10.to_s

数据表用to_方法转换,String类提供to_i和to_f方法,把字符串相应转换成Integer或Float类的对象,String类还提供了to_sym方法,把字符串转换成符号.符号提供了反向方法,用to_s方法可以把它转换成字符串.

同样,数字类支持to_s方法,把自己转换成文本表示形式,同理to_i和to_f则是转换成整数和浮点数的方法.

#### 小结
本章中,见识了所有计算机程序的关键构建元素--数据,表达式和逻辑,并掌握怎样用Ruby来实现它们.本章的主题为本书其他每一章节提供了重要的基础.因为将来编写的几乎每一行代码都包含表达式,迭代子或某种逻辑.

###### 注:请务必记住,由于Ruby很宽泛,在此我无法涵盖所有各个类和方法的组合,在Ruby中还有更多的方法来做一件事,在进入到本书后边更高级的技术之前,我们首先看到的是最简单的途径.

到目前为止,你还没有被Ruby中的数据不同类型搞的疲惫不堪.在第二章提到的对象和类,实际上也是数据的类型,尽管它们看起来好想不是.在第六章我们将直接操作对象和类,操作方法与本章操作数字和字符串类似,但总体思路将会变得清晰.
在第四章我们将开发一个完整而基础的Ruby程序,但是在进入第四章之前,我们来回顾一下到目前位置讨论的内容:

* 变量: 我们已经在第二章中糖果,但本章扩展了已有只是,变量是对象的占位符,对象范围包括数字,文本,数组或任何自己创建的对象.
* 运算符: 在表达式中用来操作对象.例如\+, \-, \*, /. 也可以用运算符来进行比较.例如<, >和&&.
* 整数: 完整的数字,例如5或者928379.
* 浮点数: 有小数点部分的数字,例如1.0或3.141592
* 字符: 单个字母,数字,空格或印刷符号
* 字符串: 注入"Hello World!"或"Ruby is cool"等字符的集合.
* 常量: 有固定值的变量.常量名以大写字母开头.
* 迭代子: 注入each,upto或times等的特别方法.它们在列表中逐个元素的进行步进.这一过程称为迭代,而each,upto或times称为迭代子方法.
* 插写: 表达式与字符串的混合.
* 数组: 有指定规则顺序的对象或值的集合.
* 散列表: 与键关联的对象或值的几何.键可用于在散列表中查找其对应的值.但散列表中的元素没有特定顺序.它是一种查找表,更像书或字典的索引.
* 正则表达式: 秒数匹配和比较的文本模式.
* 流程控制: 根据某个条件和状态,管理要执行哪一段代码的过程.
* 代码块: 一段代码,常用语迭代子的参数,没有具体的名字,本身也不是方法,但可被以参数接收它的方法调用和处理.代码块还可被保存在变量中,作为Proc类的对象.
* 范围: 从开始值到结束值整个范围的表示形式.
* 符号: Ruby符号是独特的引用.符号和变量不同,它不包含值,但可用于在代码中保持一致的引用.它可被视为无值的常量.

是让我们把这些基础元素放在一起的时候了,在第四章我们将开发一个完整的运行程序.
































