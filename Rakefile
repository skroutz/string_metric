require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

if RUBY_ENGINE == "ruby"
  require "rake/extensiontask"

  gem_name = "string_metric"
  dir = "#{gem_name}/levenshtein"
  spec = Gem::Specification.load("#{gem_name}.gemspec")

  Rake::ExtensionTask.new do |ext|
    ext.name = "trie_radix_tree_ext"
    ext.ext_dir = "ext/#{dir}"
    ext.lib_dir = "lib/#{dir}"
    ext.gem_spec = spec
  end

  task :default do
    Rake::Task["compile"].invoke
    Rake::Task["spec"].invoke
  end
else
  task default: :spec
end

