# require('pry')
# binding.pry

require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../room')
require_relative('../song')
require_relative('../guest')

class RoomTest < MiniTest::Test

  def setup
    @room1 = Room.new("Room 1", 5)
    @room2 = Room.new("Room 2", 10)
    @room3 = Room.new("Room 3", 2)
  end

# getter tests for room properties

  def test_can_get_room_name
    assert_equal("Room 1", @room1.name)
  end

  def test_can_get_room_capacity
    assert_equal(5, @room1.capacity)
  end

  def test_room_guest_list_starts_empty
    assert_equal(0, @room1.guest_list_length)
  end

  def test_room_song_list_starts_empty
    assert_equal(0, @room1.song_list_length)
  end

end
