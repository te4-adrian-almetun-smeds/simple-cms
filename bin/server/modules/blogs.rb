# frozen_string_literal: true

require_relative 'database_controller'

# Handles the applications wide management
class Blogs < DatabaseController
  set_table :blogs
  set_columns :id, :name
end
