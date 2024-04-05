require_relative "lib/transliteration/version"

Gem::Specification.new do |spec|
  spec.name        = "transliteration"
  spec.version     = Transliteration::VERSION
  spec.authors     = ["Jane-Terziev"]
  spec.email       = ["janeterziev@gmail.com"]
  spec.homepage    = "https://github.com/Jane-Terziev"
  spec.summary     = "Summary of Transliteration."
  spec.description = "Description of Transliteration."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Jane-Terziev"
  spec.metadata["changelog_uri"] = "https://github.com/Jane-Terziev"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.3.2"
  spec.add_dependency "twitter_cldr"
  spec.add_dependency "interactor"
  spec.add_dependency "dry-struct"
  spec.add_dependency "dry-validation"
  spec.add_development_dependency "rspec-rails", '~> 6.1.0'
  spec.add_development_dependency "factory_bot_rails"
end
