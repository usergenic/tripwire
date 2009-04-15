module Tripwire
  class Runner
    
    attr_accessor :scanner
    attr_accessor :command
    attr_accessor :delay

    def run!
      raise "No command specified.  Please specify a command to run." if !command
      raise "No files/folders specified.  Please specify files/patterns to scan." if scanner.scan_patterns.empty?
      scanner.scan # do this because we don't care about the initial updates collection
      loop do
        sleep delay
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