class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/user_page"
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty? && !User.all.find {|user| user.username == params[:username]}
      User.create(username: params[:username], email: params[:email], password: params[:password])
      redirect '/user_page'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/user_page'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      @user = user
      session[:user_id] = @user.id

      redirect '/pastries'
    else
      redirect '/login'
    end
  end

  post '/logout' do
    session.destroy
    redirect '/login'
  end

  get '/user_page' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @pastries = @user.pastries
      erb :'users/user_page'
    else
      redirect '/login'
    end
  end
end
