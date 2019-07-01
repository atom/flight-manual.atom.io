require('json')

def latest_atom_version_apis
  items = @items.find_all("/api/v#{latest_atom_version_number}/*.json")
  items.map { |item| JSON.parse(File.read(item.raw_filename)) }
end

def latest_atom_version_class_names
  memoize('latest_atom_version_class_names') do
    @items.
      find_all("/api/v#{latest_atom_version_number}/*.json").
      map { |item| File.basename(item.raw_filename, ".json") }.
      sort
  end
end

def latest_atom_version_number
  memoize('latest_atom_version_number') do
    versions = @items.find_all('/api/*/*.json').map { |item| item.path.split('/')[2] }.uniq

    exploded_version_numbers = versions.map { |version|
      version_without_prefix = version[1..-1]
      version_without_prefix.split('.')
    }

    exploded_version_numbers.sort.last.join('.')
  end
end

def memoize(key)
  if temp_exists?(key)
    temp_read(key)
  else
    value = yield

    temp_write(key, value)

    value
  end
end

def temp_exists?(name)
  File.exists?(File.join(Dir.pwd, "tmp", name))
end

def temp_read(name)
  File.readlines(File.join(Dir.pwd, "tmp", name))
end

def temp_write(name, value)
  File.open(File.join(Dir.pwd, "tmp", name), "w") do |f|
    f.puts(value)
  end
end
