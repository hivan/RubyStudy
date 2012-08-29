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

