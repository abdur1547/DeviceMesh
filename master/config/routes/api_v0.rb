namespace :api do
  namespace :v0 do
    post "/login", to: "authentication#login"
    post "/signup", to: "authentication#signup"
    resource :session, only: :create
    resources :meshes do
      resources :slaves do
        resources :pins
      end
    end
  end
end