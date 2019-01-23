defmodule PicturesWeb.Router do
  use PicturesWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/graphql" do
    pipe_through(:api)

    forward("/", Absinthe.Plug, schema: PicturesWeb.Schema)
  end

  scope "/graphiql" do
    pipe_through(:api)

    forward(
      "/",
      Absinthe.Plug.GraphiQL,
      schema: PicturesWeb.Schema,
      interface: :playground
    )
  end
end
