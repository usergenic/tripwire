require 'rubygems'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "tripwire"
    gem.summary = "Executes a shell command every time file/folder changes"
    gem.description = "Similar to rstakeout and autotest except more options"
    gem.email = "brendan@usergenic.com"
    gem.homepage = "http://github.com/brendan/tripwire"
    gem.authors = ["Brendan Baldwin", "Matthew Fallshaw", "Sven Schwyn"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

