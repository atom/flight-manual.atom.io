require('json')

def latest_atom_version_apis
  items = @items.find_all("/api/v#{latest_atom_version_number}/*.json")
  items.map { |item| JSON.parse(File.read(item.raw_filename)) }
end

def latest_atom_version_class_names
  temp_memoize('latest_atom_version_class_names') do
    @items
      .find_all("/api/v#{latest_atom_version_number}/*.json")
      .map { |item| File.basename(item.raw_filename, ".json") }
      .sort
  end
end

def latest_atom_version_number
  temp_memoize('latest_atom_version_number') do
    versions = @items.find_all('/api/*/*.json').map { |item| item.path.split('/')[2] }.uniq

    exploded_version_numbers = versions.map { |version|
      version_without_prefix = version[1..-1]
      version_without_prefix.split('.')
    }

    exploded_version_numbers.sort.last.join('.')
  end
end
