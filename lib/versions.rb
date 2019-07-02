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
    @items
      .find_all('/api/*/*.json')
      .map { |item| File.basename(File.dirname(item.identifier)) }
      .uniq
      .map { |item| Gem::Version.new(item.tr('v', '')) }
      .sort
      .last
      .to_s
  end
end
