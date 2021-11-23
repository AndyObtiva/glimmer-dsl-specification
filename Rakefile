# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "glimmer-dsl-specification"
  gem.homepage = "http://github.com/AndyObtiva/glimmer-dsl-specification"
  gem.license = "MIT"
  gem.summary = %Q{Glimmer DSL for Specification}
  gem.description = %Q{Glimmer DSL for Specification - Pure Ruby Declarative Use Case Specification and Automated Verification}
  gem.email = "andy.am@gmail.com"
  gem.authors = ["Andy Maleh"]
  gem.files = ['README.md', 'TODO.md', 'CHANGELOG.md', 'VERSION', 'LICENSE.txt', 'glimmer-dsl-specification.gemspec', 'lib/**/*']

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new

require 'glimmer/specification/rake_tasks'

task :default => :verify

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "glimmer-dsl-specification #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
