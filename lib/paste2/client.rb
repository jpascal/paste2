require 'optparse'
require 'net/http'

class Paste2::Client
  def self.post(code, description = '', lang = 'text')
    uri = URI(Paste2::URL)
    res = Net::HTTP.post_form(uri, :code => code, :description => description, :lang => lang)
    File.join(Paste2::URL,res["location"])
  end
  def initialize
    @options = {}
    parser = OptionParser.new do|opts|
      opts.separator ""
      opts.separator "Examples:"
      opts.separator "    echo 'code' | paste2"
      opts.separator "    paste2 < file"
      opts.separator ""
      opts.separator "Specific options:"
      opts.banner = "Usage: paste2 [options]"
      opts.on( '-f', '--file FILE', 'Post content from file' ) do|file|
        @options[:file] = file
      end
      opts.on( '-d', '--description TEXT', 'Description for post' ) do|description|
        @options[:description] = description
      end
      opts.on( '-a', '--all', 'List supported languages' ) do|file|
        puts "Supported languages:"
        Paste2::LANGUAGES.each do |lang, name|
          printf "\t%-20s %s\n", lang, name
        end
        exit(0)
      end
      opts.on( '-l', '--lang LANG', 'Post content as language (default is text)' ) do|language|
        if Paste2::LANGUAGES.include? language
          @options[:language] = language
        else
          puts "Not supported language '#{language}'"
          exit(1)
        end
      end
      opts.on( '-h', '--help', 'Display this screen' ) do
        @options[:help] = true
      end
    end
    begin
      parser.parse ARGV
      if @options[:help]
        puts parser
      end
    rescue => e
      puts e.message
    end
  end
  def run
    return if @options[:help]
    begin
      code ||= @options[:file].nil? ? STDIN.readlines : File.open(@options[:file]).readlines
      puts Paste2::Client.post(code.join(""), @options[:description], @options[:language])
    rescue => e
      puts e.message
      exit(1)
    end
  end
end
