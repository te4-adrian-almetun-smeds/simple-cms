# frozen_string_literal: true

require 'dotenv'
require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/cross_origin'

Dotenv.load

# Handles the webserver
# rubocop:disable Metrics/BlockLength
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

    options '/*' do
      halt 200
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
        temp.first.delete
      end

      namespace '/:blog_id/posts' do
        get '/?' do
          Posts.fetch_where({ blogId: params[:blog_id] }, false).to_json
        end

        post '/?' do
          temp = Posts.new(JSON.parse(request.body.read))
          temp.save
          body temp.id.to_s
          status 200
        end

        get '/:post_name/?' do
          Posts.fetch_where({ postName: params[:post_name], blogId: params[:blog_id] }, false).to_json
        end

        put '/:post_name/?' do
          x = JSON.parse(request.body.read)
          old = Posts.fetch_where({ postName: params["post_name"], blogId: params["blog_id"] }, true)
          temp = Posts.new(x)
          temp.id = old.first.id
          temp.save
          halt 200
        end

        delete '/:post_name/?' do
          temp = Posts.fetch_where({ postName: params[:post_name] })
          temp.first.delete
          halt 200
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
        temp.first.delete
      end
    end
    get '/endpoints/?' do
      File.read('./static/endpoints.txt')
    rescue StandardError
      'Unable to fetch endpoints, please try again.'
    end
  end
end
# rubocop:enable Metrics/BlockLength
