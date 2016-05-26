require Logger
import RethinkDB.Query, only: [table: 1, get: 2, delete: 1, filter: 2, delete_at: 2]

defmodule App.Mutation.Person do
@idT %{type: %GraphQL.Type.ID{}}
@stringT %{type: %GraphQL.Type.String{}}

defp resultType do
    %GraphQL.Type.ObjectType{
      name: "Result",
      fields: %{
        result: %{
          type: @stringT,
          args: %{
            id: @stringT
            # id: @idT
          },
          resolve: {Schema.EctoWorld, :greeting}
        # id: @idT
        # firstname: @stringT
        # lastname: @stringT
        # username: @stringT
        # deleted: @stringT
      }
      }
    }
  end

  def get do
    %{
      type: resultType,
      resolve: fn (a, args, b) ->
        b |> inspect |> Logger.debug
        myid = b[:field_asts]
        |> List.first
        |> Map.fetch(:arguments)
        |> Tuple.to_list
        |> List.last
        |> List.first
        |> Map.fetch(:value)
        |> Tuple.to_list
        |> List.last
        |> Map.fetch(:value)
        |> Tuple.to_list
        |> List.last
        table("people")
        |> get(myid)
        |> delete()
        |> DB.run
        |> DB.handle_graphql_resp
        # Logger.debug("myid: " <> to_string(myid))
        # |> inspect
        # |> filter(%{id: args[:id]})
      end
    }
  end
end
