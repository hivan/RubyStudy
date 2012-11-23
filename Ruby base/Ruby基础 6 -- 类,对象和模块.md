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

    class Drawing
      class Line
      end

      class Circle
      end
    end

嵌套类与普通类的定义方法完全相同,但是用法不同.

在Drawing类中,可以直接访问Line和Circle类,但在Drawing类之外,则只能以Drawing::Line和Drawing::Circle的形式访问Line和Circle:

    class Drawing
      def Drawing.give_me_a_circle
        Circle.new
      end

      class Line
      end

      class Circle
        def what_am_i
          "This is a circle"
        end
      end
    end

    a = Drawing.give_me_a_circle
    puts a.what_am_i
    a = Drawing::Circle.new
    puts a.what_am_i
    a = Circle.new
    puts a.what_am_i

`a = Drawing.give_me_a_circle`调用了`give_me_a_circle`类方法,返回`Drawing::Circle`的新实例,下一步, `a = Drawing::Circle.new`直接得到`Drawing::Circle`的新实例,而`a = Circle.new`并未成功,因为Circle类不存在.这是由于Circle是Drawing之下的嵌套类,只能以`Drawing::Circle`的形式为人所知.

### 常量的作用域
常量的值在程序范围内永不变更,例如:

    def circumference_of_circle(radius)
      2 * Pi * radius
    end

    Pi = 3.141592
    puts circumference_of_circle(10)

在这种意义下,常量似乎与全局变量很像,但却不是.常量定义在当前类的作用域内,除非被覆写,否则所有子类均可访问:

    Pi = 3.141592
    class OtherPlanet
      Pi = 4.5

      def OtherPlanet.circumference_of_circle(radius)
        radius * 2 * Pi
      end
    end

    puts OtherPlanet.circumference_of_circle(10)
    puts OtherPlanet::Pi
    puts Pi

<h4 style="color:red">注: 从这里向下,不会写的那么详细了,因为时间上不够用!请见谅.</h4>

## 模块, 命名空间和掺入
模块提供一种结构,用来把Ruby类,方法和常量收集到单独命名和定义的单元中.这样可以避免与现有类,方法和常量发生冲突,而且还可以把模块的功能增加(掺入)到自己的类中.

### 命名空间
Ruby中经常使用的一种功能就是把其他文件中代码包含到当前程序的能力.当包含其他文件时,很快会碰到冲突:

    def random
      rand(1000000)
    end

    puts random

random方法返回0~999,999之间的一个随机数字.该方法可能位于某个很容易遗忘的外部文件中,这样以来,如果用require包含的另一个文件中实现了如下所示的同名方法,就会发生问题:

    def random
      (rand(26) + 65).chr
    end

这个random方法返回随机的大写字符

现在你有两个方法都叫random.

    require 'number_stuff'
    require 'letter_stuff'

    puts random

究竟是哪个版本的random方法被调用?

###### 注：require是Ruby语句，用来载入其他文件包含的代码。

这种情况被称为命名冲突（name conflict),它甚至可能发生在比上面代码所示的简单示例更可怕的情况中。例如，类名可能同样发生冲突，你会无意中把两个同名类混杂在一起。如果名维Song的类定义在某个外部文件中，然后在另一个外部文件中也定义同名的类，那么在你的程序中，Song类将会是二者乱七八糟的混合体。

模块有助于解决这些冲突，它提供了命名空间，柯伊包含任何数量的类，方法和常量，并允许直接引用它们：

    module NumberStuff
      def NumberStuff.random
        rand(10000000)
      end
    end

    module LetterStuff
      def LetterStuff.random
        (rand(26) + 65).chr
      end
    end

    puts NumberStuff.random
    puts LetterStuff.random

###### 注： 输出结果会有所不同

模块无法定义实例，因为它们不是真正的类，而且它们不能丛任何事物继承。模块只提供了把方法，类和常量组织到单独命名空间的途径。

    module ToolBox
      class Ruler
        attr_accessor :length
      end
    end

    module Country
      class Ruler
        attr_accessor :name
      end
    end

    a = ToolBox::Ruler.new
    a.length = 50
    b = Country::Ruler.new
    b.name = "Ghengis Khan from Moskau"

    puts a.length
    puts b.name

