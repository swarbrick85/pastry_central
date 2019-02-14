require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      redirect '/user_page'
    else
      erb :index
    end
  end

  helpers do

    def current_user
      if session[:user_id]
        @current_user = User.find_by(id: session[:user_id])
      end
    end

    def logged_in?
      if current_user
        true
      else
        false
      end
    end
  end
end
