defmodule PicturesWeb.Router do
  use PicturesWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", PicturesWeb do
    pipe_through(:api)
  end
end
