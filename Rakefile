require "find"
require 'fileutils'
require 'json'
require 'open3'
require 'open-uri'

task :default => [:test]

task :download_api_json_files do
  FileUtils.mkdir_p('data/apis-by-version')

  tags = %w[v1.0.0 v1.0.1 v1.0.2 v1.0.3 v1.0.4 v1.0.5 v1.0.6 v1.0.7 v1.0.8 v1.0.9 v1.0.10 v1.0.11 v1.0.12 v1.0.13 v1.0.14 v1.0.15 v1.0.16 v1.0.17 v1.0.18 v1.0.19 v1.1.0 v1.2.0 v1.2.1 v1.2.2 v1.2.3 v1.2.4 v1.3.0 v1.3.1 v1.3.2 v1.3.3 v1.4.0 v1.4.1 v1.4.2 v1.4.3 v1.5.0 v1.5.1 v1.5.2 v1.5.3 v1.5.4 v1.6.0 v1.6.1 v1.6.2 v1.7.0 v1.7.1 v1.7.2 v1.7.3 v1.7.4 v1.8.0 v1.9.0 v1.9.1 v1.9.2 v1.9.3 v1.9.4 v1.9.5 v1.9.6 v1.9.7 v1.9.8 v1.9.9 v1.10.0 v1.10.1 v1.10.2 v1.11.0 v1.11.1 v1.11.2 v1.12.0 v1.12.1 v1.12.2 v1.12.3 v1.12.4 v1.12.5 v1.12.6 v1.12.7 v1.12.8 v1.12.9 v1.13.0 v1.13.1 v1.14.0 v1.14.1 v1.14.2 v1.14.3 v1.14.4 v1.15.0 v1.16.0 v1.17.0 v1.17.1 v1.17.2 v1.18.0 v1.19.0 v1.19.1 v1.19.2 v1.19.3 v1.19.4 v1.19.5 v1.19.6 v1.19.7 v1.20.0 v1.20.1 v1.21.0 v1.21.1 v1.21.2 v1.22.0 v1.22.1 v1.23.0 v1.23.1 v1.23.2 v1.23.3 v1.24.0 v1.24.1 v1.25.0 v1.25.1 v1.26.0 v1.26.1 v1.27.0 v1.27.1 v1.27.2 v1.28.0 v1.28.1 v1.28.2 v1.29.0 v1.30.0 v1.31.0 v1.31.1 v1.31.2 v1.32.0 v1.32.1 v1.32.2 v1.33.0 v1.33.1 v1.34.0 v1.35.0 v1.35.1 v1.36.0 v1.36.1 v1.37.0 v1.38.0 v1.38.1 v1.38.2]

  tags.each do |tag_name|
    puts "Downloading #{tag_name}"
    File.open("data/apis-by-version/#{tag_name}.json", 'w') do |output_file|
      json = "https://github.com/atom/atom/releases/download/#{tag_name}/atom-api.json"
      open(json, 'r') do |read_file|
        output_file.write(read_file.read)
      end
    end
  end
end

task :split_api_json do
  json_files = Dir.glob('content/api/**/atom-api.json')

  json_files.each do |file|
    classes = JSON.parse(IO.read(file))
    dir = File.dirname(file)

    classes['classes'].each do |key, value|
      File.write(File.join(dir, "#{key}.json"), JSON.pretty_generate(value))
    end

    File.unlink(file)
  end
end

task :clean_api do
  FileUtils.rm_rf('content/api')
end

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
  Bundler.with_clean_env do
    Open3.popen3('npm run gulp build') do |_, stdout, stderr, wait_thr|
      puts stdout.read
      status = wait_thr.value
      abort stderr.read unless status.success?
    end
  end
end

desc "Run the HTML-Proofer"
task :run_proofer do
  require 'html-proofer'

  # Ignore platform switcher hash URLs
  platform_hash_urls = ['#platform-mac', '#platform-windows', '#platform-linux', '#platform-all']
  HTMLProofer.check_directory("./output", {
    :url_ignore => platform_hash_urls,
    :typhoeus => { :ssl_verifypeer => false }
  }).run
end

# Detects instances of Issue #204
desc "Validate article titles match file name and header"
task :validate_article_titles do
  require "colorize"
  require_relative "./lib/tasks/validate_article_title"

  pass = true

  Find.find('./content') do |path|
    if path =~ /sections.*\.md$/
      validate = ValidateArticleTitle.new(path).all

      unless validate.errors.empty?
        pass = false
        validate.errors.each { |error| puts "#{error}".red }
      end
    end
  end

  raise "Validate article titles failed" unless pass
end

desc "Test the output"
task :test => [:validate_article_titles, :remove_tmp_dir, :remove_output_dir, :build, :run_proofer]

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
  require "shellwords"

  message = commit_message(args[:no_commit_msg])

  system "git add -f output/"
  tree = `git write-tree --prefix=output`.chomp
  commit = `echo #{message.shellescape} | git commit-tree #{tree} -p gh-pages`.chomp
  system "git update-ref refs/heads/gh-pages #{commit}"
  system 'git push origin gh-pages --force'
  system 'git reset'
end
