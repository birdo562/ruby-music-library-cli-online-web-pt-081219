class Genre
  extend Concerns::Findable
  @@all = []
  attr_accessor :name, :songs
  def initialize(name)
    @name = name
    @@all << self
    @songs = []
  end
  def self.all
    @@all
  end
  def save
    @@all << self
  end
  def self.create(name)
    new_genre=Genre.new(name)
    new_genre.save
    new_genre
  end
  def self.destroy_all
    self.all.clear
  end
  def artists
    songs.collect{ |s| s.artist }.uniq
  end
end
