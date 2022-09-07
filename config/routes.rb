Rails.application.routes.draw do
  get '/', to: 'application#welcome'
  
  get '/apps/', to: 'apps#index'
  get '/admin/shelters', to: 'shelters#admin_index'
  get '/admin/apps/:id', to: 'apps#admin_show'
  patch '/admin/apps/:id', to: 'app_pets#update'
  get '/shelters/:id/apps/new', to: 'apps#new'
  post '/apps/:id', to: 'apps#create'
  get '/apps/:id', to: 'apps#show'
  get '/apps/:id/search', to: 'apps#search'
  patch '/apps/:id', to: 'apps#update'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get 'admin/shelters/:id', to: 'shelters#admin_show'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:shelter_id/pets', to: 'shelters#pets'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
end
