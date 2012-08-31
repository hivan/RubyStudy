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

用哪种分风格(ClassName.method_name或者self.method_name)来定义方法,取决于个人喜好.使用self.method_name方式不需要一次次重新声明类名,而用`ClassName.method_name`方式则更贴近以后对该方法的调用.

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


本例中,有个Person(人)类,实现存储和返回人名的基本功能.Doctor(医生)类继承自Person类,并覆写其name方法.再医生的name方法中,返回以"Dr."开头,后跟正常姓名的字符串.这里使用了super