这里并没有发生两个Ruler（尺子）类争夺控制权，或最终形成一个变异的Ruler类，例如，即包含name属性也包含length属性的变异Ruler类（有多少计量用的尺子有名字？），而是把两个Ruler类分别放在ToolBox和Country命名空间中。

### 掺入
在前文中，我们研究了继承：它是面向对象的一个功能特性，允许类（及其实例对象）从其他类中继承方法。你会发现，Ruby不支持多重继承（multiple inheritance），即同时从多个类中继承的能力。Ruby的继承功能只允许你创建简单的类树，避免了多重继承系统天生的混乱。

不过，在某些情况下，从迥然不同的类中共享功能，也是件很有用的事。从这种意义上，模块象某种“超级”类，可被包含到其他类中，用模块提供的功能来扩展其他类：

    module UsefulFeatures
      def class_name
        self.class.to_s
      end
    end

    class Person
      include UsefulFeatures
    end

    x = Person.new
    puts x.class_name

在这段代码中，UsefulFeatures模块看起来几乎就是个类，而且确实几乎就是。不过，模块本身是组织工具，而不是类，class_name方法位于模块中，因此随即被包含到Person类中。

    module AnotherModule
      def do_stuff
        puts "This is a test"
      end
    end

    include AnotherModule
    do_stuff

Ruby自带了几个标准模块，例如｀Kernel'模块包含所有“标准”命令，在Ruby中使用时无须指定对象或类，例如load，require，exit，puts和eval。

这里介绍其中的两个模块，分别是Enumerable和Comparable。

##### Enumerable模块
迭代操作：
`[1, 2, 3, 4, 5].each {|number| puts number}`

    my_array = %w{this is a test of the longest word check}
    longest_word = ''
    my_array.each do |word|
      longest_word = word if longest_word.length < word.length
    end
    puts longest_word

在本例中，循环遍历`my_array`， 如果当前已知的最长单词比word的长度更短，则将其赋值给`longest_word`，当循环结束时，最长的单词存放在`longest_word`中。
相同的代码可以调整一下，来找出一组数字中最大（或最小）的数字：

    my_array = %w{10 56 92 3 49 588 18}
    # highest_number = 0
    # my_array.each do |number|
    #   number = number.to_i
    #   highest_number = number if number > highest_number
    # end
    # puts highest_number

    small_number = my_array.length
    my_array.each do |number|
      number = number.to_i
      small_number = number if number < small_number
    end
    puts small_number

不过，Array类预先包含了`Enumerable`模块的方法，这个模块中提供了大于20个有用的统计和迭代相关的方法，包括`collect，detect，find，find_all, include?, max, min, select, sort和to_a`。所有这些方法豆使用了Array类的each方法来完成其工作，如果你的类要实现each方法，则可以包含Enumerable模块，即可在你自己的类中，免费得到所有这些方法。

###### 注：Enumerable模块提供的主要方法以后会天假附录B.届时会提供相应连接。

    [1, 2, 3, 4].collect {|i| i.to_s + "x"}

    [1, 2, 3, 4].detect {|i| i.between?(2,3)}

    [1, 2, 3, 4].select {|i| i.between?(2,3)}

    [4, 1, 3, 2].sort

    [1, 2, 3, 4].max

    [1, 2, 3, 4].min

你也可以创建自己的类，实现each方法，并“免费”得到这些方法：

    class AllVowels
      @@vowels = %w{a e i o u}
      def each
        @@vowels.each {|v| yield v}
      end
    end

    x = AllVowels.new
    x.each {|v| puts v}

实际上，这个类不需要提供多个对象，因为它只对元音字母进行枚举。不过，为了保持示例的简单性，这是个理想的例子。

我们让Enumerable模块也参与其中：

    class AllVowels
      include Enumerable

      @@vowels = %w{a e i o u}
      def each
        @@vowels.each {|v| yield v}
      end
    end

现在我们再次试着使用Enumerable模块提供的方法。首先我们得到AllVowels对象：

    x = AllVowels.new
    x.collect {|i| i + "x"}
    x.detect {|i| i > "j"}
    x.select {|i| i > "j"}
    x.sort
    x.max
    x.min

##### Comparable模块
Comparable模块提供了很多方法，为其他类提供了比较运算符，例如<, <=, ==, >=和>，还有between？方法，当某值在指定的两个参数之间（包含参数值本身）时，则返回true（例如4.between?(3,10) == true)。

