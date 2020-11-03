# frozen_string_literal: true

require_relative 'database_controller'

# Handles the applications wide management
class Users < DatabaseController
  set_table :users
  set_columns :id, :username, :email, :paossword, :register_time, :status
end
