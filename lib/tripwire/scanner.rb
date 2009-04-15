module Tripwire
  class Scanner
    attr_accessor :exclude_patterns
    attr_accessor :scan_patterns
    attr_accessor :scanned_files
    attr_accessor :scanned_file_mtimes
    attr_accessor :updates
    attr_accessor :verbose

    def scan
      updates.clear
      files = scan_patterns.map {|scan_pattern| Dir.glob(scan_pattern) }.flatten.uniq
      exclude_list = exclude_patterns.map {|exclude_pattern| Dir.glob(exclude_pattern) }.flatten
      files -= exclude_list
      excluded_folders = exclude_list.select {|item| File.directory?(item) }
      excluded_folders.each do |folder|
        regexp = /^#{Regexp.escape(folder)}\//
        files -= files.select {|file| file.match(regexp)}
      end
      files.each do |file|
        mtime = File.mtime(file)
        previous_mtime = scanned_file_mtimes[file]
        if mtime != previous_mtime
          if !previous_mtime
            updates << "A #{file}"
          else
            updates << "M #{file}"
          end
          scanned_file_mtimes[file] = mtime
        end
      end
      missing_files = scanned_files - files
      missing_files.each do |file|
        scanned_file_mtimes.delete(file)
        updates << "D #{file}"
      end
      self.scanned_files.replace(files)
      puts updates if verbose
      updates
    end
    
    def tripped?
      !updates.empty?
    end
    
    private
    
    def initialize
      self.exclude_patterns = []
      self.scan_patterns = []
      self.scanned_files = []
      self.scanned_file_mtimes = {}
      self.updates = []
      self.verbose = false
    end
    
  end
end
