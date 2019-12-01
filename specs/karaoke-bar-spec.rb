require('pry')
require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../karaoke-bar')
require_relative('../room')
require_relative('../song')
require_relative('../guest')

class KaraokeBarTest < MiniTest::Test

  def setup
    @song1 = Song.new("Whitney Houston", "I Wanna Dance With Somebody", "1980s")
    @song2 = Song.new("Adele", "When We Were Young", "2010s")
    @song3 = Song.new("Spice Girls", "Wannabe", "1990s")
    @song4 = Song.new("Whitney Houston", "When You Believe", "1990s")
    @song5 = Song.new("Blondie", "When We Were Young", "1970s")
    @guest1 = Guest.new("Phoebe Buffae", 50, @song1)
    @guest2 = Guest.new("Joey Tribiani", 10, @song2)
    @guest3 = Guest.new("Ken Adams", 5, @song3)
    @guest4 = Guest.new("Regina Phalange", 80, @song4)
    @song_list = [@song1, @song2, @song3, @song4, @song5]
    @room1 = Room.new("Room 1", 5, @guests1, @songs1)
    @room2 = Room.new("Room 2", 10, @guests2, @songs2)
    @room3 = Room.new("Room 3", 2, @guests3, @songs3)
    @room_list = [@room1, @room2, @room3]
    @karaoke_bar = KaraokeBar.new("Supercuboid", 1000, @room_list, @song_list, 10)
  end

#############
### GETTERS
#############

# getter tests for karaoke bar properties

  def test_can_get_bar_name
    assert_equal("Supercuboid", @karaoke_bar.name())
  end

  def test_can_get_till_total
    assert_equal(1000, @karaoke_bar.till())
  end

  def test_can_get_number_of_songs
    assert_equal(5, @karaoke_bar.number_of_songs())
  end

  def test_can_get_song_list
    assert_equal([@song1, @song2, @song3, @song4, @song5], @karaoke_bar.return_song_list())
  end

  def test_can_get_number_of_rooms
    assert_equal(3, @karaoke_bar.number_of_rooms())
  end

  def test_can_get_list_of_rooms
    assert_equal([@room1, @room2, @room3], @karaoke_bar.return_room_list())
  end

  def test_can_get_entry_fee
    assert_equal(10, @karaoke_bar.entry_fee())
  end

# add or remove cash from till

  def test_can_add_cash_to_till
    @karaoke_bar.add_cash(10)
    assert_equal(1010, @karaoke_bar.till())
  end

  def test_can_remove_cash_from_till
    @karaoke_bar.remove_cash(10)
    assert_equal(990, @karaoke_bar.till())
  end

############
### GUESTS
############

  def test_can_add_guest_to_room
    @karaoke_bar.add_guest_to_room(@room1, @guest1)
    assert_equal(1, @room1.number_of_guests_in_room())
  end

# check if room has capacity to add people or not

  def test_check_if_guest_list_exceeds_room_capacity__exceeds
    @karaoke_bar.add_guest_to_room(@room3, @guest1)
    @karaoke_bar.add_guest_to_room(@room3, @guest2)
    @karaoke_bar.add_guest_to_room(@room3, @guest3)
    capacity_check = @karaoke_bar.check_capacity(@room3.number_of_guests_in_room(), @room3.capacity())
    assert_equal(false, capacity_check)
  end

  def test_check_if_guest_list_exceeds_room_capacity__equals
    @karaoke_bar.add_guest_to_room(@room3, @guest1)
    @karaoke_bar.add_guest_to_room(@room3, @guest2)
    capacity_check = @karaoke_bar.check_capacity(@room3.number_of_guests_in_room(), @room3.capacity())
    assert_equal(false, capacity_check)
  end

  def test_check_if_guest_list_exceeds_room_capacity__does_not_exceed
    @karaoke_bar.add_guest_to_room(@room3, @guest1)
    capacity_check = @karaoke_bar.check_capacity(@room3.number_of_guests_in_room(), @room3.capacity())
    assert_equal(true, capacity_check)
  end

# check if guest has enough money to pay entry fee or not.

  def test_can_guest_afford_entry_fee__true_greater_than
    check = @karaoke_bar.can_guest_afford_entry(@karaoke_bar.entry_fee(), @guest1.wallet())
    assert_equal(true, check)
  end

  def test_can_guest_afford_entry_fee__true_equal
    check = @karaoke_bar.can_guest_afford_entry(@karaoke_bar.entry_fee(), @guest2.wallet())
    assert_equal(true, check)
  end

  def test_can_guest_afford_entry_fee__false
    check = @karaoke_bar.can_guest_afford_entry(@karaoke_bar.entry_fee(), @guest3.wallet())
    assert_equal(false, check)
  end

