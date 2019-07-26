require('json')

def atom_version_apis(version)
  items = @items.find_all("/api/v#{version}/*.json")
  items.map { |item| JSON.parse(File.read(item.raw_filename)) }
end

def atom_version_class_names(version)
  temp_memoize("atom_#{version}_class_names") do
    @items
      .find_all("/api/v#{version}/*.json")
      .map { |item| File.basename(item.raw_filename, ".json") }
      .sort
  end
end

def latest_atom_version_number
  atom_versions.last.to_s
end

def atom_versions
  temp_memoize('atom_versions') do
    @items
      .find_all('/api/*/*.json')
      .map { |item| File.basename(File.dirname(item.identifier)) }
      .uniq
      .map { |item| Gem::Version.new(item.tr('v', '')) }
      .sort
  end
end
