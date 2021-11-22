desc "Verify Glimmer Specifications"
task :verify do
  Dir['specification/**/*_specification.rb'].each do |specification_file|
    load specification_file
  end
end