# test bar sells admission to guest if they can afford

  def test_bar_can_sell_admission__can_afford
    @karaoke_bar.sell_admission(10, @guest1)
    assert_equal(1010, @karaoke_bar.till())
    assert_equal(40, @guest1.wallet())
  end

  def test_bar_can_sell_admission__cannot_afford
    @karaoke_bar.sell_admission(10, @guest3)
    assert_equal(1000, @karaoke_bar.till())
    assert_equal(5, @guest3.wallet())
  end

# check if guest is already in room

  def test_if_guest_is_in_room_list__true
    @karaoke_bar.add_guest_to_room(@room1, @guest1)
    check = @karaoke_bar.check_if_guest_in_room(@room1, @guest1)
    assert_equal(true, check)
  end

  def test_if_guest_is_in_room_list__false
    check = @karaoke_bar.check_if_guest_in_room(@room1, @guest1)
    assert_equal(false, check)
  end

### tests for methods that check guests into and out of a specific room created in the room class

# check in
# test check in if can afford, does not check in if cannot afford

  def test_can_check_guest_into_selected_room__can_afford
    @karaoke_bar.check_guest_in(10, @room1, @guest1)
    assert_equal(1, @room1.number_of_guests_in_room)
    assert_equal(1010, @karaoke_bar.till())
    assert_equal(40, @guest1.wallet())
  end

  def test_can_check_guest_into_selected_room__cannot_afford
    @karaoke_bar.check_guest_in(10, @room1, @guest3)
    assert_equal(0, @room1.number_of_guests_in_room)
    assert_equal(1000, @karaoke_bar.till())
    assert_equal(5, @guest3.wallet())
  end

# test - does not check in if guest already in room

  def test_can_check_guest_into_selected_room__guest_already_in_room
    @karaoke_bar.add_guest_to_room(@room1, @guest1)
    @karaoke_bar.check_guest_in(10, @room1, @guest1)
    guest_already_in_room = @karaoke_bar.check_guest_in(10, @room1, @guest1)
    assert_equal("#{@guest1.name} is already in this room!", guest_already_in_room)
    assert_equal(1, @room1.number_of_guests_in_room())
    assert_equal(1000, @karaoke_bar.till())
    assert_equal(50, @guest1.wallet())
  end

# test - does not check in if room capacity exceeded

  def test_can_not_check_guest_into_selected_room__capacity_exceeded
    @karaoke_bar.add_guest_to_room(@room3, @guest1)
    @karaoke_bar.add_guest_to_room(@room3, @guest2)
    @karaoke_bar.check_guest_in(10, @room3, @guest4)
    assert_equal(2, @room3.number_of_guests_in_room())
    assert_equal(1000, @karaoke_bar.till())
    assert_equal(80, @guest4.wallet())
  end

# test - will check in if room capacity not exceeded

  def test_can_check_guest_into_selected_room__capacity_not_exceeded
    @karaoke_bar.add_guest_to_room(@room3, @guest1)
    @karaoke_bar.check_guest_in(10, @room3, @guest4)
    assert_equal(2, @room3.number_of_guests_in_room())
    assert_equal(1010, @karaoke_bar.till())
    assert_equal(70, @guest4.wallet())
  end

# check guest out of room

  def test_can_check_guest_out_of_selected_room__guest_is_in_room
    @karaoke_bar.check_guest_in(10, @room1, @guest1)
    @karaoke_bar.check_guest_in(10, @room1, @guest2)
    @karaoke_bar.check_guest_out(@room1, @guest1)
    assert_equal(1, @room1.number_of_guests_in_room())
  end

  def test_can_not_check_guest_out_of_selected_room__guest_not_in_room
    guest_not_in_room = @karaoke_bar.check_guest_out(@room1, @guest1)
    assert_equal("#{@guest1.name()} is not in this room!", guest_not_in_room)
  end

##############
### SONGS
#############

  def test_can_add_song_to_karaoke_bar_song_list
    @karaoke_bar.add_song_to_karaoke_bar_list(@song1)
    assert_equal(6, @karaoke_bar.number_of_songs())
  end

# tests for methods that add songs into and remove songs out of a specific room created in the room class
# no need to check if it already exist - as the song could be queued multiple times!
# note that removing a song from the queue removes all instances of that song from the queue.

  def test_can_add_song_to_room_song_queue
    @karaoke_bar.add_song_to_queue(@room1, @song1)
    @karaoke_bar.add_song_to_queue(@room1, @song2)
    assert_equal(2, @room1.number_of_songs_in_room())
  end

  def test_can_remove_song_from_room_song_queue
    @karaoke_bar.add_song_to_queue(@room1, @song1)
    @karaoke_bar.add_song_to_queue(@room1, @song1)
    @karaoke_bar.add_song_to_queue(@room1, @song1)
    @karaoke_bar.remove_song_from_queue(@room1, @song1)
    assert_equal(0, @room1.number_of_songs_in_room())
  end

