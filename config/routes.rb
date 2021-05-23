Rails.application.routes.draw do
  get '/', to: 'application#welcome'
  
  namespace :admin do
    resources :shelters, only: [:index, :show]
  end

  resources :shelters
  # get '/shelters', to: 'shelters#index'
  # get '/shelters/new', to: 'shelters#new'
  # post '/shelters', to: 'shelters#create'
  # get '/shelters/:id', to: 'shelters#show'
  # get '/shelters/:id/edit', to: 'shelters#edit'
  # patch '/shelters/:id', to: 'shelters#update'
  # delete '/shelters/:id', to: 'shelters#destroy'

  resources :pets, except: [:new, :create]
  # get '/pets', to: 'pets#index'
  # get '/pets/:id', to: 'pets#show'
  # get '/pets/:id/edit', to: 'pets#edit'
  # patch '/pets/:id', to: 'pets#update'
  # delete '/pets/:id', to: 'pets#destroy'

  resources :applications, except: [:destroy]
  # get '/applications', to: 'applications#index'
  # get '/applications/new', to: 'applications#new'
  # get '/applications/:id', to: 'applications#show'
  # get '/applications/:id/edit', to: 'applications#edit'
  # patch '/applications/:id', to: 'applications#update'
  # post '/applications', to: 'applications#create'

  patch 'pet_applications/:applications_id/:pet_id', to: 'pet_applications#add_pet'
  
  resources :veterinary_offices 
  # get '/veterinary_offices', to: 'veterinary_offices#index'
  # get '/veterinary_offices/new', to: 'veterinary_offices#new'
  # get '/veterinary_offices/:id', to: 'veterinary_offices#show'
  # post '/veterinary_offices', to: 'veterinary_offices#create'
  # get '/veterinary_offices/:id/edit', to: 'veterinary_offices#edit'
  # patch '/veterinary_offices/:id', to: 'veterinary_offices#update'
  # delete '/veterinary_offices/:id', to: 'veterinary_offices#destroy'

  resources :veterinarians, except: [:create]
  # get '/veterinarians', to: 'veterinarians#index'
  # get '/veterinarians/:id', to: 'veterinarians#show'
  # get '/veterinarians/:id/edit', to: 'veterinarians#edit'
  # patch '/veterinarians/:id', to: 'veterinarians#update'
  # delete '/veterinarians/:id', to: 'veterinarians#destroy'
  
  resources :shelters do
    get '/pets', to: 'shelters#pets'
    resources :pets, only: [:new, :create] 
  end

  # get '/shelters/:shelter_id/pets', to: 'shelters#pets'
  # get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  # post '/shelters/:shelter_id/pets', to: 'pets#create'

  resources :veterinary_offices do
    get '/veterinarians', to: 'veterinary_offices#veterinarians'
    resources :veterinarians, only: [:new, :create] 
  end

  # get '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinary_offices#veterinarians'
  # get '/veterinary_offices/:veterinary_office_id/veterinarians/new', to: 'veterinarians#new'
  # post '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinarians#create'
end
