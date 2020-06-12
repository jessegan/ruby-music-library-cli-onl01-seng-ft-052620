class MusicLibraryController

    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import
    end

    # Controller methods
    
    def call
        puts "Welcome to your music library!"
        self.get_input
    end

    def print_menu
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
    end

    def get_input
        self.print_menu
        input = gets.strip
        self.handle_input(input)
    end

    def handle_input(input)
        case input
        when "list songs"
            self.list_songs
        when "list artists"
            self.list_artists
        when "list genres"
            self.list_genres
        when "list artist"
            self.list_songs_by_artist
        when "list genre"
            self.list_songs_by_genre
        when "play song"
            self.play_song
        when "exit"
            exit
        else
            puts "Invalid input. Try again."
        end

        self.get_input
    end

    # Model methods
    def list_songs
        Song.all.sort {|a,b| a.name<=>b.name}.each.with_index do |song,i| 
            puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort {|a,b| a.name <=> b.name}.each.with_index do |artist,i|
            puts "#{i+1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.sort {|a,b| a.name <=> b.name}.each.with_index do |genre,i|
            puts "#{i+1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        if artist = Artist.find_by_name(input)
            artist.songs.sort {|a,b| a.name<=>b.name}.each.with_index do |song,i|
                puts "#{i+1}. #{song.name} - #{song.genre.name}"
            end
        # else
        #     puts "No artist found."
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        if genre = Genre.find_by_name(input)
            genre.songs.sort {|a,b| a.name<=>b.name}.each.with_index do |song,i|
                puts "#{i+1}. #{song.artist.name} - #{song.name}"
            end
        # else
        #     puts "No artist found."
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        if input.between?(1,Song.all.length)
            song = Song.all.sort {|a,b| a.name <=> b.name}[input-1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end
    
end