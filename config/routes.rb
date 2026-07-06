Rails.application.routes.draw do
  root "home#index"

  # auth0 settings
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  get "/sign_out", to: "sessions#destroy"

  # MyPage
  namespace :mypage do
    root to: "users#show"
    get "/:id/switch_school/:sid", to: "users#switch_school", as: :switch_school
    delete "/:id/delete_school/:sid", to: "users#delete_school", as: :delete_school
    resources :users,       only: [:edit, :show, :update]
    resources :notes,       only: [:create, :destroy]
    resources :posts,       only: [:create]
    resources :comments,    only: [:create]
    resources :submissions, only: [:update]
  end

  # Teacher's Dashboard
  namespace :td do
    resources :users,      only: [:index, :create, :edit, :update]
    get "/users/approve",  to: "users#approve"
    get "/users/withdraw", to: "users#withdraw"
    get "/users/delete",   to: "users#delete"
    resources :lessons,    except: [:new, :show]
    resources :rubrics,    except: [:new, :show]
    resources :meetings,   except: [:new, :show]
    resources :notes,      only: [:destroy, :edit, :update]
    resources :schools,    only: [:show]
    resources :todos,      except: [:new, :show]
    patch "/todos/:id/toggle",  to: "todos#toggle"
    post "/todos/load_default", to: "todos#load_default"
    resources :certificates, except: [:new, :show]
    # get "/certificates/issue/:uid/:sid", to: "certificates#issue",
    #                                      as: :issue_certificate
    # get "/certificates/:id/revoke", to: "certificates#revoke", as: :revoke_certificate
    post "/certificates/bulk_issue",  to: "certificates#bulk_issue"
    get "/certificates/download_all", to: "certificates#download_all"

    namespace :api, { format: "json" } do
      resources :users,    only: [:index]
    end
  end

  # Administration
  namespace :admin do
    get "certificates/index"
    root "projects#index"
    resources :projects, except: [:new, :show]
    resources :schools,  only: [:create, :destroy, :edit, :update]
    resources :users,    only: [:destroy, :edit, :update]
    resources :certificates, only: [:index]
  end

  mount ActionCable.server => "/cable"
end
