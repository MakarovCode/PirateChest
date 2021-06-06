
Rails.application.routes.draw do

    root 'treasure/folders#index'

    devise_for :users
    namespace :treasure do
        namespace :api, format: :json do
            namespace :v1 do
                resources :users, only: [:index]
                resources :folders, except: [:show, :new, :edit] do
                    resources :passwords, except: [:show, :new, :edit]
                end
            end
        end

        resources :folders, only: [:index]
    end

end
