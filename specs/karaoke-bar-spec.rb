# require('pry')
# binding.pry

require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../karaoke-bar')
require_relative('../room')
require_relative('../song')
require_relative('../guest')

class KaraokeBarTest < MiniTest::Test

  def setup
    @guest1 = Guest.new("Phoebe Buffae", 50)
    @guest2 = Guest.new("Joey Tribiani", 30)
    @guest3 = Guest.new("Ken Adams", 5)
    @guest4 = Guest.new("Regina Phalange", 80)
    @song1 = Song.new("Whitney Houston", "I Wanna Dance With Somebody", "1980s")
    @song2 = Song.new("Adele", "When We Were Young", "2010s")
    @song3 = Song.new("Spice Girls", "Wannabe", "1990s")
    @song4 = Song.new("Mariah Carey", "All I Want For Christmas", "1990s")
    @song5 = Song.new("Blondie", "Heart Of Glass", "1970s")
    @song_list = [@song1, @song2, @song3, @song4, @song5]
    # @songs1 = []
    # @songs2 = []
    # @songs3 = []
    # @guests1 = []
    # @guests2 = []
    # @guests3 = []
    @room1 = Room.new("Room 1", 5, @guests1, @songs1)
    @room2 = Room.new("Room 2", 10, @guests2, @songs2)
    @room3 = Room.new("Room 3", 2, @guests3, @songs3)
    @room_list = [@room1, @room2, @room3]
    @karaoke_bar = KaraokeBar.new("Supercuboid", 1000, @room_list, @song_list, 10)
  end

# getter tests for karaoke bar properties

  def test_can_get_bar_name
    assert_equal("Supercuboid", @karaoke_bar.name)
  end

  def test_can_get_till_total
    assert_equal(1000, @karaoke_bar.till)
  end

  def test_can_get_number_of_songs
    assert_equal(5, @karaoke_bar.number_of_songs)
  end

  def test_can_get_song_list
    assert_equal([@song1, @song2, @song3, @song4, @song5], @karaoke_bar.return_song_list)
  end

  def test_can_get_number_of_rooms
    assert_equal(3, @karaoke_bar.number_of_rooms)
  end

  def test_can_get_list_of_rooms
    assert_equal([@room1, @room2, @room3], @karaoke_bar.return_room_list)
  end

  def test_can_add_song_to_karaoke_bar_song_list
    @karaoke_bar.add_song_to_karaoke_bar_list(@song1)
    assert_equal(6, @karaoke_bar.number_of_songs)
  end

# tests for methods that check guests into and out of a specific room created in the room class

  def test_can_check_guest_into_selected_room
    @karaoke_bar.check_guest_in(@room1, @guest1)
    assert_equal(1, @room1.number_of_guests_in_room)
  end

  # def test_can_check_guest_into_selected_room__guest_already_in_room
  #   guest_already_in_room = @karaoke_bar.check_guest_in(@room1, @guest1)
  #   assert_equal("#{@guest1.name} is already in this room!", guest_already_in_room)
  # end

  def test_can_check_guest_out_of_selected_room__guest_is_in_room
    @karaoke_bar.check_guest_in(@room1, @guest1)
    @karaoke_bar.check_guest_in(@room1, @guest2)
    @karaoke_bar.check_guest_out(@room1, @guest1)
    assert_equal(1, @room1.number_of_guests_in_room)
  end

  def test_can_check_guest_out_of_selected_room__guest_not_in_room
    guest_not_in_room = @karaoke_bar.check_guest_out(@room1, @guest1)
    assert_equal("#{@guest1.name} is not in this room!", guest_not_in_room)
  end

# tests for methods that add songs into and remove songs out of a specific room created in the room class
# no need to check if it already exist - as the song could be queued multiple times!
# note that removing a song from the queue removes all instances of that song from the queue

    def test_can_add_song_to_room
      @karaoke_bar.add_song_to_queue(@room1, @song1)
      @karaoke_bar.add_song_to_queue(@room1, @song2)
      assert_equal(2, @room1.number_of_songs_in_room)
    end

    def test_can_remove_song_from_room
      @karaoke_bar.add_song_to_queue(@room1, @song1)
      @karaoke_bar.add_song_to_queue(@room1, @song1)
      @karaoke_bar.add_song_to_queue(@room1, @song1)
      @karaoke_bar.remove_song_from_queue(@room1, @song1)
      assert_equal(0, @room1.number_of_songs_in_room)
    end

    def test_can_find_song_by_title__found
      song_found = @karaoke_bar.find_song_by_title(@song_list, "Wannabe")
      assert_equal(@song3, song_found)
    end

    def test_can_find_song_by_title__not_found
      song_not_found = @karaoke_bar.find_song_by_title(@song_list, "Suspicious Minds")
      assert_nil(song_not_found)
    end

# tests for adding songs into rooms by searching for properties of that song

    def test_can_add_song_to_room_by_title__song_found
      @karaoke_bar.add_song_to_queue_by_title(@song_list, @room1, "Wannabe")
      assert_equal(1, @room1.number_of_songs_in_room)
      assert_equal([@song3], @room1.room_song_list)
    end

    def test_can_add_song_to_room_by_title__song_not_found
      song_does_not_exist = @karaoke_bar.add_song_to_queue_by_title(@song_list, @room1, "Suspicious Minds")
      assert_equal("Sorry, we don't have Suspicious Minds!", song_does_not_exist)
    end


end
