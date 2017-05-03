task default: %w(build push)

task :build do
  Dir.glob("#{File.dirname(__FILE__)}/**/Dockerfile").each do |f|
    build_dir = f.chomp('/Dockerfile')
    no_cache = 'cache=false' if ENV['cache'] == 'false'
    sh "cd #{build_dir}; rake build #{no_cache}"
  end
end

task :push do
  Dir.glob("#{File.dirname(__FILE__)}/**/Dockerfile").each do |f|
    build_dir = f.chomp('/Dockerfile')
    sh "cd #{build_dir}; rake push"
  end
end
