# require('pry')
# binding.pry

require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../guest')

class GuestTest < MiniTest::Test

  def setup
    @guest1 = Guest.new("Jen Merritt", 50)
    @guest2 = Guest.new("Nicky Wright", 30)
    @guest3 = Guest.new("Ken Adams", 5)
    @guest4 = Guest.new("Regina Phalange", 80)
  end

end
