require 'rubygems'
require 'rake/gempackagetask'
require 'rake'
require 'rake/testtask'
require 'lib/netflix/version'

task :default => :test

spec = Gem::Specification.new do |s|
  s.name             = "netflix"
  s.version          = Netflix::Version.to_s
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.markdown)
  s.summary          = "This gem handles some of the complexity in dealing with the netflix api (and OAuth in turn)."
  s.author           = "Rob Ares"
  s.email            = "rob.ares@gmail.com"
  s.homepage         = "http://www.robares.com"
  s.files            = %w(README.markdown Rakefile) + Dir.glob("{lib,test}/**/*")
  s.add_dependency("oauth", ">=0.3.1")
  s.add_dependency("hpricot", ">=0.6")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/*test.rb"]
  t.verbose = true
  t.options = "-v"
end

desc 'Generate the gemspec to serve this Gem from Github'
task :github do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, 'w') {|f| f << spec.to_ruby }
  puts "Created gemspec: #{file}"
end