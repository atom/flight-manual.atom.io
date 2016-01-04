require 'html/proofer'

task :default => [:test]

desc "Remove the tmp dir"
task :remove_tmp_dir do
  FileUtils.rm_r('tmp') if File.exist?('tmp')
end

desc "Remove the output dir"
task :remove_output_dir do
  FileUtils.rm_r('output') if File.exist?('output')
end

desc 'Builds the site'
task :build do
  if ENV['RACK_ENV'] == 'test'
    begin
      sh 'node_modules/gulp/bin/gulp.js build > build.txt'
    rescue StandardError => e
      puts 'uh oh'
      $stderr.puts `cat build.txt`
      raise e
    end
  else
    sh 'node_modules/gulp/bin/gulp.js build'
  end
end

desc "Test the output"
task :test => [:remove_tmp_dir, :remove_output_dir, :build] do
  Rake::Task['run_proofer'].invoke
end

desc "Run the HTML-Proofer"
task :run_proofer do
  require 'html/proofer'
  HTML::Proofer.new("./output").run
end
