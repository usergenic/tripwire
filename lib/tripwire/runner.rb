module Tripwire
  class Runner

	GEM_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    
    attr_accessor :scanner
    attr_accessor :command
    attr_accessor :delay

    attr_accessor :interrupted

    def run!
      raise "No command specified.  Please specify a command to run." if !command
      raise "No files/folders specified.  Please specify files/patterns to scan." if scanner.scan_patterns.empty?
      original_quiet = scanner.quiet
      scanner.quiet = true
      scanner.scan # do this because we don't care about the initial updates collection
      scanner.quiet = original_quiet

      add_sigint_handler

      loop do
        begin
          `cd '#{Dir.pwd}'; #{File.join(GEM_PATH, 'bin', 'fsevent_sleep')} . 2>&1`
        rescue
          sleep delay
        end
        system(command) unless scanner.scan.empty?
      end  
    end
    
    private
    
    def initialize(scanner, command, options={})
      self.scanner = scanner
      self.command = command
      self.delay = options[:delay] || 1
    end

    def add_sigint_handler
      trap('INT') do
        if interrupted then
          puts "\nQuitting..."
          exit 0
        else
          puts "Interrupt a second time to quit"
          self.interrupted = true
          Kernel.sleep 1.5
          system(command)
          self.interrupted = false
        end
      end
    end

  end
end
