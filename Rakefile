# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[lint test]

task :test do
  # Añadir archivos de test aqui
  ruby 'test/model_test.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = true
end
