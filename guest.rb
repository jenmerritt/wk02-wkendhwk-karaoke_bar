# require('pry')
# binding.pry

class Guest

  attr_reader :name, :wallet

  def initialize(name, wallet)
    @name = name
    @wallet = wallet
  end

  def add_cash(amount)
    return @wallet += amount
  end

  def remove_cash(amount)
    return @wallet -= amount
  end

end
