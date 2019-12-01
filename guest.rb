require('pry')
# binding.pry

class Guest

  attr_reader :name, :wallet, :favourite_song

  def initialize(name, wallet, favourite_song)
    @name = name
    @wallet = wallet
    @favourite_song = favourite_song
  end

  def add_cash(amount)
    return @wallet += amount
  end

  def remove_cash(amount)
    return @wallet -= amount
  end

end
