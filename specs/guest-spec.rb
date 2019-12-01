# require('pry')
# binding.pry

require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../guest')

class GuestTest < MiniTest::Test

  def setup
    @guest1 = Guest.new("Phoebe Buffae", 50)
    @guest2 = Guest.new("Joey Tribiani", 30)
    @guest3 = Guest.new("Ken Adams", 5)
    @guest4 = Guest.new("Regina Phalange", 80)
  end

# getter tests for guest properties

  def test_can_get_guest_name
    assert_equal("Ken Adams", @guest3.name)
  end

  def test_can_get_guest_wallet
    assert_equal(50, @guest1.wallet)
  end

# add / remove cash

  def test_can_add_cash_to_wallet
    @guest1.add_cash(10)
    assert_equal(60, @guest1.wallet)
  end

  def test_can_remove_cash_from_wallet
    @guest1.remove_cash(10)
    assert_equal(40, @guest1.wallet)
  end

end
