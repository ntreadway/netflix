# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{netflix}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Ares", "Pat Reagan"]
  s.date = %q{2008-11-14}
  s.email = %q{rob.ares@gmail.com}
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["README.markdown", "Rakefile", "lib/netflix", "lib/netflix/client.rb", "lib/netflix/user.rb", "lib/netflix/version.rb", "lib/netflix.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/rares/netflix}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{This gem handles some of the complexity in dealing with the netflix api (and OAuth in turn).}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rares-oauth>, [">= 0.2.7"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
    else
      s.add_dependency(%q<rares-oauth>, [">= 0.2.7"])
      s.add_dependency(%q<hpricot>, [">= 0"])  
    end
  else
    s.add_dependency(%q<rares-oauth>, [">= 0.2.7"])
    s.add_dependency(%q<hpricot>, [">= 0"])  
  end
end
