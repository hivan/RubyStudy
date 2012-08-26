# 开发基础的Ruby应用程序
到现在为止,我们关注的焦点一直是Ruby语言基础只是,并考察这些只是的底层运作方式.本章我们将转移到真正的软件开发世界,开发一个完整的,基础的,具有一组基本功能的Ruby应用程序.一旦完成这一基础程序的开发和测试,我们将考察扩展这一程序的不同方法,让它变得更加有用.在我们的开发旅程中,将讨论本书目前尚未提到的一些新内容.
首先,在进入真正的编程之前,我们先来看一下基本的源代码组织方法.

## 4.1 处理源代码文件
到目前为止,本书一直用irb这个即时提示符程序来学习Ruby语言,但如果想开发重复使用的程序,必须把源代码保存到磁盘文件中(或因特网,光盘中)

### 创建测试文件
### 测试用源代码文件
开发环境建立好之后,就可以编辑和保存文本文件了.请输入下面的代码:

    x=2
    print "This application is running okay if 2+2 = #{x+x}"

###### 注: 如果你看不懂这段代码,那么可能是你跳过的章节太多了,所以请回头看第三张!本章需要你完全掌握第三章的所有知识.

用a.rb文件名保存这段代码,放在所选择的目录.

###### 注: RB是Ruby文件扩展名的事实标准,就像PHP是标准的PHP文件,TXT是普通的文本文件,JPG是JPEG图像文件的标准扩展名一样.

### 运行原代码
创建了基本的Ruby源代码文件a.rb之后,就该让Ruby执行它.和以往一样,执行的过程也因操作系统而异.
无论何时,当本书请你"运行"程序时,下面都是你每次要做的步骤

###### 注: 尽管本章开始让你开发应用程序,但还是有机会在本章使用irb,来试验测试代码.或探索基础理论的工作机制.请你自行判断,并在两种开发方法之间切换.irb对于验证小概念和简短代码块极其有用,它让你无需在文本编辑器和Ruby解释其之间麻烦的跳转.

