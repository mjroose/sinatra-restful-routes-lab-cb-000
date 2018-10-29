class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get '/recipes/new' do
    erb :new
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
      redirect '/'
    end
  end
end
