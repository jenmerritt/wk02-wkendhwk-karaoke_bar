require('pry')
# binding.pry

class Room

  attr_reader :name, :capacity

  def initialize(name, capacity, guests, songs)
    @name = name
    @capacity = capacity
    @guests = []
    @songs = []
  end

  def number_of_guests_in_room()
    return @guests.length()
  end

  def room_guest_list()
    return @guests
  end

  def number_of_songs_in_room()
    return @songs.length()
  end

  def room_song_queue()
    return @songs
  end
# room_song_list


end
