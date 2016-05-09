alias GraphQL.Type.List
import RethinkDB.Query, only: [table: 1]

defmodule App.Query.Projects do
  def get do
    %{
      type: %List{ofType: App.Type.Project.get},
      resolve: fn (_, _args, _) ->
        table("projects")
        |> DB.run
        |> DB.handle_graphql_resp
      end
    }
  end
end