为了提供这些方法，对于包含Comparable模块的类，Comparable模块对该类使用了<=>运算符。如果对象的值小于指定参数，则返回－1；如果等于，则返回0；如果大于，则返回1.

    class Song
      include Comparable

      attr_accessor :length
      def <=>(other)
        @length <=> other.length
      end

      def initialize(song_name, length)
        @song_name = song_name
        @length = length
      end

    end

    a = Song.new('Rock around the clock', 143)
    b = Song.new('Bohemian Rhapsody', 544)
    c = Song.new('Minute Waltz', 60)

    a < b
    b >= c
    c > a
    a.between?(b,c)

##### 通过命名空间和类进行掺入

    module ToolBox
      class Ruler
        attr_accessor :length
      end
    end

    module Country
      class Ruler
        attr_accessor :name
      end
    end

    a = ToolBox::Ruler.new
    a.length = 50
    b = Country::Ruler.new
    b.name = "Ghengis Khan of Moskau"

现在临时假设Ruler就是Country::Ruler，那么要访问任何其他Ruler类就得直接引用，此时该怎么办？ include命令可以实现这一效果。

    include Country
    c = Ruler.new
    c.name = "King Henry VIII"

Country模块的内容被带入当前访问作用域，还可以把Ruler当成本地类来使用。如果想使用ToolBox中呃Ruler类，仍可以直接用ToolBox::Ruler来引用。

## 6.4 用对象构建“地下城”文本冒险游戏
### 地下城的概念
进行类的开发之前，需要明白要对什么建模。地下城游戏一点也不复杂，但至少要处理以下概念：
* 地下城：需要一个一般类，用来封装地下城游戏的完整概念。
* 玩家：玩家提供你与地下城之间的连接，地下城游戏的所有体验都由玩家而来。玩家可以再地下城的各个房间之间来回移动。
* 房间：地下城呃房间供玩家再其间移动。各房间之间以多种形式连接，并由相应描述。

完整的冒险游戏还应该由物品，敌人，其他角色，路点，咒语，以及各种谜题和结果的出发事件。

### 创建初始类
我们要开发的第一个概念，是地下城和游戏本身。再这一框架内，在引入其他概念，例如玩家和房间：

    # 使用嵌套类，初始代码布局如下：
    class Dungeon
      attr_accessor :player
      def initialize(player_name)
        @palyer = Player.new(palyer_name)
        @rooms = []
      end

      class Player
        attr_accessor :name, :location
        def initialize(player_name)
          @name = player_name
        end
      end

      class Room
        attr_accessor :reference, :name, :description, :connections

        def initialize(reference, name, description, connections)
          @reference = reference
          @name = name
          @description = description
          @connections = connections
        end
      end
    end

Dungeon类封装了所有其他类，这一核心概念把所有东西都绑定再一起，因为在此情况下，如果没有Dungeon的包裹，Player和Room类就没有任何用处。这并不是说，依赖于其他类de类必须嵌套，只是再此情况下，用这种方式来组织类是有道理的。

现在，地下城游戏有几个实例变量，分别保存玩家和房间的清单（@rooms = []创建了空Array，它与@rooms = Array.new同义）。

    my_dungeon = Dungeon.new("Fred Bloggs")
    puts my_dungeon.player.name

通过穿越地下城对象，可以直接访问玩家的功能。因为@player包含player对象，而且通过`attr_accessor` `:player`, `@player`已经被设置为公共可访问的，因此你得到了完全的访问权限。

### Structs：快捷简单的数据类
目前代码比较重复，Room和Player类只是作为基本的数据占位区，没有逻辑和功能。再Ruby中又一种更简单的方法，用一行名为Struce的类代码就可以创建这类专用于保存数据的特殊类。
结构是一种特殊类，其唯一职能就是拥有属性，保存数据：

    Person = Struct.new(:name, :gender, :age)
    fred = Person.new("Fred", "male", 50)
    chris = Person.new("Chris", "male", 25)
    puts fred.age + chris.age

第一行代码创建了名为`Person`的新类，第二行代码创建了Person类的新实例，并在运行过程中设置属性。第一行代码等同于一下这段冗长的内容：

    class Person
      attr_accessor :name, :gender, :age

      def initialize(name, gender, age)
        @name = name
        @gender = gender
        @age = age
      end
    

