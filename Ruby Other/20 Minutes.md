# 20分钟体验Ruby
##前言

本文原文[地址](http://www.ruby-lang.org/zh_TW/documentation/quickstart),摘抄在这里纯粹是为了在本地查找方便。顺便也就上传到Git上了。算是一个备份。

### 简介
這是一個簡短的 Ruby 入門體驗，應該可以在二十分鐘內完成。您必須先安裝好 Ruby (如果還沒有，請先[下載](http://www.ruby-lang.org/zh_TW/downloads/)安裝)

### 互动式Ruby
Ruby 附帶了一支程式可以讓你即時看到執行 Ruby 敘述的結果。使用這種互動式環境來學習 Ruby 可說是非常地方便。

打開 IRB (表示 Interactive Ruby)。Ruby 附帶了一支程式可以讓你即時看到執行 Ruby 敘述的結果。使用這種互動式環境來學習 Ruby 可說是非常地方便。

打開 IRB (表示 Interactive Ruby)。

* 如果你使用 Mac OS X 請打開 Terminal 然後輸入 irb 和 enter。
* 如果你使用 Linux，請打開一個 shell 然後輸入 irb 和 enter。
* 如果你使用 Windows，請從開始選單中打開 Ruby 的 fxri 。

`1.9.3-p194 :001 >`

Ok，打開了，現在怎麼辦？

請輸入："Hello World"

    1.9.3-p194 :001 > "Hello World!"
     => "Hello World!" 

### 让Ruby听话
發生什麼事了? 你是不是剛剛寫下了全世界最短的 “Hello World” 程式？也不盡然。第二行只是 IRB 告訴我們最後的敘述執行結果。如果我們需要輸出 “Hello World” 還需要多一行：

    1.9.3-p194 :002 > puts "Hello Wrold!"
    Hello Wrold!
     => nil 

puts 是 Ruby 的基本輸出指令。但是什麼是 => nil 呢? 那是那一行敘述的執行結果。 puts 總是回傳 nil，nil 在 Ruby 中表示一個絕對的空值。

### 你的第一个免费计算器
其實，我們已經可以用 IRB 來當做一個簡單的計算機了。

    1.9.3-p194 :003 > 3+2
     => 5 

三加二，夠簡單了。那怎麼三乘二呢? 你可以試試，一點都不難，你也能夠隨意輸入數字試試。試著按按看 上 它會顯示上一行的 3+2，然後你可以往左移動到 + 更改成 * 乘號。

    1.9.3-p194 :004 > 3*2
     => 6 

接下來，讓我們試試看三的平方：

    1.9.3-p194 :005 > 3**2
     => 9 

在 Ruby 中 ** 是 “次方” 的意思。但是如果你想開根號呢?

    1.9.3-p194 :006 > Math.sqrt(25)
     => 5.0 

等一下，上面那是什麼? 如果你想說：”它是 9 的平方根” 那就對了。讓我們來仔細看一下。首先，什麼是 Math?

### 给程序分类的模组（Modules）
Math 是一個內建的數學模組。Ruby 的模組有兩種作用。這裡介紹的是第一種：把功能相似的方法放在一起。Math 模組還包括了像是 sin() 和 tan()。

接下來介紹點(dot)。這個點是做什麼用的? 這個點是用來告訴接收者(即 Math 模組)一個訊息。什麼訊息呢? 在這個例子，訊息是 sqrt(9)，也就是呼叫 sqrt 方法，並傳遞 9 作為參數。sqrt 正是 “square root” 平方根的意思。

這個方法的回傳值是 3.0。你可能會發現到這不只是 3 而已，還包括小數點。這是因為大多數的情況開根號不會剛好是整數，所以這個函數總是回傳浮點數。

如果我們想記住運算的結果呢? 指定到一個變數即可。

    1.9.3-p194 :007 > a = 3**2
     => 9 
    1.9.3-p194 :008 > b = 4**2
     => 16 
    1.9.3-p194 :009 > Math.sqrt(a+b) 
     => 5.0 

如果您想說很多次 “Hello”，卻不想敲太多按鍵。是時候定義一個方法了!

    1.9.3-p194 :010 > def h 
    1.9.3-p194 :011?>   puts "Hello World!"
    1.9.3-p194 :012?>   end
     => nil 

從 def h 開始定義一個方法。它告訴 Ruby 方法名字是 h。下一行是方法的內容，也就是我們之前看過的 puts "Hello World"。接著最後一行 end 表示方法定義結束。 Ruby 回應 => nil 告訴我們它知悉了這個方法定義。

### 这个简短可以反复执行的方法
現在來試試看執行這個方法數次：

    1.9.3-p194 :013 > h
    Hello World!
     => nil 
    1.9.3-p194 :014 > h
    Hello World!
     => nil 


簡單吧。在 Ruby 中呼叫方法只要輸入方法名字就可以了。如果方法不需要參數，那麼括號可以省略。你也可以加上空括號，但不是必要的。

如果你只想對某個人打招呼呢? 只要重新定義 h 方法接受一個參數即可。

    1.9.3-p194 :015 > def h(name)
    1.9.3-p194 :016?>   puts "Hello #{name}!"
    1.9.3-p194 :017?>   end
     => nil 
    1.9.3-p194 :018 > h("Matz")
    Hello Matz!
     => nil

正如預期... 讓我們仔細看看到底發生什麼事情。

### 字串内嵌
什麼是 #{name} 啊? 這是 Ruby 用來在字串中插入資料的方式。大括號裡面的程式會被執行後變成一個字串，然後將整個大括號符號替換掉。例如，我們來把人名變成大寫：

    1.9.3-p194 :023 > def h(name = "World!")
    1.9.3-p194 :024?>   puts "Hello #{name.capitalize}!"
    1.9.3-p194 :025?>   end
     => nil 
    1.9.3-p194 :026 > h "Chirs"
    Hello Chirs!
     => nil 
    1.9.3-p194 :027 > h
    Hello World!!
     => nil 

這裡還有幾個小訣竅。第一是我們再次省略了方法的括號。如果方法呼叫很簡單，那麼括號建議你可以省略掉。另一個訣竅是參數有預設值 World。意思是說 “如果沒有給 name 參數，那麼就使用預設值 "World"“。

### 发展成Greeter（接待员）
如果我們需要一個接待員，可以記住你的名字，並且禮貌地歡迎你。你會開始需要使用物件(object)了。讓我們來建立 “Greeter” 類別(class)。

    1.9.3p194 :001 > class Greeter
    1.9.3p194 :002?>   def initialize(name = "World!")
    1.9.3p194 :003?>     @name = name 
    1.9.3p194 :004?>     end
    1.9.3p194 :005?>   def say_hi
    1.9.3p194 :006?>     puts "Hi #{@name}!"
    1.9.3p194 :007?>     end
    1.9.3p194 :008?>   def say_bye
    1.9.3p194 :009?>     puts "Bye #{@name}, come back soon."
    1.9.3p194 :010?>     end
    1.9.3p194 :011?>   end
     => nil 

新的關鍵字是 class。這定義了一個新的類別叫做 Greeter，以及屬於這個類別的方法。注意到 @name 這是一個實例變數，可以在類別裡面的方法中存取到。你可以看到在方法 `say_hi` 和 `say_bye` 裡使用了它。

讓我們建立一個 greeter 物件來使用：

    1.9.3p194 :012 > g = Greeter.new("Pat")
     => #<Greeter:0x007fb6aa823288 @name="Pat"> 
    1.9.3p194 :013 > g.say_hi
    Hi Pat!
     => nil 
    1.9.3p194 :014 > g.say_bye
    Bye Pat, come back soon.
     => nil 

一旦建立了 g 物件，它就會記得它的名字是 Pat。嗯，但是我們如何拿到這個名字的值呢?

    1.9.3p194 :015 > g.@name
    SyntaxError: (irb):15: syntax error, unexpected tIVAR
      from /irb:16:in `<main>'

啊，这样不行。

### 揭开物件的面纱
物件中的實例變數(Instance variables)是隱藏的。雖然可以透過檢查(inspect)物件看到這個變數，不過 Ruby 採用了物件導向的思維(譯註: 即封裝)，內部屬性資料基本上是隱藏起來的。

到底 Greeter 物件有哪些方法呢?

    1.9.3p194 :016 > Greeter.instance_methods
     => [:say_hi, :say_bye, :nil?, :===, :=~, :!~, :eql?, :hash, :<=>, :class, :singleton_class, :clone, :dup, :initialize_dup, :initialize_clone, :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :freeze, :frozen?, :to_s, :inspect, :methods, :singleton_methods, :protected_methods, :private_methods, :public_methods, :instance_variables, :instance_variable_get, :instance_variable_set, :instance_variable_defined?, :instance_of?, :kind_of?, :is_a?, :tap, :send, :public_send, :respond_to?, :respond_to_missing?, :extend, :display, :method, :public_method, :define_singleton_method, :object_id, :to_enum, :enum_for, :==, :equal?, :!, :!=, :instance_eval, :instance_exec, :__send__, :__id__]

哇。有這麼多。我們不是只定義了兩個方法，怎麼回事呢? 這裡列出的是所有 Greeter 物件的方法，因此也包括了它所繼承的類別的方法。如果我們只需要 Greeter 自己的方法，可以傳入一個 false 參數，表示我們不希望包括父類別的方法。

    1.9.3p194 :017 > Greeter.instance_methods(false)
     => [:say_hi, :say_bye] 

看起來好多了。讓我們看看 greeter 物件對哪些方法有反應?

    1.9.3p194 :018 > g.respond_to?("name")
     => false 
    1.9.3p194 :019 > g.respond_to?("say_hi")
     => true 
    1.9.3p194 :020 > g.respond_to?("to_s")
     => true 

它知道 `say_hi` 和 `to_s(意思是轉換成字串，這是每個物件都有的方法)`，但是不知道 name 這個方法。

### 变更类别，永不嫌晚
那麼要怎麼能夠讀取或修改名字呢? Ruby 提供了一個簡單的方式來讓你存取物件的變數：

    1.9.3p194 :021 > class Greeter
    1.9.3p194 :022?>   attr_accessor :name
    1.9.3p194 :023?>   end
     => nil 

在 Ruby 裡你可以再度打開一個類別然後修改它。這個改變會對之後產生的物件，甚至是已經產生的物件產生即時效果。所以，我們來建立一個新的物件試試看 @name 屬性。

    1.9.3p194 :024 > g = Greeter.new("Andy")
     => #<Greeter:0x007fb6ac061f20 @name="Andy"> 
    1.9.3p194 :025 > g.respond_to?("name")
     => true 
    1.9.3p194 :026 > g.respond_to?("name=")
     => true 
    1.9.3p194 :027 > g.say_hi
    Hi Andy!
     => nil 
    1.9.3p194 :028 > g.name = "Betty"
     => "Betty" 
    1.9.3p194 :029 > g
     => #<Greeter:0x007fb6ac061f20 @name="Betty"> 
    1.9.3p194 :030 > g.name
     => "Betty" 
    1.9.3p194 :031 > g.say_hi
    Hi Betty!
     => nil 

attr_accessor 會定義兩個新的方法，name 用來取值，而 name= 用來給值。

### 可以欢迎任何东西的MegaGreeter！
這個 greeter 玩膩了，它一次只能處理一個人。要如何能夠有 MegaGreeter 可以不只歡迎這個世界，還可以歡迎不同人，甚至是一群人呢?

接著讓我們開一個新檔案來撰寫 Ruby 程式吧，互動式的 IRB 不適合撰寫較長的程式。

要離開 IRB 請輸入 “quit” 或 “exit” 或按下 Control-D。

        #!/Usr/hivan/bin/env ruby
        class MegaGreeter
          attr_accessor :names

          #初始化这个物件
          def initialize(names = "world!")
            @names = names
          end

          #向每个人说hi
          def say_hi
            if @names.nil?
              puts "..."
            elsif @names.respond_to?("each")

              # @names 是可以迭代的阵列容器
              @names.each do |name|
                puts "Hello #{name}!"
              end
            else
              puts "Hello #{@names}!"
            end
          end

          #向每个人说Bye
          def say_bye
            if @names.nil?
              puts "..."
            elsif @names.respond_to?("join")
              #用逗号将阵列中的元素串接程一个字串
              puts "Goodbye #{@names.join(", ")}, Come back soon!"
            else
              puts "Goodbye #{@names}. Come back soon!"
            end
          end

        end

        if __FILE__ == $0
          mg = MegaGreeter.new
          mg.say_hi
          mg.say_bye

          #变更成"Zeke"
          mg.names = "Zeke"
          mg.say_hi
          mg.say_bye

          #变更成一个名字的阵列
          mg.names = ["Albert", "Brenda", "Charles", "Dave", "Englebert"]
          mg.say_hi
          mg.say_bye

          #变更成nil
          mg.names = nil
          mg.say_hi
          mg.say_bye
        end

我将这个代码储存成了“20Minutes.rb”，输入`ruby 20Minutes.rb`来执行它，输出结果为：

        Hello world!!
        Goodbye world!. Come back soon!
        Hello Zeke!
        Goodbye Zeke. Come back soon!
        Hello Albert!
        Hello Brenda!
        Hello Charles!
        Hello Dave!
        Hello Englebert!
        Goodbye Albert, Brenda, Charles, Dave, Englebert, Come back soon!
        ...
        ...

我們來深入看看這個新程式。注意到由井號(#)開頭的第一行，在 Ruby 裡，任何在井號之後的內容都是註解，會被直譯器忽略。除了檔案的第一行是個例外，在 Unix-like 作業系統下這告訴 Shell 如何執行這個檔案。其餘的註解則用來說明程式。

我们的say_hi方法也改变了：

      #向每个人说hi
      def say_hi
        if @names.nil?
          puts "..."
        elsif @names.respond_to?("each")

          # @names 是可以迭代的阵列容器
          @names.each do |name|
            puts "Hello #{name}!"
          end
        else
          puts "Hello #{@names}!"
        end
      end

它現在會根據 @names 參數的不同而有不同的行為。如果是 nil，它會輸出三個點。沒必要對空氣打招呼，對吧?

### 循環、迴圈，迭代 (Iteration)
如果 @names 物件可以回應 each 方法，那表示你可以迭代它，好讓我們輪流對其中的元素打招呼。如果 @names 什麼都不是，我們透過字串內嵌把它轉化成字串，用預設的打招呼方式。

下面來看一看這是怎麼迭代的：

    @names.each do |name|
      puts "Hello #{name}!"
    end

each 是一個可以接受程式區塊(a block of code)的方法，它會對 @names 裡的每個元素執行這個程式區塊，也就是從 do 到 end 的程式碼。一個程式區塊就像是一個匿名方法，也像是 lambda。而在直線 | 符號之間的是這個程式區塊的參數。

具體來說就是，程式區塊裡的 name 參數會被輪流指定為容器裡的每個元素，然後執行 puts "Hello #{name}!" 。

大多數的程式語言會用 for 迴圈來做這件事情，例如在 C 裡面：

        for (i=0; i<number_of_elements; i++)
        {
          do_something_with(element[i]);
        }

這樣也行，只是沒這麼漂亮。你需要一個用過即丟的 i 變數、需要計算容器的長度、檢查離開迴圈的條件。而 Ruby 的方式漂亮多了，所有的工作都被包裝在 each 方法裡。在 each 內部會去輪流呼叫 yield "Albert"、yield "Brenda"、yield "Charles" 等等。(譯註：yield 的意思是”轉交”，也就是跳去執行程式區塊)

### 让Ruby发光发亮的程序区块（Blocks）
程式區塊真正厲害的地方是，它可以處理比迭代更複雜的任務。你可以用來設定(setup)、卸載(teardown)和錯誤處理，這些都可以隱藏起來讓方法使用者無需擔心。

    # 向每個人說 bye
    def say_bye
      if @names.nil?
        puts "..."
      elsif @names.respond_to?("join")
        # 用逗號將陣列中的元素串接成一個字串
        puts "Goodbye #{@names.join(", ")}.  Come back soon!"
      else
        puts "Goodbye #{@names}.  Come back soon!"
      end
    end

say_bye 方法沒有用到 each，而是檢查 @names@ 是不是可以回應 join 方法。如果可以，就呼叫它。不然它就把它當做字串輸出。這個方法並不在乎變數真正的 型別(type)，而只關心變數是不是可以回應支援某個方法，這種風格叫做 “鴨子型別(Duck Typing)”，意義就是 “如果它走起來像鴨子，叫起來也像鴨子，那就當它是鴨子”。這種思維的好處是它不會被變數的型別所限制。如果有人寫了新的容器類別，並且也實作了 join 這個方法，那麼我們就可以在這裡使用它。

### 让脚本跑起来
這就是 MegaGreeter 類別了。剩下的部份是就是使用這個類別而已。唯一要注意的技巧是以下這行：
`if __FILE__ == $0`
`__FILE__` 是一個預先定義好的變數，內容是目前這個檔案的名稱。而 $0 是執行這隻程式的執行檔名稱。這個檢查是說 “如果這個檔案就是執行程式的檔案....”。這可以允許將這個檔案當做方法庫使用。也就是說，這個檔案如果當做方法庫使用時，不會執行這段程式。如果當做執行檔執行，就會執行這段程式。

### 就這樣啦

這就是二十分鐘的 Ruby 入門體驗了。還有許多值得探索的地方，例如不同的控制結構、如何使用程式區塊及 yield、模組(modules)的第二個用途 mixin 等等。希望這份體驗教學讓你有興趣繼續學習。

如果你希望進一步了解，歡迎前往ruby-lang.org的[文件](http://www.ruby-lang.org/zh_TW/documentation/)，那裡提供了一些免費的線上文件和導覽。

或是你希望找本書，請參考看看 書籍清單 ([外部連結](http://www.ruby-doc.org/bookstore))，或是你本地的書店。






