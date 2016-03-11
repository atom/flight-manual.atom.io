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

# Prompt user for a commit message; default: P U B L I S H :emoji:
def commit_message(no_commit_msg = false)
  publish_emojis = [':boom:', ':rocket:', ':metal:', ':bulb:', ':zap:',
    ':sailboat:', ':gift:', ':ship:', ':shipit:', ':sparkles:', ':rainbow:']
  default_message = "P U B L I S H #{publish_emojis.sample}"

  unless no_commit_msg
    print "Enter a commit message (default: '#{default_message}'): "
    STDOUT.flush
    mesg = STDIN.gets.chomp.strip
  end

  mesg = default_message if mesg.nil? || mesg == ''
  mesg << "\nGenerated from #{ENV['BUILD_SHA']}" if ENV['BUILD_SHA']
  mesg.delete("'") # Allow this to be handed off via -m '#{message}'
end

desc 'Publish to https://flight-manual.atom.io'
task :publish, [:no_commit_msg] => [:remove_tmp_dir, :remove_output_dir, :build] do |_, args|
  message = commit_message(args[:no_commit_msg])

  system "git add -f output/"
  tree = `git write-tree --prefix=output`.chomp
  commit = `echo #{message.shellescape} | git commit-tree #{tree} -p gh-pages`.chomp
  system "git update-ref refs/heads/gh-pages #{commit}"
  system 'git push origin gh-pages --force'
  system 'git reset'
end