Mac OS X平台(###### 因为本人所用的是Mac,所以只记录了此种方法.)
在Mac上,运行Ruby程序的最简单方法是从Terminal终端程序运行,和irb的运行方式一样.

1. 启动Terminal程序
2. 用cd命令进入存放`.rb`文件的文件夹.
3. 输入`ruby *.rb`并按回车键,即可执行这个Ruby脚本文件
4. 如果你看到错误信息,例如:`ruby: No such file or directory -- *.rb(LoadError)` 则表示没有位于`*.rb`源文件你要找的文件夹.

## 4.2 我们的目标程序: 文本分析器
本章你要开发的程序是个文本分析器,该程序读入单独文件提供的文本内容,对其进行各种模式的分析和统计,并向用户打印输出分析结果.这不是个三维图形冒险程序,也不是个精美的网站,但文本处理程序是系统管理维护和大多数程序开发的基础,它是日志文件分析,网站用户提交文本的分析和其他文本数据分析的生命线.
Ruby非常适合做文本和文档分析,它的正则表达式功能,以及简单易用的scan和split函数,将在你的程序中得到大量使用.

###### 注: 对于本程序来说,重点是快速实现其功能,而不是开发一套详细的面向对象结构.

### 基本功能需求
文本分析器将提供一下基本统计数据:
* 字符数统计
* 字符数统计(不含空格)
* 行数统计
* 字数(单词数)统计
* 文句数统计
* 段落数统计
* 平均每句包含几个单词
* 平均每段包含几个文句
对于最后两个功能需求,统计结果可从其他统计数据中方便的计算出来.也就是说,有了总字数(单词数)和总语句数,要得到平均每句含几个单词,只是个简单的除法工作.

### 构建程序基本框架
在开始开发新程序时,想好需要哪些关键步骤是很有用的.过去常常用画流程图(flowchart)的方式,来展示计算机程序的操作是怎样流转的,但有了现代工具,例如Ruby,我们就可以很容易试验,修改,并保持敏捷的开发效率,我们先来勾勒出这个程序基本步骤,如:
1. 载入包含待分析文本或文档的文件
2. 在逐行载入文件时,统计有多少行(这是你关心的统计结果之一)
3. 把文本放到字符串中,测量其长度以得到字符数统计
4. 临时删除所有空白,并测量得到结果字符串的长度,得到不含空格的字符数.
5. 切分所有空白,得出有多少个字(单词)
6. 按句号切分,得出有多少段落.
7. 按双换行符切分,得出有多少段落.
8. 进行计算,得出平均数
创建新的Ruby源文件,并保存为analyzer.rb,放在Ruby文件夹中,在下面,我们将用代码填充这个文件.

### 获取哑文本
在开始编码之前,第一步是获取某些测试数据,供分析器进行分析."雾都孤儿"(Oliver Twist)第一章是理想的文本,因为它开放了版权,而且容易获取,还有相当的长度.你可以从`http:.//www.rubyinside.com/book/oliver.txt`网页或`http://www.dickensliterature.com/Oliver_Twist/0.html`网页获得这段文本,把它拷贝到本地文本文件中,将该文件保存到与a.rb想通的目录,命名为text.txt.程序将默认从text.txt读取文本内容(当然,后面将把它改为更加动态化,并可以接受其他数据来源).

###### 提示: 如果网页无法访问,用你喜欢的搜索引擎搜索"twist workhouse rendered profound thingummy".或者用其他大段文本代替.

### 载入文本文件并统计行数
现在开始编码!第一步是载入文件,Ruby通过File类提供了一套全面的文件操作方法,其他语言需要你先做几步准备,而Ruby则让接口相当简单,下面是打开text.txt文件的代码:
`File.open("text.txt").each{|line| puts line}`
在`analyzer.rb`文件中输入这段代码,并运行.如果text.txt文件在当前目录中,则将看到整个文件内容在屏幕上.
在这段代码中,要求File类打开text.txt文件,然后,与数组想死,你可以对该文件直接调用each方法,导致每行内容逐次传递给内部代码块,由puts将该行内容输出到屏幕.(在第九章,你将看到文件访问和操作的内部希捷,以及比本章所用方法更好的技术方法)
编写这段代码,改成如下形式:
    
    line_count = 0
    File.open("text.txt").each{|line| line_count += 1}
    puts line_count

这段代码中,先初始化`line_count`变量,来保存行数统计,然后打开文件,并迭代读取每一行内容,每次对`line_count`加1.
现在我们统计了行数,但还没有检查文件内容,以便统计字数(单词数),段落数,句子数等统计值,这很容易修改,我们来稍微修改一下代码,假如text变量,收集各行内容:

    text = ''
    line_count = 0
    File.open ("text.txt").each do |line|
      line_count += 1
      text << line
    end

    puts "#{line_count} lines"


###### 注: 请记住,用{和}来包含代码块,是单行代码块的标准风格,而do很end则更常用于多行代码块.不过这只是管理,而非必须的要求.

与前面的代码相比,这段代码引入了text变量,并把每行内容逐次加到变量中.当文件的迭代读取完成后--也就是说,读完所有行之后,text就把整个文件的内容包含在单个字符串中,供你后续使用.
 
这种把文件内容放到单个字符串中并统计行数的方法看起来很间接,但File类还有其他更快的读取文件方法:

    lines = File.readlines("text.txt")
    line_count = lines.size
    text = lines.join

    puts "#{line_count} lines"

File类实现了readlines方法,可把整个文件逐行读取到数组中,我们既可以用它来统计行数,也可以把它们合并到单个字符串中.

### 统计字符数
整个文件内容已经被收集到了text变量中,而且text还是个字符串,因此可以用所有字符串都有的length方法,得到确切的大小,在`analyzer.rb`末尾,添加以下内容:

    total_characters = text.length
    puts "#{total_characters} characters"

想得到关于字符的第二个统计数,是空格除外的总字符数(上例给出的是包含空格的字符数).如果你还有印象,应该能会想起第三章中,字符串都有用来进行全局替换(类似搜索与替换)的gsub方法.例如:
`this is a test`.gsub(/t/, 'X')

同样,你可以用gsub方法来去掉text字符串中的空格,然后对新的"去空格的"text字符串,用length方法得出其长度.请把下面的代码加到analyzer.rb文件中:

    total_characters_nospaces = text.gsub(/\s+/, '').length
    puts "#{total_characters_nospaces} characters excluding spaces"

### 统计字数
可以用几种方法得到这一功能
1. 用scan方法统计连续字符组的个数
2. 用split方法按空格切分字符串,并用size方法统计切分之后的片段个数.

我们逐个来看这两种方法,看哪一种最好.scan方法的工作机制是在文本字符串中迭代,并反复找出特定模式:
`puts "this is a test".scan(/\w/).join`
本例中,scan搜索字符串中匹配\w的内容,这里\w表示字母表中的任何字符(以及下划线),然后,将找到的内容链接成一个字符串,并打印输出到屏幕.
可以用文字和数字字符组实现同样的功能.
`puts "this is a test".scan(/\w+/).join('-')`

要得到字符串中的单词数,可以用length或size这两个数组方法,来统计数组中的元素个数,而非将其链接起来.
`puts "this is a test".scan(/\w+/).lenghth`

split方法展现了Ruby(以及某些其他语言,特别是Perl)的核心原则,即"总有不止一种解决方法!"对同一个问题能找到多种不同的解决方法,是称为优秀程序员的决定因素,因为不同解决方法的功效是各不相同的.

我们把字符串按空白切分,并得出结果数组的长度:
`puts "this is a test".split.length`

split方法默认按空白(单个或多个空格,制表符,换行符等)进行划分,这样以来,与scan方法相比,代码就变得更短,而且更容易阅读.

那么,这两种方法的区别何在!?很简单,一个是搜索并返回各个字(单词)供你进行统计,另一个是根据各个字(单词)之间的分隔符(即空白)来切分字符串,并得出该字符串被切分成多少个部分.有趣的是,这两种方法可得出不同的结果:

        text = "First-class decisions require clear-headed thiking."
        puts "Scan method: #{text.scan(/\w+/).length}"
        puts "Split method: #{text.split.length}"

scan方法是搜索所有文字数字字符块的,因此得到句子中有7个单词的统计结果.而如果按空白划分,则得到5个单词的统计结果.原因在于由连字号相连的单词,连字号不是"文字数字字符",因此scan方法把"first"和"class"视为两个单独的单词.

回到analyzer.rb文件,我们把学到的方法应用起来,增加下面的代码:

        word_count = text.split.length
        puts "#{word_count} words"

### 统计句子和段落数
理解了统计字数(单词数)的方法逻辑之后,统计文句数和段落数就变得很简单.我们不是按空白进行切分,因为文句和段落有另外的切分规则.

文句以句号,问号和惊叹号结尾,也可以用省略号和其他标点符号分开.但我们这里无须担心这些罕见情况.切分操作很简单,我们不再要求Ruby按一种类型的字符来切分文本,而是只按三种类型的字符进行切分,如下:
`sentence_count = text.split(/\.|\?|!/).length` 
正则表达式看起来很奇怪,但句号,问号和惊叹号可以看的很清楚.我们直接来看正则表达式:
`/\.|\?|!/`

开头和结尾的斜杠是正则表达式的常用分界符,因此可以忽略.第一部分是\\.,表示句号.为什么不直接用\.,而加反斜杠呢?原因在于,\.在正则表达式中表示"任何字符".因此需要用反斜杠进行转义,表示它是字面字符的句号.这也解释了为什么问号也用反斜杠进行转义.因为问号在正则表达式中表示"零个或一个前一字符".而\!则未转义,因为它在正则表达式中没有其他特殊含义.

管道符号(|字符)把三个主要字符分开,表示分别对待这三个字符,可匹配其中任一个字符,这样以来,`split`即可同时按句号,问号和惊叹号进行切分,你可以测试一下:
`puts "Test code! It works. Does it? Yes.".split(/\.|\?|!/).length`

        text = %q{
            This is a test of
            paragraph one.

            This is a test of
            paragraph two.

            This is a test of
            paragraph three.
        }
        puts text.split(/\n\n/).length

我们把这些概念都加到analyzer.rb中

        paragraph_count = text.split(/\n\n/).length
        puts "#{paragraph_count} paragraphs"

        sentence_count = text.split(/\.|\?|!/).length
        puts "#{sentence_count} sentences"

### 计算平均值
统计每句的平均单词数,以及每段的平均文句数.我们已经有了段落,文句,单词的统计数.即`word_count, paragraph_count`和`sentence_count`变量,因此只需要做简单的算术计算:

        puts "#{sentence_count / paragraph_count} sentences per paragraph (average)"
        puts "#{word_count / sentence_count} words per sentence (average)"

### 到目前为止的源代码
我们将源代码整理一下:

        lines = File.readlines("text.txt")
        line_count = lines.size
        text = lines.join
        word_count = text.split.length
        character_count = text.length
        character_count_nospaces = text.gsub(/\s+/,'').length
        paragraph_count = text.split(/\n\n/).length
        sentence_count = text.split(/\.|\?|!/).length

        puts "#{line_count}lines"
        puts "#{character_count}characters"
        puts "#{character_count_nospaces}character excluding spaces"
        puts "#{word_count}words"
        puts "#{paragraph_count}paragraphs"
        puts "#{sentence_count}sentences"
        puts "#{sentence_count /paragraph_count}sentences per paragraph (average)"
        puts "#{word_count /sentence_count}words per sentence (average)"

## 4.3 增加额外功能
分析器程序有几个基本功能,但是没有太大意思!

###### 在开发软件时,永远值得思考的是软件未来扩展和修改的可能性,并提前为这些可能性做准备,许多开发瓶颈正式由于设计太四班,以至于无法应对变化的额情况!

### "有用"字词的百分比
"虚词"(stop words),关于stop words,请访问如下网址: http://en.wikipedia.org/wiki/Stop_words

构建虚词列表:
`stop_words = %w{the a by on for of are with just but and to the my I has some in}`
这行代码产生一个虚词数组,赋值给stop_words变量

###### 注: 数组可以这样定义: `x=['a', 'b', 'c']`.Ruby有快速创建数组的方式:`x = %w{a b c}`

为了演示目的,我们缩小一个短小的,单独的程序,来验证这一概念:

        text = %q{Los Angeles has some of the nicest weather in the country.}
        stop_words = %w{the a by on for of are with just but and to the my I has some}

        words = text.scan(/\w+/)
        key_words = words.select {|word| !stop_words.include?(word)}

        puts key_words.join('')

这段代码,第一步先把一段文本放到程序中,然后是虚词列表.第二步从text数组中得到所有的字词,放到名为words的数组中,然后进入魔术环节:
`key_words = words.select {|word| !stop_word.include?(word)}`
这段代码首先取得字词数组words,并以代码块调用select方法,这个代码块的功能是处理每个字词(和第三章中用过的迭代子相似).select方法是所有数组和散列表都有的方法,它返回该数组或散列表中,匹配代码块中表达式的元素.

本例中,代码块中的代码通过word变量得到每个字词,并询问stop_words数组中是否包含与word变量想通的元素,这是通过`stop_words.include?(word)`实现的.

表达式之前的惊叹号(!),把表达式的值取反(惊叹号把任何Ruby表达式取反).这么做的原因是你不想选择属于stop_words数组中的字词,你想选择的是不属于其中的字词.

为了结束这段代码,再用select方法选择words数组中,不包含在stop_words数组的所有元素,并将选出的元素赋值给`key_words`数组.

最后,用基本的算数方法,计算出非虚词占所有字词的百分比:
`((key_words.length.to_f /words.length.to_f)*100).to_i`

使用`.to_f`方法的原因,是把数组长度看成浮点数,从而更精确的酸楚百分比,当得出真正的百分比(超出100),可以再把它转换成整数.

### 找出"有趣的"句子进行汇总
要开发自己的汇总功能,最简单的方法之一是用特定条件对文句进行扫描
扫描方法之一是查找具备平均长度且包含名词的文句.短句不太可能包含有用的内容,长句又太长不便汇总.能够可靠地找到名词的系统远远超出了本书的范围,因此你可以"取巧",只查找能够指示该句中有用名词出现的字词,例如"is"和"are"