# tests for methods to find a song by a property i.e. title / artist / decade

# by title - returns list of all songs matching the title string given

  def test_can_find_song_by_title__one_match
    song_found = @karaoke_bar.return_songs_by_title(@song_list, "Wannabe")
    assert_equal([@song3], song_found)
  end

  def test_can_find_song_by_title__multiple_matches
    songs_found = @karaoke_bar.return_songs_by_title(@song_list, "When We Were Young")
    assert_equal([@song2, @song5], songs_found)
  end

  def test_can_find_song_by_title__no_matches
    song_not_found = @karaoke_bar.return_songs_by_title(@song_list, "Suspicious Minds")
    assert_equal([], song_not_found)
  end

# by artist - returns list of all songs matching the artist string given

  def test_can_find_song_by_artist__one_match
    song_found = @karaoke_bar.return_songs_by_artist(@song_list, "Adele")
    assert_equal([@song2], song_found)
  end

  def test_can_find_song_by_artist__multiple_matches
    songs_found = @karaoke_bar.return_songs_by_artist(@song_list, "Whitney Houston")
    assert_equal([@song1, @song4], songs_found)
  end

  def test_can_find_song_by_artist__no_matches
    song_not_found = @karaoke_bar.return_songs_by_artist(@song_list, "Britney Lovato")
    assert_equal([], song_not_found)
  end

# by decade - returns list of all songs matching the decade string given

  def test_can_find_song_by_decade__one_match
    song_found = @karaoke_bar.return_songs_by_decade(@song_list, "2010s")
    assert_equal([@song2], song_found)
  end

  def test_can_find_song_by_decade__multiple_matches
    songs_found = @karaoke_bar.return_songs_by_decade(@song_list, "1990s")
    assert_equal([@song3, @song4], songs_found)
  end

  def test_can_find_song_by_decade__no_matches
    song_not_found = @karaoke_bar.return_songs_by_decade(@song_list, "1950s")
    assert_equal([], song_not_found)
  end

# tests for adding songs into rooms by searching for properties of that song

# returns array of songs based on string for title/artist/decade, then that array can be searched for the song they are wanting to find

  def test_can_add_song_to_room_by_title__song_found
    @karaoke_bar.add_song_to_queue_by_title(@song_list, @room1, "When We Were Young", @song2)
    assert_equal(1, @room1.number_of_songs_in_room())
    assert_equal([@song2], @room1.room_song_queue())
  end

  def test_can_add_song_to_room_by_title__song_not_found
    song_does_not_exist = @karaoke_bar.add_song_to_queue_by_title(@song_list, @room1, "Suspicious Minds", @song2)
    assert_equal("Sorry, we don't have Suspicious Minds!", song_does_not_exist)
  end

  def test_can_add_song_to_room_by_artist__song_found
    @karaoke_bar.add_song_to_queue_by_artist(@song_list, @room1, "Whitney Houston", @song1)
    assert_equal(1, @room1.number_of_songs_in_room())
    assert_equal([@song1], @room1.room_song_queue())
  end

  def test_can_add_song_to_room_by_artist__song_not_found
    song_does_not_exist = @karaoke_bar.add_song_to_queue_by_artist(@song_list, @room1, "Britney Lovato", @song1)
    assert_equal("Sorry, we don't have any songs by Britney Lovato!", song_does_not_exist)
  end

  def test_can_add_song_to_room_by_decade__decade_has_songs
    @karaoke_bar.add_song_to_queue_by_decade(@song_list, @room1, "1990s", @song1)
    assert_equal(1, @room1.number_of_songs_in_room())
    assert_equal([@song1], @room1.room_song_queue())
  end

  def test_can_add_song_to_room_by_decade__no_songs
    no_songs = @karaoke_bar.add_song_to_queue_by_decade(@song_list, @room1, "1950s", @song1)
    assert_equal(0, @room1.number_of_songs_in_room())
    assert_equal("Sorry, we don't have any songs from the 1950s!", no_songs)
  end

# check if favourite song of guest is in room, guest celebrates if it is

  def test_guest_cheers_if_song_exists
    @karaoke_bar.add_song_to_queue(@room1, @song1)
    cheer = @karaoke_bar.favourite_song_cheer(@room1, @guest1)
    assert_equal("WooHoo!", cheer)
  end

end
