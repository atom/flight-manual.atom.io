
def temp_memoize(key)
  path = File.join(Dir.pwd, "tmp", key)

  if File.exists?(path)
    File.readlines(path).map(&:strip)
  else
    value = yield

    File.open(path, "w") do |f|
      f.puts(value)
    end

    value
  end
end
