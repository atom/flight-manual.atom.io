require 'html/proofer'

task :default => [:test]

desc "Test the output"
task :test => [:remove_tmp_dir, :remove_output_dir, :compile, :run_proofer]

desc "Remove the tmp dir"
task :remove_tmp_dir do
  FileUtils.rm_r('tmp') if File.exist?('tmp')
end

desc "Remove the output dir"
task :remove_output_dir do
  FileUtils.rm_r('output') if File.exist?('output')
end

desc "Compile the site"
task :compile do
  puts `npm run compile`
end

desc "Run the HTML-Proofer"
task :run_proofer do
  require 'html/proofer'
  HTML::Proofer.new("./output").run
end
