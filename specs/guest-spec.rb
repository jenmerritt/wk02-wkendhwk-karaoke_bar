require('pry')
require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../guest')
require_relative('../song')

class GuestTest < MiniTest::Test

  def setup
    @song1 = Song.new("Whitney Houston", "I Wanna Dance With Somebody", "1980s")
    @song2 = Song.new("Adele", "When We Were Young", "2010s")
    @song3 = Song.new("Spice Girls", "Wannabe", "1990s")
    @song4 = Song.new("Mariah Carey", "All I Want For Christmas", "1990s")
    @song5 = Song.new("Blondie", "Heart Of Glass", "1970s")
    @guest1 = Guest.new("Phoebe Buffae", 50, @song1)
    @guest2 = Guest.new("Joey Tribiani", 30, @song2)
    @guest3 = Guest.new("Ken Adams", 5, @song3)
    @guest4 = Guest.new("Regina Phalange", 80, @song4)
  end

# getter tests for guest properties

  def test_can_get_guest_name
    assert_equal("Ken Adams", @guest3.name())
  end

  def test_can_get_guest_wallet
    assert_equal(50, @guest1.wallet())
  end

  def test_can_get_favourite_song
    assert_equal(@song1, @guest1.favourite_song())
  end

  def test_guest_can_cheer
    assert_equal("WooHoo!", @guest1.cheer())
  end

# add / remove cash from wallet

  def test_can_add_cash_to_wallet
    @guest1.add_cash(10)
    assert_equal(60, @guest1.wallet())
  end

  def test_can_remove_cash_from_wallet
    @guest1.remove_cash(10)
    assert_equal(40, @guest1.wallet())
  end

end
