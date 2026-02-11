# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "textbringer/recentf/version"

Gem::Specification.new do |spec|
  spec.name          = "textbringer-recentf"
  spec.version       = Textbringer::Recentf::VERSION
  spec.authors       = ["Akihiro Kurotani"]
  spec.email         = ["kurod1492@gmail.com"]

  spec.summary       = "Recent file history plugin for Textbringer."
  spec.description   = "Provides Emacs-like recent file history functionality for Textbringer."
  spec.homepage      = "https://github.com/kurod1492/textbringer-recentf"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.2"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "textbringer", ">= 1.4"
  spec.add_runtime_dependency "textbringer-minibuffer-extension", ">= 0.1.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 12.0"
  spec.add_development_dependency "test-unit"
end
