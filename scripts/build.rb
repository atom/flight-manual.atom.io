#! /usr/bin/env ruby

require 'colorize'
require 'atlas-api'

# This script is a shim until Atlas has a post-recieve hook for this. It fetches
#  the current master branch from atom/docs and pushes it to the Atlas repo
#  and triggers a new build.
#
# It requires you to have ATLAS_TOKEN in your ENV and push access to the Atlas
# repository. Generally nobody but the core Atom team will have this information.
# It's just a simple helper script for us.

# fetch from atom/docs
atlas_url = false
github_url = false

remotes = `git remote -v`.split("\n")
remotes.each do |line|
  name, url, type = line.split
  if type == '(push)' && url =~ /git.atlas.oreilly.com/
    atlas_url = url
  end
  if type == '(fetch)' && url =~ /github.com/
    github_url = url
  end
end

if !ENV["ATLAS_TOKEN"]
  puts "You need to export ATLAS_TOKEN".colorize(:red)
  puts "This script is a helper script for the Atom Docs core team to trigger an Atlas build.".colorize(:light_blue)
  puts "If you don't have access to Atlas or don't know what that is, this script is not for you".colorize(:light_blue)
  exit
end

if !(github_url && atlas_url)
  puts "You need a GitHub and an Atlas remote".colorize(:red)
  exit
end

puts "Fetch from GitHub: #{github_url}".colorize(:green)
out = `git fetch #{github_url} master:refs/builds/master 2>&1`
puts out.colorize(:grey) + "\n"

puts "Push to Atlas: #{atlas_url}".colorize(:green)
`git push #{atlas_url} refs/builds/master:refs/heads/master 2>&1`
puts out.colorize(:grey) + "\n"

puts "Triggering new build in Atlas".colorize(:green)
# trigger the build
client = Atlas::Api::Client.new(
  :auth_token => ENV["ATLAS_TOKEN"],
  :api_endpoint => "https://atlas.oreilly.com/api"
)

query = {
  :project => "schacon/atom",
  :formats => "pdf,epub,mobi,html",
  :branch => "master"
}

info = client.create_build(query)
puts "https://atlas.oreilly.com/schacon/atom/builds/#{info['id']}"
