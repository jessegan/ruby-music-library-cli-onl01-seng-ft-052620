require 'pry'
class MusicImporter
    
    attr_accessor :path

    # constructors
    def initialize(path)
        @path = path    
    end
    
    # instance methods
    def files
        Dir[self.path + "/*.mp3"].map {|file| file.split("/").last}
    end

    # class methods
    def import 
        self.files.each do |filename|
            Song.create_from_filename(filename)
        end
    end

end

# test = MusicImporter.new("/mnt/c/Users/jesse/OneDrive/Documents/Coding/Flatiron_School/Labs/ruby-music-library-cli-onl01-seng-ft-052620/spec/fixtures/mp3s")
# binding.pry