defmodule BrasilEmDadosWeb.Router do
  use BrasilEmDadosWeb, :router

  import BrasilEmDadosWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BrasilEmDadosWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug :put_root_layout, {BrasilEmDadosWeb.LayoutView, :admin}
  end

  # Other scopes may use custom stacks.
  # scope "/api", BrasilEmDadosWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BrasilEmDadosWeb.Telemetry
    end
  end

  ## Require not authenticated
  scope "/", BrasilEmDadosWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    scope "/admin" do
      get "/register", UserRegistrationController, :new
      post "/register", UserRegistrationController, :create
      get "/log_in", UserSessionController, :new
      post "/log_in", UserSessionController, :create
      get "/reset_password", UserResetPasswordController, :new
      post "/reset_password", UserResetPasswordController, :create
      get "/reset_password/:token", UserResetPasswordController, :edit
      put "/reset_password/:token", UserResetPasswordController, :update
    end
  end

  # Require authenticated
  scope "/", BrasilEmDadosWeb do
    pipe_through [:browser, :require_authenticated_user, :admin]

    scope "/admin" do
      live "/", Admin.DashboardLive.Index, :index

      live "/posts", Admin.PostsLive.Index, :index
      live "/posts/new", Admin.PostsLive.New, :new
      live "/posts/edit/:id", Admin.PostsLive.Edit, :edit

      live "/tags", Admin.TagsLive.Index, :index
      live "/tags/new", Admin.TagsLive.New, :new

      get "/settings", UserSettingsController, :edit
      put "/settings/update_password", UserSettingsController, :update_password
      put "/settings/update_email", UserSettingsController, :update_email
      get "/settings/confirm_email/:token", UserSettingsController, :confirm_email
    end
  end

  scope "/", BrasilEmDadosWeb do
    pipe_through [:browser]

    live "/", PageLive, :index
    live "/blog", BlogLive.Index, :index
    live "/blog/tag/:tag_name", BlogLive.Tag, :tag
    live "/blog/:slug", BlogLive.Show, :show


    scope "/admin" do
      delete "/log_out", UserSessionController, :delete
      get "/confirm", UserConfirmationController, :new
      post "/confirm", UserConfirmationController, :create
      get "/confirm/:token", UserConfirmationController, :confirm
    end
  end
end
