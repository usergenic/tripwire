root_folder = File.dirname(__FILE__)
$: << "#{root_folder}/lib"

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new do |t|
  t.warning = true
  t.spec_opts = ['--options', "\"#{root_folder}/spec/spec.opts\""]
  t.rcov = false
  t.spec_files = FileList['spec/**/*_spec.rb']
end