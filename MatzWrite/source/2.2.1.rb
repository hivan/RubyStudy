module Stats
  class Dataset
    def initialize(filename)
      IO.foreach(filename) do |line|
        if line[0, 1] == "#"
          next
        end
      end
    end
  end
end