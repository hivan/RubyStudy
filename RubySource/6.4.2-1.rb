# 使用嵌套类，初始代码布局如下：
class Dungeon
  attr_accessor :player
  def initialize(player_name)
    @player = Player.new(player_name)
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

my_dungeon = Dungeon.new("Fred Bloggs")
puts my_dungeon.player.name