###### 注：其实这段代码不完全等同于struce代码，因为再初始化Struct类时，参数是可选的，而上述Person类代码需要提供三个参数（name，gender和age）。

这段代码创建Person类的方式比较冗长。如果只需要存储数据，那么struct技术更快捷更易读，当然，如果最终要向这个类增加更多功能，以冗长方式创建类就是值得的。不过，可以在开始时使用struct方式，然后在需要的时候重写完整的类。

    class Dungeon
      attr_accessor :player

      def initialize(player_name)
        @player = Player.new(player_name)
        @rooms = []
      end

      Player = Struct.new(:name, :location)
      Room = Struct.new(:reference, :name, :description, :connections)
    end

这样简短了，由于在创建Struct类的实例时，参数是可选的，因此仍然可以用Player.new(player_name)的方式，location属性只被设为nil。如果需要向Player或Room中增加方法，可以将其重写为普通类，并用`attr_accessor`把属性加回来。

> <h4 style="color:red; solid:bold">属性读写权限设置器(attr_accessor)</h4>

> 和第二章一样，在本章的代码中，类中使用了attr_accessor来为对象提供属性。用attr_accessor可以这样做：

>     class Person
        attr_accessor :name :age
      end
      x = Person.new
      x.name = "Fred"
      x.age = 10
      puts x.name, x.age

> 但是实际上，attr_accessor并没有做什么魔术处理，它只是帮你写了一些代码，以下这段代码等同于上面Person类中的单行代码`attr_accessor :name, :age`

>     class Person
        def name
          @name
        end
        def name = (name)
          @name = name
        end
        def age
          @age
        end
        def age = (age)
          @age = age
        end
      end

> 这段代码定义了name和age方法，用来返回当前对象变量的相应属性，因此可以调用x.name和x.age（和前面的代码一样）。这段代码还定义了两个“写属性方法”，为@name和@age对象变量赋值。

> 如果你注意写属性方法的名字，会发现它们与读属性方法的名字相同，只是加了“＝”后缀，哲表示可以用诸如`x.name = "Fred"` 和 `x.age  = 10`这样的代码。在Ruby中，赋值正是对常规方法的调用！事实上，`x.name = "Fred"`只是x.name = ("Fred")的缩写。

### 创建房间
我来向Dungeon类增加方法：

    class Dungeon
      def add_room(reference, name, description, connections)
        @rooms << Room.new(reference, name, description, connections)
      end
    end

我们想做的是向地下城增加房间，因此向地下城对象增加方法是最合理的。这样一来，可以用下面的方法来创建房间（当然，是在my_dungeon已经定义好的前提下）：

    my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", {:west => :smallcave})
    my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", {:east => :largecave})

add_room方法接受reference（引用），name（名字），description（说明），connections（连接）参数，用它们来创建新的Room对象，然后把这个对象放到@rooms数组的末尾。

connections 参数接受一个散列表，其中内容是某个特定房间与其他房间的连接。例如，{:west => :smallcave}把两个符号(:west和:smallcave)连接到一起。地下城代码通过该连接把房间连接起来，根据{:west => :smallcave, :south => :another_room} 这样的连接散列表，将创建两个连接（一个指向西方，一个指向南方）。

### 让地下城运转起来
现在已经把所有房间载入到基本的地下城中了（并且只要愿意，可以用add_room方法增加更多的房间），但还没有办法启动地下城游戏本身。

第一步是在Dungeon中创建一个方法，把用户放到地下城中，并给出初始位置的说明，从而“启动”整个游戏：

    class Dungeon
      def start(location)
        @player.location = location
        show_current_description
      end

      def show_current_description
        puts find_room_in_dungeon(@player.location).full_description
      end

      def find_room_in_dungeon(reference)
        @rooms.detect{|room| room.reference == reference }
      end

      class Room
        def full_description
          @name + "\n \nYou are in " + @description
        end
      end
    end

下面列出到目前为止的完整代码，以及把Room变为常规类的变化内容，和用于辅助地下城漫游的一些额外方法：
`代码详见6.4.all.rb,不过代码似乎有点问题，总是出现模块错误。已经按照书本完全对照，暂时找不出错误。以后对Ruby理解的更透彻了再回头来找这里的错误`



