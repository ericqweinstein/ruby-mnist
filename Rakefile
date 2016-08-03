#!/usr/bin/env rake

require 'rubocop/rake_task'

desc 'Lint Ruby'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns = %w(server.rb lib/**/*.rb)
  t.fail_on_error = true
end
