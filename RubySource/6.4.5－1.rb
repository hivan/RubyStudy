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