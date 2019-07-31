# frozen_string_literal: true

require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
    use Rack::Flash
  end

  get '/' do
    if Helpers.is_logged_in?(session)
      redirect to '/menu'
    else
      erb :index
    end
  end
end
