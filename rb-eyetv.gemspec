# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rb-eyetv}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["dblugeon"]
  s.date = %q{2009-09-07}
  s.description = %q{
      This library provides ruby classes to control the EyeTV Application.
      You can launch the EyeTV apllication, explore recordings, channels or
      programs
    }
  s.email = %q{damienblugeon@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/channel.rb",
     "lib/eyetv.rb",
     "lib/program.rb",
     "lib/recording.rb",
     "rb-eyetv.gemspec",
     "test/eyetv_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/dblugeon/rb-eyetv}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{This library provides ruby classes to control the EyeTV Application}
  s.test_files = [
    "test/eyetv_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<rb-appscript>, ["= 0.5.3"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<rb-appscript>, ["= 0.5.3"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<rb-appscript>, ["= 0.5.3"])
  end
end
