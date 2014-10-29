Rails.application.routes.draw do
  resources :cities, only: [] do
    get :search, on: :collection
  end
end
