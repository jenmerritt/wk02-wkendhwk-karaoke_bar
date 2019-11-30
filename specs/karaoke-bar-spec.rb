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
  end

end
