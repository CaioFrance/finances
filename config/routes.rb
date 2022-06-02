Rails.application.routes.draw do
  get '/import_file', to: 'import_file#index'
  post '/import_file', to: 'import_file#import'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
