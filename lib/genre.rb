class Genre
    extend Concerns::Findable

    attr_accessor :name,:songs

    @@all = []

    # constructors
    def initialize(name)
        @name = name
        @songs = []
    end

    def self.create(name)
        genre = Genre.new(name)
        genre.save
        genre
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

    def artists
        self.songs.map {|song| song.artist}.uniq
    end
    
end