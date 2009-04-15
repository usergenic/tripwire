# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tripwire}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brendan Baldwin"]
  s.date = %q{2009-04-15}
  s.default_executable = %q{tripwire}
  s.description = %q{Tripwire is a simple tool for watching a set of files/folders for changes and then triggering a shell command to execute when a change occurs.  It was written because I love the concepts behind autotest and rstakeout but the difference is that it will watch for the addition of files and subfolders where those tools only seemed to register a set of files at startup and never seemed to pick up on when you created new ones.  Tripwire uses very simple Dir.glob-ing}
  s.email = ["brendan@usergenic.com"]
  s.executables = ["tripwire"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/tripwire", "lib/tripwire.rb", "lib/tripwire/cli.rb", "lib/tripwire/runner.rb", "lib/tripwire/scanner.rb", "spec/scanner_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "temp"]
  s.has_rdoc = true
  s.homepage = %q{  http://github.com/brendan/tripwire}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{tripwire}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Tripwire is a simple tool for watching a set of files/folders for changes and then triggering a shell command to execute when a change occurs}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.12.1"])
    else
      s.add_dependency(%q<hoe>, [">= 1.12.1"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.12.1"])
  end
end
