class PastriesController < ApplicationController

  get '/pastries' do
      @pastries = Pastry.all
      erb :'pastries/pastries'
  end

  get '/pastries/new' do
    if logged_in?
      erb :'pastries/new'
    else
      redirect '/login'
    end
  end

  post '/pastries' do
    if params[:ingredients] && params[:kitchenware] && params[:directions] && params[:price_range] && params[:name]
      @pastry = Pastry.create(ingredients: params[:ingredients], kitchenware: params[:kitchenware], directions: params[:directions], price_range: params[:price_range], name: params[:name], user_id: session[:user_id])
      redirect "/pastries/#{@pastry.user.slug}/#{@pastry.slug}"
    else
      redirect '/pastries/new'
    end
  end

  get '/pastries/:userslug/:pastryslug' do
    @user = User.find_by_slug(params[:userslug])
    @pastry = @user.pastries.find_by_slug(params[:pastryslug])
    if @user && @pastry
      erb :'pastries/show'
    else
      redirect '/pastries/new'
    end
  end

  delete '/pastries/:id/delete' do
    @pastry = Pastry.find_by_id(params[:id])

    if logged_in? && @pastry.user_id == session[:user_id]
      @pastry.delete
      redirect '/pastries'
    else
      redirect "/pastries/#{@pastry.user.slug}/#{@pastry.slug}"
    end
  end

  get '/pastries/:userslug/:pastryslug/edit' do
    @user = User.find_by_slug(params[:userslug])
    @pastry = @user.pastries.find_by_slug(params[:pastryslug])

    if @user.id == session[:user_id]
      erb :'pastries/edit'
    else
      redirect "/pastries/#{@user.slug}/#{@pastry.slug}"
    end
  end

  patch '/pastries/:id/edit' do
    @pastry = Pastry.find_by_id(params[:id])

    if logged_in? && @pastry.user_id == session[:user_id]
      @pastry.update(ingredients: params[:ingredients], kitchenware: params[:kitchenware], directions: params[:directions], price_range: params[:price_range], name: params[:name])
      redirect "/pastries/#{@pastry.user.slug}/#{@pastry.slug}"
    else
      redirect "/pastries/#{@pastry.user.slug}/#{@pastry.slug}"
    end

  end
end
