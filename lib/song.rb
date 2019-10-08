class Song
  @@all = []
  attr_accessor :name
  attr_reader :genre, :artist
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  def genre=(genre)
    @genre=genre
        genre.songs << self unless genre.songs.include?(self)
  end
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
    
  def self.all
    @@all
  end
  def save
    @@all << self
  end
  def self.create(name, artist = nil, genre = nil)
    new_song=Song.new(name, artist, genre)
    new_song.save
    new_song
  end
  def self.destroy_all
    self.all.clear
  end
  def self.find_by_name(song)
    self.all.detect {|s| s.name == song}
  end
  def self.find_or_create_by_name(song)
    find_by_name(song)|| create(song)
  end
  def self.new_from_filename(filename)
    info = filename.split(" - ")
    artist_name, song_name, genre_name = info[0], info[1], info[2].gsub(".mp3", "")
    
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre)
  end
  
  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save }
  end
end