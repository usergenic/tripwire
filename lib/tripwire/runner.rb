module Tripwire
  class Runner

	GEM_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    
    attr_accessor :scanner
    attr_accessor :command
    attr_accessor :delay

    def run!
      raise "No command specified.  Please specify a command to run." if !command
      raise "No files/folders specified.  Please specify files/patterns to scan." if scanner.scan_patterns.empty?
      original_quiet = scanner.quiet
      scanner.quiet = true
      scanner.scan # do this because we don't care about the initial updates collection
      scanner.quiet = original_quiet
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
    
  end
end
