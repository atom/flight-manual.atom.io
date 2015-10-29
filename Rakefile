require 'html/proofer'

task :default => [:test]

desc "Compile the site"
task :compile do
  `npm run gulp`
end

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

desc "Run the HTML-Proofer"
task :run_proofer do
  require 'html/proofer'
  HTML::Proofer.new("./output").run
end

namespace :book do
  desc 'prepare build'
  task :prebuild do
    Dir.mkdir 'images' unless Dir.exists? 'images'
    Dir.glob("book/*/images/*").each do |image|
      FileUtils.copy(image, "images/" + File.basename(image))
    end
  end

  desc 'build basic book formats'
  task :build => :prebuild do
    puts "Converting to HTML..."
    `bundle exec asciidoctor atom.asc`
    puts " -- HTML output at atom.html"

    puts "Converting to EPub..."
    `bundle exec asciidoctor-epub3 atom.asc`
    puts " -- Epub output at atom.epub"

    puts "Converting to Mobi (kf8)..."
    `bundle exec asciidoctor-epub3 -a ebook-format=kf8 atom.asc`
    puts " -- Mobi output at atom.mobi"

    puts "Converting to PDF... (this one takes a while)"
    `bundle exec asciidoctor-pdf atom.asc 2>/dev/null`
    puts " -- PDF  output at atom.pdf"
  end

  desc 'clean out generated formats'
  task :clean do
    `rm atom.html`
    `rm atom.epub`
    `rm atom-kf8.epub`
    `rm atom.mobi`
    `rm atom.pdf`
    `rm atom.pdfmarks`
  end
end
