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











