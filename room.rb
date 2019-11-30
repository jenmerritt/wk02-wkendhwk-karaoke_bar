# require('pry')
# binding.pry

class Room

  attr_reader :name, :capacity

  def initialize(name, capacity)
    @name = name
    @capacity = capacity
    @guests = []
    @songs = []
  end

  def guest_list_length()
    return @guests.length()
  end

  def song_list_length()
    return @songs.length()
  end

end
