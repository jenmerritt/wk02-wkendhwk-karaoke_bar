require('pry')

class Song

  attr_reader(:artist, :title, :decade)

  def initialize(artist, title, decade)
    @artist = artist
    @title = title
    @decade = decade
  end

end
