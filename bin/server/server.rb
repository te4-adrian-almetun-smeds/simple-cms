# frozen_string_literal: true

require 'dotenv'
require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/cross_origin'

require_relative 'modules/application_controller'

Dotenv.load

# Handles the webserver
class Server < Sinatra::Base
  register Sinatra::Namespace
  enable :sessions
  enable :cross_origin

  namespace '/api' do
    before do
      content_type :json
      headers 'Access-Control-Allow-Origin' => '*',
      'Access-Control-Allow-Methods' => '*'
    end

    namespace '/blogs' do
      get '/?' do
        Blogs.fetch_all(false).to_json
      end

      post '/?' do
        temp = Blogs.new(JSON.parse(request.body.read))
        temp.save
      end

      get '/:id/?' do
        Blogs.fetch_where({ id: params[:id] }, false).to_json
      end

      put '/:id/?' do
        temp = Blogs.new(params)
        temp.save
      end

      delete '/:id/?' do
        temp = Blogs.fetch_where(id: params[:id])
        temp.delete
      end

      namespace '/:blog_id/posts' do
        get '/?' do
          Posts.fetch_where({ blogId: params[:blog_id] }, false).to_json
        end

        post '/?' do
          temp = Posts.new(JSON.parse(request.body.read))
          temp.save
        end

        get '/:post_name/?' do
          Posts.fetch_where({ postName: params[:pos_name], blogId: params[:blog_id] }, false).to_json
        end

        put '/:post_name/?' do
          # TODO: Get the existing post and update it based on the id
          temp = Posts.new(params)
          temp.save
        end

        delete '/:id/?' do
          temp = Posts.fetch_where(id: params[:id])
          temp.delete
        end
      end
    end

    namespace '/users' do
      get '/?' do
        Users.fetch_all(false).to_json
      end

      post '/?' do
        temp = Users.new(JSON.parse(request.body.read))
        temp.save
      end

      get '/:id/?' do
        Users.fetch_where({ id: params[:id] }, false).to_json
      end

      put '/:id/?' do
        temp = Users.new(params)
        temp.save
      end

      delete '/:id/?' do
        temp = Users.fetch_where(id: params[:id])
        temp.delete
      end
    end
  end
end
