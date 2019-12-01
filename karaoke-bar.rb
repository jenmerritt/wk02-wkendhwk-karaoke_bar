require('pry')
# binding.pry

class KaraokeBar

  attr_reader :name, :till, :entry_fee

  def initialize(name, till, rooms, songs = [], entry_fee)
    @name = name
    @till = till
    @rooms = rooms
    @songs = songs
    @entry_fee = entry_fee
  end

# getter methods for song list

  def number_of_songs()
    return @songs.length()
  end

  def return_song_list()
    return @songs
  end

# getter methods for room list

  def number_of_rooms()
    return @rooms.length()
  end

  def return_room_list()
    return @rooms
  end

# method to add song to karaoke bar song list

  def add_song_to_karaoke_bar_list(song)
    @songs << song
  end

# methods to check guests into and out of a specific room created in the room class

  def check_guest_in(room, guest_to_check_in)
    room.room_guest_list << guest_to_check_in
  end

  # def check_guest_in(room, guest_to_check_in)
  #   for guest in room.room_guest_list
  #     if guest_to_check_in != guest
  #       room.room_guest_list << guest_to_check_in
  #     end
  #   end
  #   return "#{guest_to_check_in.name} is already in this room!"
  # end

  def check_guest_out(room, guest_to_check_out)
    for guest in room.room_guest_list
      if guest_to_check_out == guest
        room.room_guest_list.delete(guest)
      end
    end
    return "#{guest_to_check_out.name} is not in this room!"
  end

# methods to add/remove songs from a song queue in a specific room created in the room class

  def add_song_to_queue(room, song)
    room.room_song_list << song
  end

  def remove_song_from_queue(room, song)
    room.room_song_list.delete(song)
  end

# possibly redundant - differnet ways of managing finding a song and adding to queue:
  # def find_song_by_title(song_list, song_title)
  #   for song in song_list
  #     if song.title == song_title
  #       return song
  #     end
  #   end
  #   return "Sorry, we don't have #{song_title}!"
  # end

  # def add_song_to_queue_by_title(song_list, room, song_title)
  #   for song in song_list
  #     if song.title == song_title
  #       add_song_to_queue(room, song)
  #     end
  #   end
  #     return "Sorry, we don't have #{song_title}!"
  # end


# methods to add/remove songs by title / artist / decade

  # def find_song_by_title(song_list, song_title)
  #   songs_found = []
  #   for song in song_list
  #     if song.title == song_title
  #       songs_found.push(song)
  #     end
  #   end
  #   return songs_found
  # end

  def find_song_by_title(song_list, song_title)
    songs_found_by_title = song_list.find_all { |song| song_title == song.title }
    return songs_found_by_title
  end

  def find_song_by_artist(song_list, artist)
    songs_found_by_artist = song_list.find_all { |song| artist == song.artist }
    return songs_found_by_artist
  end

  def find_song_by_decade(song_list, decade)
    songs_found_by_decade = song_list.find_all { |song| decade == song.decade }
    return songs_found_by_decade
  end

  # def find_song_by_artist(song_list, artist)
  #   for song in song_list
  #     if song.artist == artist
  #       return song
  #     end
  #   end
  #   return nil
  # end

  # def add_song_to_queue_by_title(song_list, room, song_title)
  #   songs_found = find_song_by_title(song_list, song_title)
  #   if songs_found != []
  #     for song in songs_found
  #       add_song_to_queue(room, song)
  #     end
  #   end
  #     return "Sorry, we don't have #{song_title}!"
  # end
  #
  # def add_song_to_queue_by_artist(song_list, room, artist)
  #             binding.pry
  #   song = find_song_by_artist(song_list, artist)
  #   if song != nil
  #     then add_song_to_queue(room, song)
  #   end
  #     return "Sorry, we don't have any songs by #{artist}!"
  # end



end
