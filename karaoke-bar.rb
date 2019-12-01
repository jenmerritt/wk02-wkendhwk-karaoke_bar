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
    room.room_song_queue << song
  end

  def remove_song_from_queue(room, song)
    room.room_song_queue.delete(song)
  end

###### refactored - different ways of managing finding a song and adding to queue:

                      # def return_songs_by_title(song_list, song_title)
                      #   for song in song_list
                      #     if song.title == song_title
                      #       return song
                      #     end
                      #   end
                      #   return "Sorry, we don't have #{song_title}!"
                      # end
                      #
                      # def add_song_to_queue_by_title(song_list, room, song_title)
                      #   for song in song_list
                      #     if song.title == song_title
                      #       add_song_to_queue(room, song)
                      #     end
                      #   end
                      #     return "Sorry, we don't have #{song_title}!"
                      # end

#### refactored
                      # def return_songs_by_title(song_list, song_title)
                      #   songs_found = []
                      #   for song in song_list
                      #     if song.title == song_title
                      #       songs_found.push(song)
                      #     end
                      #   end
                      #   return songs_found
                      # end
###########

# methods to find songs by title / artist / decade

  def find_a_song(song_list, song)
    song_found = song_list.find_all { |song_in_list| song_in_list == song }
  end

  def return_songs_by_title(song_list, song_title)
    songs_found_by_title = song_list.find_all { |song| song_title == song.title }
    return songs_found_by_title
  end

  def return_songs_by_artist(song_list, artist)
    songs_found_by_artist = song_list.find_all { |song| artist == song.artist }
    return songs_found_by_artist
  end

  def return_songs_by_decade(song_list, decade)
    songs_found_by_decade = song_list.find_all { |song| decade == song.decade }
    return songs_found_by_decade
  end

  def add_song_to_queue_by_title(song_list, room, title, song)
    songs_with_title = return_songs_by_title(song_list, title)
    if songs_with_title != []
      song_to_queue = song_list.find { |song_in_list| song_in_list == song }
      add_song_to_queue(room, song_to_queue)
    end
    return "Sorry, we don't have #{title}!"
  end

  def add_song_to_queue_by_artist(song_list, room, artist, song)
    songs_by_artist = return_songs_by_artist(song_list, artist)
    if songs_by_artist != []
      song_to_queue = song_list.find { |song_in_list| song_in_list == song }
      add_song_to_queue(room, song_to_queue)
    end
    return "Sorry, we don't have any songs by #{artist}!"
  end

  def add_song_to_queue_by_decade(song_list, room, decade, song)
    songs_from_decade = return_songs_by_decade(song_list, decade)
    if songs_from_decade != []
      song_to_queue = song_list.find { |song_in_list| song_in_list == song }
      add_song_to_queue(room, song_to_queue)
    end
    return "Sorry, we don't have any songs from the #{decade}!"
  end



end
