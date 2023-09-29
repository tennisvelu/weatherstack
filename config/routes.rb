Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'forecasts#index'
  resources :forecasts do
    collection do
      get :detail_page
    end
  end    
end
