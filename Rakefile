require "bundler/setup"
require "rspec"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

Bundler::GemHelper.install_tasks

task default: :spec
