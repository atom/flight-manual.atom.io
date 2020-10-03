def create_item_with_redirect(source:, destination:)
  content = ''
  attributes = { redirect_to: destination }
  identifier = source

  @items.create(content, attributes, identifier)
end
