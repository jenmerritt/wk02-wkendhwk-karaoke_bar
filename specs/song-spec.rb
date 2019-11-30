# require('pry')
# binding.pry

require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../song')

class SongTest < MiniTest::Test

  def setup
    @song1 = Song.new("Whitney Houston", "I Wanna Dance With Somebody", "1980s")
    @song2 = Song.new("Adele", "When We Were Young", "2010s")
    @song3 = Song.new("Spice Girls", "Wannabe", "1990s")
    @song4 = Song.new("Mariah Carey", "All I Want For Christmas", "1990s")
    @song5 = Song.new("Blondie", "Heart Of Glass", "1970s")
  end

  # getter tests for song properties

  def test_can_get_song_artist
    assert_equal("Whitney Houston", @song1.artist)
  end

  def test_can_get_song_title
    assert_equal("Wannabe", @song3.title)
  end

  def test_can_get_song_decade
    assert_equal("2010s", @song2.decade)
  end

end
