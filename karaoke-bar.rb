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

# method to check guests into a specific room created in the room class

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


end
