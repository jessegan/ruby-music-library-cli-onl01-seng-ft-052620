class Artist
    extend Concerns::Findable

    attr_accessor :name,:songs

    @@all = []

    # constructors
    def initialize(name)
        @name = name
        @songs = []
    end

    def self.create(name)
        artist = Artist.new(name)
        artist.save
        artist
    end
    
    # class methods
    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    # instance methods
    def save
        @@all << self
    end

    def add_song(song)
        song.artist = self if !song.artist
        self.songs << song if !self.songs.include?(song)
    end

    def genres
        self.songs.map {|song| song.genre}.uniq
    end

end