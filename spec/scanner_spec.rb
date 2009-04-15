require File.join(File.dirname(__FILE__),"spec_helper")

describe "A Tripwire Scanner" do

  attr_accessor :scanner

  temp = File.join(File.dirname(__FILE__),"../temp")

  define_method :clear_temp_folder do
    Dir.glob("#{temp}/**/*").sort.reverse.each do |item|
      File.file?(item) ? File.delete(item) : Dir.delete(item)
    end
  end

  before :each do
    clear_temp_folder
    self.scanner = Tripwire::Scanner.new
    scanner.scan_patterns << "#{temp}/**/*"
  end
  
  after :all do
    clear_temp_folder
  end

  it "should detect that a folder is added to a watched folder" do
    Dir.mkdir("#{temp}/subfolder")
    scanner.scan.should_not be_empty
    scanner.scan.should be_empty
  end

  it "should detect that a file is added to a watched folder" do
    scanner.scan.should be_empty
    File.open("#{temp}/testfile", "w") {}
    scanner.scan.should_not be_empty
    scanner.scan.should be_empty
  end
  
  it "should detect that a watched file is modified" do
    scanner.scan.should be_empty
    File.open("#{temp}/testfile", "w") {}
    scanner.scan.should_not be_empty
    scanner.scan.should be_empty
    sleep 1
    File.open("#{temp}/testfile", "w") {|f| f.write("something")}
    scanner.scan.should_not be_empty
  end
  
  it "should detect that a watched file is deleted" do
    scanner.scan.should be_empty
    File.open("#{temp}/testfile", "w") {}
    scanner.scan.should_not be_empty
    scanner.scan.should be_empty
    File.delete("#{temp}/testfile")
    scanner.scan.should_not be_empty
    scanner.scan.should be_empty
  end
  
  it "should not watch a file matching an exclude pattern" do
    scanner.exclude_patterns << "#{temp}/**/irrelevant"
    scanner.scan.should be_empty
    File.open("#{temp}/irrelevant", "w") {}
    scanner.scan.should be_empty
  end

  it "should not watch a folder matching an exclude pattern" do
    scanner.exclude_patterns << "#{temp}/**/irrelevant"
    scanner.scan.should be_empty
    Dir.mkdir("#{temp}/irrelevant")
    scanner.scan.should be_empty
    File.open("#{temp}/irrelevant/testfile", "w") {}
    scanner.scan.should be_empty
  end

end

