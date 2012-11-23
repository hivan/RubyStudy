class Human
  def identify
    puts "I'm a person."
  end
  def train_toll(age)
    if age < 12
      puts "Reduced fare.";
    else
      puts "Normal fare.";
    end
  end
end

Human.new.identify

class Student1 < Human
  def identify
    puts "I'm a student."
  end
end

Student1.new.identify

class Student2 < Human
  def identify
    super
    puts "I'm a student too."
  end
end

Student2.new.identify

class Dishonest < Human
  def train_toll(age)
    super(11) #我们想要更便宜的价格.
  end
end

Dishonest.new.train_toll(25)

class Honest < Human
  def train_toll(age)
    super(age) #传进我们提供的参数
  end
end

Honest.new.train_toll(25)