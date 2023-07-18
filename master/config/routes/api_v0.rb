namespace :api do
  namespace :v0 do
    resources :meshes do
      resources :slaves do
        resources :pins
      end
    end
  end
end