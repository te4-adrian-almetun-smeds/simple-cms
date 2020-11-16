# frozen_string_literal: true

require_relative 'database_controller'

# Handles the applications wide management
class Posts < DatabaseController
  set_table :posts
  set_columns :id, :header, :body, :postStatus, :authorId, :blogId, :postParent, :time, :postName

  # rubocop:disable Naming/VariableName
  def initialize(params = {})
    super(params)
    @postName = @postName.gsub(/\W+/, '_').downcase
  end
  # rubocop:enable Naming/VariableName
end
