Rails.application.routes.draw do
  root "home#index"

  # auth0 settings
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  get "/sign_out", to: "sessions#destroy"

  # MyPage
  namespace :mypage do
    root to: "users#show"
    post "/:id/switch_school/:sid", to: "users#switch_school", as: :switch_school
    delete "/:id/delete_school/:sid", to: "users#delete_school", as: :delete_school
    resources :users,        only: [:edit, :show, :update]
    resources :notes,        only: [:create, :destroy]
    resources :posts,        only: [:create]
    resources :comments,     only: [:create]
    resources :submissions,  only: [:update]
    resource :consent_forms, only: [:show]   # review => show
    resource :user_consents, only: [:create] # consent => create
    resources :user_consents, only: [:update] # revoke => update
    resources :consent_form_versions, only: [:show]
  end

  # Teacher's Dashboard
  namespace :td do
    patch "/users/approve",  to: "users#approve"
    patch "/users/withdraw", to: "users#withdraw"
    resources :users,      except: [:new, :show]
    resources :lessons,    except: [:new, :show]
    resources :rubrics,    except: [:new, :show]
    resources :meetings,   except: [:new, :show]
    resources :notes,      only: [:destroy, :edit, :update]
    resources :schools,    only: [:show]

    # course checklist
    patch "/todos/:id/toggle",  to: "todos#toggle"
    post "/todos/load_default", to: "todos#load_default"
    resources :todos,      except: [:new, :show]

    # certifications
    post "/certificates/bulk_issue",  to: "certificates#bulk_issue"
    get "/certificates/download_all", to: "certificates#download_all"
    resources :certificates, except: [:new, :show]

    # consent management
    post "/consent_forms/load_default", to: "consent_forms#load_default"
    post "/consent_forms/new_version",  to: "consent_forms#new_version"
    post "/consent_forms/publish",      to: "consent_form_versions#publish"
    resources :consent_forms, only: [:index]
    resources :consent_form_versions, except: [:new, :index, :show]
    resources :consent_items, except: [:new, :index, :show]

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

  # Helper apps
  post "markdown/preview", to: "markdown_previews#show"
end
