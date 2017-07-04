JSONAPI.configure do |config|
  # built in paginators are :none, :offset, :paged
  config.top_level_meta_include_page_count = true
  config.default_paginator = :paged
  config.default_page_size = 10
  config.maximum_page_size = 20
end
