# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "project/version"

Gem::Specification.new do |spec|
  spec.name          = "bluepotion"
  spec.authors       = ["InfiniteRed", "ClearSight Studio"]
  spec.email         = ["hello@infinitered.com", "hello@clearsightstudio.com"]
  spec.description   = %q{BluePotion - Just like RedPotion, but for Android}
  spec.summary       = %q{BluePotion - Just like RedPotion, but for Android. The best combination of RubyMotion tools and libraries for Android}
  spec.homepage      = "https://github.com/infinitered/bluepotion"
  spec.license       = "MIT"
  spec.post_install_message = "  <>\n  ||\n (  )  BluePotion\n  ``"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  files.concat(Dir.glob('templates/**/*.rb'))
  spec.files         = files

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.version       = BluePotion::VERSION

  spec.add_development_dependency "rake"
end
