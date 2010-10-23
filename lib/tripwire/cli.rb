require 'optparse'
require 'tripwire/runner'

module Tripwire
  class CLI

    private
    
    def initialize(args)
      
      trap('INT') do
        puts "\nQuitting..."
        exit
      end
      
      scanner = Tripwire::Scanner.new
      recursive = true
      delay = 1
      option_parser = OptionParser.new do |opt|
        opt.banner = "Usage: tripwire [options] COMMAND [FILESPEC]+"
        opt.on("-e","--exclude PATTERN", String,
               "a pattern defining files/folders to ignore") do |e|
          scanner.exclude_patterns << e
        end
        opt.on("-d","--delay SECONDS", Integer,
               "number of seconds between each scan (defaults to 1)") do |d|
          delay = d
        end
        opt.on("-q","--quiet",
               "suppresses output") do
          scanner.quiet = true
        end
        opt.on("-n","--non-recursive",
               "tells tripwire *not* to scan folders recursively") do
          recursive = false
        end
      end

      option_parser.parse!(args)
            
      command = args.shift
      nothing_to_watch = true
      args.map! do |arg|
        if File.exist?(arg)
          nothing_to_watch = false
        else
          STDERR.puts "'#{arg}' doesn't exist."
        end
        File.directory?(arg) ? "#{arg}/**/*" : arg
      end if recursive

      # Enough to run?
      if command.nil?
        raise "No command specified.  Please specify a command to run."
      elsif args.empty?
        args = ["."]
        puts "Watching default path '.'"
      elsif nothing_to_watch
        STDERR.puts "WARNING: Nothing to watch in '#{args.join(", ")}'"
      # else good to run
      end

      scanner.scan_patterns.concat(args)
      runner = Tripwire::Runner.new(scanner, command, :delay => delay)
      runner.run!
    rescue
      STDERR.puts "#{$!}\n\n#{option_parser}"
    end
    
  end
end
