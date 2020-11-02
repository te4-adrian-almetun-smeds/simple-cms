# frozen_string_literal: true

require 'dotenv'
require 'sinatra'

require_relative 'modules/dbhandler'

Dotenv.load

# Handles the webserver
class Server < Sinatra::Base
  enable :sessions
end
