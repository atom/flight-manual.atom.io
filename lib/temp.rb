
def temp_exists?(name)
  File.exists?(temp_join(name))
end

def temp_join(name)
  File.join(Dir.pwd, "tmp", name)
end

def temp_memoize(key)
  if temp_exists?(key)
    temp_read(key)
  else
    value = yield

    temp_write(key, value)

    value
  end
end

def temp_read(name)
  File.readlines(temp_join(name))
end

def temp_write(name, value)
  File.open(temp_join(name), "w") do |f|
    f.puts(value)
  end
end
