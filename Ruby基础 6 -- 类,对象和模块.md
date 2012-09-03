# 第六章 类,对象和模块
我们将近距离考察面向对象的细节.我们将考察类和对象为什么有那样的表现行为,面向对象为什么是行之有效的开发工具,怎样实现满足需求的类,以及怎样复写(override)和扩展(extend)Ruby的默认类.最后,将以文本冒险游戏的形式,实现一个基本的"地下城", 来展现各种各样实际生活的概念,以及怎样合并到一组易于维护的,相互链接的类中.

## 6.1 为什么要用面向对象
面向对象不是开发的唯一方式,在之前,有过程(procedural),这种方法在C语言中仍然使用.面向对象强制要求必须以类的形式定义概念和过程,并根据类创建对象,而过程式编程则强调完成任务所需要的步骤,对如何管理数据并不关心

一个公司老板要求开发一段代码,算出不同形状的周长和面积,指定的形状包括正方形和三角形

过程式程序员冲出门去,很快带回来四个不同的函数:
    
    def perimeter_of_square(side_length)
      side_length * 4
    end

    def area_of_square(side_length)
      side_length * side_length
    end

    def perimeter_of_triangle(side1,side2,side3)
      side1 + side2 + 3
    end
    def area_of_triangle(base_width, height)
      base_width * height / 2
    end

###### 注: 请记住,Ruby中不必使用return来从方法中返回值,方法中最后一个表达式的值,将默认作为方法的返回值.

面向对象程序员认识到需求和规格将来可能会变更,因此先定义Shape类,再从该类集成创建出心累,这样会比较有用,也就是说,如果需要向形状中假如额外的通用功能,代码将是现成的:

    class Shape
    end

    class Square <Shape
      def initialize(side_length)
        @side_length = side_length
      end

      def area
        @side_length * @side_length
      end

      def perimeter
        @side_length * 4
      end
    end

    class Triangle <Shape
      def initialize(base_width, height, side1, side2, side3)
        @base_width = base_width
        @height = height
        @side1 = side1
        @side2 = side2
        @side3 = side3
      end

      def area
        @base_width * @height / 2
      end

      def perimeter
        @side1 + @side2 + @side3
      end
    end

###### 注: 目前这段代码看似复杂,本章后边将介绍此处所用的技术,就目前来说,只需看懂类和方法的布局结构即可.

简练的过程式代码让人印象深刻,但是老板想两种都试试.

    puts area_of_triangle(6,6)
    puts perimeter_of_square(5)


    my_square = Square.new(5)
    my_triangle = Triangle.new(6, 6, 7.81, 7.81, 7.81)
    puts my_square.area
    puts my_square.perimeter
    puts my_triangle.area
    puts my_triangle.perimeter

面向对象编程的基本优势在于,尽管在搭建代码时需要更多的结构,但非专家读者很容易理解类和对象的关系,也更容易维护和更新代码,以便适应实际生活的情况.

## 6.2 面向对象基础知识
我们回顾一下前面学到的类和对象的基础知识:
类是对象的蓝图,我们只有一个名为Shape的类,但通过这个类可以创建多个形状实例,所有实例都有Shape类中定义的方法和属性.
对象是类的实例(instance).如果类是Shape,则x=Shape.new创建了新的Shape实例,并将其赋值给变量x.然后就可以称x是个Shape对象,或是个Shape类的对象.

### 局部变量,全局变量,对象变量和类变量
在第二章中,我们创建了一些类,并想起中加入了一些方法,为了回顾,我们来看一下简单的例子:

`6.2.1.rb`

    class Square
      def initialize(side_length)
        @side_length = side_length
      end

      def area
        @side_length * @side_length
      end
    end

    a = Square.new(10)
    b = Square.new(5)
    puts a.area
    puts b.area

initialize接受由`Square.new(10)`传递过来的side_length参数,将10赋值给`@side_length`,`@`十分重要.要理解有些变量名之前有某种符号前缀的原因,需要理解变量有多种类型,例如局部变量,全局变量,对象变量和类变量.

###### 局部变量

    x = 10
    puts x

