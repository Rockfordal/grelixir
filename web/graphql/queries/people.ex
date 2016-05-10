alias GraphQL.Type.List
import RethinkDB.Query, only: [table: 1]

defmodule App.Query.People do
  def get do
    %{
      type: %List{ofType: App.Type.Person.get},
      resolve: fn (_, _args, _) ->
        table("people")
        |> DB.run
        |> DB.handle_graphql_resp
      end
    }
  end
end
