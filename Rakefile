require "rspec/core/rake_task"
require "bundler/gem_tasks"

desc "Starts PRY with gem loaded"
task :pry do
  sh "pry -I lib -r mongoid -r mongoid_bitfield --no-pager"
end

desc "Run all specs"
task RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = false
end

task default: :spec
