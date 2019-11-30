# require('pry')
# binding.pry

class Song

  attr_reader :artist, :decade, :title

  def initialize(artist, title, decade)
    @artist = artist
    @title = title
    @decade = decade
  end

end
