class Song
    extend Concerns::Findable

    attr_accessor :name,:artist,:genre

    @@all = []

    # Constructors
    def initialize(name,artist = nil,genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    # setters and getters
    def artist=(artist)
        @artist = artist if !@artist
        artist.add_song(self) if !artist.songs.include?(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self if !genre.songs.include?(self)
    end

    # class methods
    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.new_from_filename(filename)
        parse = filename.gsub(".mp3","").split(" - ")
        song = self.find_by_name(parse[1].strip)
        song ||= Song.new(parse[1].strip)
        song.artist = Artist.find_or_create_by_name(parse[0].strip)
        song.genre = Genre.find_or_create_by_name(parse[2].strip)
        song
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
        song 
    end

    # instance methods
    def save
        @@all << self
    end
    


end