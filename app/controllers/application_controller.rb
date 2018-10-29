class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  get '/recipes/:id' do
    if @recipe = Recipe.find(params[:id])
      erb :show
    else
      redirect '/'
    end
  end

  post '/recipes' do
    recipe = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    if recipe.save
      redirect to "/recipes/#{recipe.id}"
    end
  end

  patch '/recipes/:id' do
    if @recipe = Recipe.find(params[:id])
      @recipe[:name] = params[:name]
      @recipe[:ingredients] = params[:ingredients]
      @recipe[:cook_time] = params[:cook_time]
      @recipe.save
    end

    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    if @recipe = Recipe.find(params[:id])
      @recipe.delete
    end

    redirect '/recipes'
  end
end
