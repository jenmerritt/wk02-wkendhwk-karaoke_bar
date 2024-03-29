require('pry')
require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../room')
require_relative('../song')
require_relative('../guest')

class RoomTest < MiniTest::Test

  def setup
    @song1 = Song.new("Whitney Houston", "I Wanna Dance With Somebody", "1980s")
    @song2 = Song.new("Adele", "When We Were Young", "2010s")
    @song3 = Song.new("Spice Girls", "Wannabe", "1990s")
    @song4 = Song.new("Whitney Houston", "When You Believe", "1990s")
    @song5 = Song.new("Blondie", "When We Were Young", "1970s")
    @guest1 = Guest.new("Phoebe Buffae", 50, @song1)
    @guest2 = Guest.new("Joey Tribiani", 30, @song2)
    @guest3 = Guest.new("Ken Adams", 5, @song3)
    @guest4 = Guest.new("Regina Phalange", 80, @song4)
    @room1 = Room.new("Room 1", 5, @guests1, @songs1)
    @room2 = Room.new("Room 2", 10, @guests2, @songs2)
    @room3 = Room.new("Room 3", 2, @guests3, @songs3)
  end

# getter tests for room properties

  def test_can_get_room_name
    assert_equal("Room 1", @room1.name())
  end

  def test_can_get_room_capacity
    assert_equal(5, @room1.capacity())
  end

  def test_room_guest_list_starts_empty
    assert_equal(0, @room1.number_of_guests_in_room())
  end

  def test_room_song_queue_starts_empty
    assert_equal(0, @room1.number_of_songs_in_room())
  end

end
