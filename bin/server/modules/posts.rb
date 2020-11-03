# frozen_string_literal: true

require_relative 'database_controller'

# Handles the applications wide management
class Posts < DatabaseController
  set_table :posts
  set_columns :id, :header, :body, :post_status, :author_id, :blog_id, :post_parent, :unix_time, :post_name
end
