task default: %w(build push)

task :build do
  Dir.glob("#{File.dirname(__FILE__)}/**/Dockerfile").each do |f|
    build_dir = f.chomp('/Dockerfile')
    sh "cd #{build_dir}; rake build"
  end
end

task :push do
  Dir.glob("#{File.dirname(__FILE__)}/**/Dockerfile").each do |f|
    build_dir = f.chomp('/Dockerfile')
    sh "cd #{build_dir}; rake push"
  end
end
