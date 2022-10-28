Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get '/applications', to: 'applications#index'
  get '/applications/new', to: 'applications#new'
  get '/applications/:id', to: 'applications#show'
  post '/applications', to: 'applications#create'
  patch 'applications/:id', to: 'applications#update'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/shelters/:id/pets', to: 'shelter_pets#index'
  get '/shelters/:id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:id/pets', to: 'shelter_pets#create'

  get '/admins', to: 'admins#index'
  get '/admins/shelters', to: 'admin_shelters#index'
  get '/admins/applications/:id', to: 'admin_applications#show'
  patch '/admins/applications/:id', to: 'admin_applications#update'
end