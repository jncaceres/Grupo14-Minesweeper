# frozen_string_literal: true

require 'rubocop/rake_task'
require 'rake/testtask'

task default: %w[lint test:all]

# task :test do
#   # Añadir archivos de test aqui
#   ruby 'test/model_test.rb'
# end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = true
end

Rake::TestTask.new('test:all') do |t|
  t.libs = ['lib']
  t.warning = true
  t.test_files = FileList['test/**/*_test.rb']
end
