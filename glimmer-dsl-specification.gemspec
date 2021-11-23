# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: glimmer-dsl-specification 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "glimmer-dsl-specification".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2021-11-23"
  s.description = "Glimmer DSL for Specification - Pure Ruby Declarative Use Case Specification and Automated Verification".freeze
  s.email = "andy.am@gmail.com".freeze
  s.extra_rdoc_files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md",
    "TODO.md",
    "VERSION",
    "glimmer-dsl-specification.gemspec",
    "lib/glimmer-dsl-specification.rb",
    "lib/glimmer/dsl/specification/attribute_expression.rb",
    "lib/glimmer/dsl/specification/block_method_expression.rb",
    "lib/glimmer/dsl/specification/dsl.rb",
    "lib/glimmer/dsl/specification/element_expression.rb",
    "lib/glimmer/specification.rb",
    "lib/glimmer/specification/element.rb",
    "lib/glimmer/specification/element/fact.rb",
    "lib/glimmer/specification/element/scenario.rb",
    "lib/glimmer/specification/element/specification.rb",
    "lib/glimmer/specification/element/use_case.rb",
    "lib/glimmer/specification/rake_tasks.rb"
  ]
  s.homepage = "http://github.com/AndyObtiva/glimmer-dsl-specification".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.31".freeze
  s.summary = "Glimmer DSL for Specification".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<glimmer>.freeze, ["~> 2.5.1"])
    s.add_runtime_dependency(%q<puts_debuggerer>.freeze, ["~> 0.13.1"])
    s.add_runtime_dependency(%q<colours>.freeze, ["~> 0.6.1"])
    s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_development_dependency(%q<rake-tui>.freeze, ["> 0"])
    s.add_development_dependency(%q<glimmer-dsl-specification>.freeze, [">= 0"])
  else
    s.add_dependency(%q<glimmer>.freeze, ["~> 2.5.1"])
    s.add_dependency(%q<puts_debuggerer>.freeze, ["~> 0.13.1"])
    s.add_dependency(%q<colours>.freeze, ["~> 0.6.1"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<rake-tui>.freeze, ["> 0"])
    s.add_dependency(%q<glimmer-dsl-specification>.freeze, [">= 0"])
  end
end

