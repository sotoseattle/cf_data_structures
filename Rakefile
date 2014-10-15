ENV['BENCH'] ||= 'test'

# based on http://crashruby.com/2013/05/10/running-a-minitest-suite/
require 'rake/testtask'

Rake::TestTask.new do |_task|
  $LOAD_PATH.unshift('lib', 'spec')
  Dir.glob('./spec/**/*_spec.rb') { |f| require f }
end
task default: 'test'
