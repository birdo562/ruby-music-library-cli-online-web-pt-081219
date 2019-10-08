class Artist
  @@all = []
  attr_accessor :name, :songs
  extend Concerns::Findable
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
    new_artist=Artist.new(name)
    new_artist.save
    new_artist
  end
  def self.destroy_all
    self.all.clear
  end
   def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end
  def genres
    songs.collect{|song| song.genre }.uniq
  end
end
