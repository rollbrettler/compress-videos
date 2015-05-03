task default: %w(syntax rspec rubocop reek)

task :syntax do
  sh 'ruby -c **/*.rb'
end

task :rspec do
  sh 'rspec spec/'
end

task :rubocop do
  sh 'rubocop .'
end

task :reek do
  sh 'reek .'
end