在Ruby中,这种基本变量称为局部变量(local variable),只能在变量定义的相同的地方使用.如果转而调用对象的方法,或调用自己的独立方法,则变量x不再跟你在一起,它的作用于(scope)被视为局部的,也就是说,它只在局部代码区域内出现:

    def basic_method
      puts x
    end

    x = 10
    basic_method

本例定义x等于10,然后跳转到basic_method的局部方法,如果用irb运行这段代码,将会出错:

    NameError: undefined local variable or method `x' for main:Object
      from (irb):2:in `basic_method'
      from (irb):5
      from /Users/Hivan/.rvm/rubies/ruby-1.9.3-p194/bin/irb:16:in `<main>'

当跳转到basic_method的时候,不在处于创建变量x时所在的作用域,因为x是个局部变量,它只存在于定义的地方.为了避免这个问题,我们要只在直接用到局部变量的地方调用局部变量,这也正是其用途所在.

    def basic_method
      x = 50
      puts x
    end

    x = 10
    basic_method
    puts x

这个例子中,两个局部变量名字相同,但是处在不同的作用域中.说明局部变量只存在于它们原始的作用域,在主代码中,x设为10,然后在方法中把x设为50,但当你回到原始范围时,x仍然是10,basic_method方法中的变量x与方法外的变量x不是一回事.它们是两个不同的变量,分别处在各自的作作用域里.

###### 全局变量
与局部变量直接相对的,Ruby还可以使用全局变量(global variables).它的名字很大程度上按时了,全局变量在程序的任何地方都可以访问,包括在类或对象中.

全局变量很有用,但在Ruby中并不常用.它与面向对象变成的思想无法水乳交融,因为一旦在程序中使用全局变量,代码就可能会依赖于它们.面向对象变成有一个有用的能力,是能把逻辑代码块相互隔离,因此全局变量在此并不受欢迎.不过本书后边将会再次接触到全局变量,因此了解怎样构建全局变量,还是有用的.

通过在变量名之前加上美元符号`$`,即可定义全局变量.如:

    def basic_method
      puts $x
    end

    $x = 10
    basic_method

$x被定义为全局变量,你可以再程序的任何地方调用它.

###### 实例变量
局部变量被限制于局部作用域,全局变量有全局作用域,而对象变量(object variable)的得名,是由于其作用域内置于,关连于当前对象.本节开头的Square类代码演示了这个概念:

    class Square
      def initialize(side_length)
        @side_length = side_length
      end

      def area
        @side_length * @side_length
      end
    end

对象变量有个`@`符号前缀,在Square类中,把提供给类的side_length.赋值给`@Side_length`.而`@side_length`作为对象变量,即可在该对象的任何其他方法中访问.这就是area方法为何能调用@side_length.来计算该对象所代表的正方形的面积:

    a = Square.new(10)
    b = Square.new(5)
    puts a.area
    puts b.area

两个正方形的面积计算结果是不同的,尽管计算面积的代码都是`@side_length * @side_length`.这是因为`@sode_length`是个对象变量,只关联于当前对象或实例.

###### 类变量
最后一种主要的变量类型是类变量(class variable).类变量的作用域处于整个类中,而不是处于该类的特定对象中.与对象变量的单个`@`符号相比,类变量以两个`@`符号作为前缀.

对于存储与某类所有对象都相关的信息,类变量特别有用,例如,可以把目前为止某个类已创建的对象数目保存在类变量中:

    class Square
      def initialize
        if defined?(@@number_of_squares)
          @@number_of_squares += 1
        else
          @@number_of_squares = 1
        end
      end
    end

由于`@@number_of_squares`是个类变量,因此每次创建新对象时它已经存在(除了第一次,这正是检查它是否已经存在的原因,如果不存在,则向其赋予初始值1)

###### 注: 用三元运算符简化代码:

    @@number_of_squares = defined?(@@number_of_squares) ? @@number_of_squares + 1 : 1

### 类方法和对象方法
在Square类中,定义了两个方法:initialize和area.这两个方法都是对象方法,因为它们与对象相关,并直接对对象进行操作.

    class Square
      def initialize(side_length)
        @side_length = side_length
      end

      def area
        @side_length * @side_length
      end
    end

当用s = Square.new(10)语句创建了正方形之后,即可用s.area语句得到s所代表的正方形的面积.area方法是Square类的所有对象都可以使用的方法,因此被视为对象方法.

不过,方法并不只是在对象实例中有用,也可以直接对类本身操作.在上一节中,我们试用过类变量,来保存已经创建多少正方形对象的统计值,因此,以某种方式访问@@number_of_squares类变量,而非通过Square对象来访问,也是很有用处的.

下面是类方法的简单示例:
    
    class Square
      def self.test_method
        puts "Hello from the Square class!"
      end

      def test_method
        puts "Hello from an instance of class Square!"
      end
    end
    Square.test_method
    Square.new.test_method

这个类有两个方法,尽管二者的名字想通,都是test_method,但是第一个是类方法,第二个是实例方法.二者的区别在于,类方法由self.前缀标示,这里self表示当前类,因此`defsele.test_method`定义的方法专用于该类.而没有前缀的方法,则自动称为实例方法.

还可以用另外一种方式来定义类方法,如:

    class Square
      def Square.test_method
        puts "Hello from the Square class!"
      end
    end

用哪种分风格(`ClassName.method_name`或者`self.method_name`)来定义方法,取决于个人喜好.使用self.method_name方式不需要一次次重新声明类名,而用`ClassName.method_name`方式则更贴近以后对该方法的调用.

###### 注: 本书以后会使用ClassName.method_name风格,但是你编写的时候可以用自己喜好的方式

类方法提供了一种机制,可以很好的实现前文所述的"对象计数器"

    class Square
      def initialize
        if defined?(@@number_of_squares)
          @@number_of_squares += 1
        else
          @@number_of_squares = 1
        end
      end

      def Square.count
        @@number_of_squares
      end
    end

    a = Square.new
    puts Square.count
    b = Square.new
    puts Square.count
    c = Square.new
    puts Square.count

在得到统计值时,根本没有引用`a, b, c`而是直接用的Square.count类方法.可以把这一操作看成是"请求类"做与整个类相关的事情.

### 继承
继承的好处在于,底层类拥有上层类的功能,也可以增加他们自由的功能.
Ruby的继承功能同样简单,任何类都可以继承另一个类的功能特性,但是只能从单个类继承.多重类继承有可能造成混乱,各个类之间无穷尽的循环.

我们来看一下继承在代码中的表现形式:

    class ParentClass
      def method1
        puts "Hello from method1 in the parent class"
      end

      def method2
        puts "Hello from method2 in the parent class"
      end
    end

    class ChildClass < ParentClass
      def method2
        puts "Hello from method2 in the child class"
      end
    end

    my_object = ChildClass.new
    my_object.method1

    my_object.method2 


我们来看下边的情况,基本类代表了不同的人:


    class Person
      def initialize(name)
        @name = name
      end

      def name
        return @name
      end
    end

    class Doctor < Person
      def name
        "Dr. " + super
      end
    end


本例中,有个Person(人)类,实现存储和返回人名的基本功能.Doctor(医生)类继承自Person类,并覆写其name方法.再医生的name方法中,返回以"Dr."开头,后跟正常姓名的字符串.这里使用了super,上溯继承链,并调用上一级的同名方法.

###### 注: 减少重复的概念通常称为DRY,即"Don't Repeat Yourself".

### 覆写现有方法
由于Ruby是一种动态语言,因此你可以对它做意一件巧妙的事情,即覆写现有类和方法:

    x = "This is a test"
    puts x.class

对于x所保存的String对象,可以对其调用许多方法:
`puts x.length` `puts x.upcase`

我们来把水搅浑一些,覆写length方法:

    class String
      def length
        20
      end
    end

然后让我们来验证一下这段代码是否真的有用:

    puts "This is a test".length
    puts "a".length
    puts "A really long line of text".length

Ruby的一些程序库和扩展(插件)覆写了核心类的方法,以扩展Ruby的通用功能.但从这个例子可以看出,为什么总是要谨慎小心,时刻注意应用程序中发生了什么.如果我们依赖于length方法来测量字符串长度,而length方法被覆写了,那就会遇到大麻烦!

另外值得一提的是,也可以覆盖自己的方法.事实上,通过再irb中输入这些示例代码,你可能已经做过很多这样的事情了:

    class Dog
      def talk
        puts "Woof!"
      end
    end

    my_dog = Dog.new
    my_dog.talk

    class Dog
      def talk
        puts "How1!"
      end
    end

    my_dog.talk

本例中,我们创建了基本类,包含了一个简单方法,然后重新打开该类.再运行中重新定义了方法.觉果是重新定义的方法立即生效,my_dog对象不再轻吠,而是开始吼叫.

Ruby这种重新打开类并增加或重定义方法的能力,在各种面向对象语言中是相对独特的.尽管你可以用它来实现一些有趣的技巧.但也会导致同一段代码的执行结果不同,这取决于你以来的某个类是否被应用程序修改,如前文对String类的length方法所做的那样.

### 对象方法的反射与发现
反射是指计算机程序再运行和使用中,检视,分析并修改自身的过程.Ruby把反射用到了极致,允许在运行自己的代码时,修改语言自身的大部分功能.

在Ruby中,可以查询几乎任何对象所定义的方法.这是反射的另一部分应用.

    a = "This is a test"
    puts a.methods.join('')

对于对象,methods方法都返回该对象可用方法的数组(当然,除非methods方法被覆写了!).由于Ruby极其面向对象的结构,这些方法的数量通常相当大,比自己定义的方法要多得多!

从以上结果中也可以看到另外一些反射方法.例如,`protected_methods`,`private_methods`和`public_methods`都以不同的封装方式,显示相关方法(详见下一节).

另一个有意思的方法是`instance_variables`,该方法返回对象实例所关联的实例变量(而非类变量)

    class Person
      attr_accessor :name, :age
    end

    p = Person.new
    p.name = "Fred"
    p.age = 20
    puts p.instance_variables.inspect

目前你可能看不出这些反射方法的价值,但是当你逐渐称为Ruby大师时,这些方法就越来越重要.本书不深入讨论元编程(metaprogramming)的艺术和高级反射技术,因为尽管这些主题都很有意思,但除非你达到相当的能力水平,一般不会经常用到,因此不在初学者的范围内.

### 封装
封装是对象的一种能力,它让某些方法和属性变得公共可用(对任何位置的代码),但除此之外的其他方法和属性,只在该类自身或同意累的其他对象中可见.

###### 注: 在更技术的层面上,封装是指对象将其组成数据隐藏在抽象接口之后的能力.此处隐秘包含了这一能力.

封装的基本原理是向类之外尽可能少的暴露方法,这样一来,即使重写类的内部结构,也可以维持少量方法不变,这些方法是该类和对象与系统中其他元素之间的接口.封装有助于把大量功能放在类中,并提供安全性.

    class Person
      def initialize(name)
        set_name(name)
      end

      def name
        @first_name + ' ' + @last_name
      end

      def set_name(name)
        first_name, last_name = name.split(/\s+/)
        set_first_name(first_name)
        set_last_name(last_name)
      end

      def set_first_name(name)
        @first_name = name
      end

      def set_last_name(name)
        @last_name = name
      end
    end

前文中,已经用`attr_accessor :name`实现了上边的功能,并把name赋值给一个对象变量.不幸的是,实际生活的限制常常需要我们采用另外的方法来解决.

在这一情况下,名和姓在每个Person对象中分别储存,放在名为`@first_name`和`@last_name`的对象变量中.当Person对象创建时,姓名被分为两半,通过相应的`set_first_name`和`set_last_name`方法,每一半都赋值给正确的对象变量.为什么要采用这样的实现方法,一个可能的原因是,尽管你想在程序中用全名,数据库设计却可能要求把名和姓放在两个字段中,因此你需要在类代码中进行处理,以便隐藏这一差异.

下面代码看起来一切正常:

    p = Person.new("Fred Bloggs")
    puts p.name

但是:

    p = Person.new("Fred Bloggs")
    p.set_last_name("Smith")
    puts p.name

麻烦了,本想把关于名和姓的需求抽象出来,仅允许读写全名.但`set_first_name`和`set_last_name`仍然是公共方法,因此可以在拥有Person对象的任何代码中直接调用.幸运的是,封闭可以让你解决这一问题:

    class Person
      def initialize(name)
        set_name(name)
      end

      def name
        @first_name + ' ' + @last_name
      end

      private

      def set_name(name)
        first_name, last_name = name.split(/\s+/)
        set_first_name(first_name)
        set_last_name(last_name)
      end

      def set_first_name(name)
        @first_name = name
      end

      def set_last_name(name)
        @last_name = name
      end
    end

    p = Person.new("Fred Bloggs")
    puts p.name

    P = Person.new("Fred Bloggs")
    p.set_last_name("Smith")
    puts p.name

这个Person类与前文第一个版本的唯一区别,是增加了private关键字.private的作用是那个是告诉Ruby,从此往下,本类中声明的任何方法都应保持"私有"状态.这表示只有对象内部的代码可以访问这些私有方法,而类之外的代码则无法访问.例如,下面的代码不再可行:

    p = Person.new("Fred Bloggs")
    p.set_last_name("Smith")

private关键词的反义词是public,我们可以把private放在任何方法之前,然后在其后放上public,把后续方法转置为公共方法:

    class Person
      def anyone_can_access_this
        ...
      end

      private
      def this_is_private
        ...
      end

      public
      def another_public_method
        ...
      end
    end

你还可以把private当成命令使用,向其传递一组符号参数,表示你想把这些符号表示的方法设置为私有的:

    class Person
      def anyone_can_access_this; ...; end
      def this_is_private; ...; end
      def this_is_also_private; ...; end
      def another_public_method; ...; end

      private :this_is_private, :this_is_also_private
    end

###### 注: Ruby支持行尾加分号`;`,并允许把多个代码放在一行中(例如: x=10; x+=1; puts x),本例采用这种方法来节省代码行,但从产品的代码质量的角度来看,这不是一种好的编码风格.

该命令告诉Ruby, `this_is_private`和`this_is_also_private`方法将被放到私有方法中.

Ruby支持封闭的第三种形式,名为protected,它让方法称为私有的,但使用范围是在类的范围内.而非仅在单个对象中.例如:在对象及其方法的范围之外,无法直接调用私有方法,但可以在相同类的任何成员对象的方法中,调用protected类型的方法:

    class Person
      def initialize(age)
        @age = age
      end

      def age
        @age
      end

      def age_difference_with(other_person)
        (self.age - other_person.age).abs
      end

      protected :age
    end

    fred = Person.new(34)
    chris = Person.new(25)
    puts chris.age_difference_with(fred)
    puts chris.age

上面的例子使用了protected类型的方法,因此无法直接调用age方法,除非在Person类对象的任何方法中调用,不过,如果age方法被设为private,则上例将会失败,因为other_person.age是非法调用.这是因为private让方法调用只对特定对象内的方法开放.
请注意,当在最后一行直接调用age方法时,Ruby会抛出一个异常.

### 多态
多态是指编写代码可以同时适用于多种类型和类的对象.例如, +方法适用于数据相加,字符串相连,以及数组合并. +方法具体做什么操作,完全依赖于你要相加的东西是什么类型.

多态有一种常见的演示示例,以下是其Ruby表达形式:

    class Animal
      attr_accessor :name

      def initialize(name)
        @name = name
      end
    end

    class Cat < Animal
      def talk
        "Meaow!"
      end
    end

    class Dog < Animal
      def talk
        "Woof!"
      end
    end

    animals = [Cat.new("Flossie"), Dog.new("Fido"), Cat.new("Tinkle")]
    animals.each do |animal|
      puts animal.talk
    end

本例定义了三个类,Animal类,以及从Animal继承的Dog和Cat类.最后一段代码,创建了一个数组,其中存放不同种类的动物对象:两个Cat对象和一个Dog对象.(其名字都由来自Animal类的通用initialize方法处理)

有些Ruby内置标准累拥有自己的多态方法,例如,可以对许多内置类调用to_s方法,以字符串形式返回对象的内容:

    puts 1000.to_s
    puts [1,2,3].to_s
    puts ({ :name => 'Fred', :age => 10}).to_s

许多情况下,大多数对象都可以依靠to_s方法来返回字符串,这是特别有用的.

### 嵌套类
在Ruby中,可以把类放入其他类之中,这样的类称为嵌套(nested)类,如果某个类依赖于其他类,而这些其他类仅在此处有用,在其他地方无用,在这样的情况下,嵌套类就很有用.如果想把类划分为类组,而不是哥哥独立时,嵌套类也很有用:




























