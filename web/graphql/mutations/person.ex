require Logger
import RethinkDB.Query, only: [table: 1, get: 2, delete: 1, filter: 2, delete_at: 2, update: 2]
#import GraphQL.Type.List

defmodule App.Mutation.Person do
@idT %{type: %GraphQL.Type.ID{}}
@stringT %{type: %GraphQL.Type.String{}}

# defp resultType do
#     %GraphQL.Type.ObjectType{
#       name: "Result",
#       fields: %{
#         result: %{
#           type: @stringT,
#           args: %{
#              id: @idT
#           }
#         #  , resolve: {Schema.EctoWorld, :greeting}
#       } } }
#   end

  def get do
    %{
      type: %GraphQL.Type.List{ofType: App.Type.Person.get},
      resolve: fn (a, args, b) ->
        #b |> inspect |> Logger.debug
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
        #|> Map.fetch(:data)
        #|> Tuple.to_list
        #|> List.last
        #|> Map.fetch("deleted")
        #|> Tuple.to_list
        #|> List.last
        table("people")
        |> DB.run
        |> DB.handle_graphql_resp
        # Logger.debug("myid: " <> to_string(myid))
        # |> inspect
        # |> filter(%{id: args[:id]})
      end
    }
  end

  def put do
    %{
      type: %GraphQL.Type.List{ofType: App.Type.Person.get},
      resolve: fn (a, args, b) ->
          #b |> inspect |> Logger.debug
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

        myfield = b[:field_asts]
        |> List.first
        |> Map.fetch(:arguments)
        |> Tuple.to_list
        |> List.last
        |> List.last
        |> Map.fetch(:name)
        |> Tuple.to_list
        |> List.last
        |> Map.fetch(:value)
        |> Tuple.to_list
        |> List.last
        |> inspect |> Logger.debug

        myval = b[:field_asts]
        |> List.first
        |> Map.fetch(:arguments)
        |> Tuple.to_list
        |> List.last
        |> List.last
        |> Map.fetch(:value)
        |> Tuple.to_list
        |> List.last
        |> Map.fetch(:value)
        |> Tuple.to_list
        |> List.last

        table("people")
        |> get(myid)
        |> update(%{firstname: myval})
        |> DB.run

        #|> Map.fetch(:data)
        #|> Tuple.to_list
        #|> List.last
        #|> Map.fetch("deleted")
        #|> Tuple.to_list
        #|> List.last
        table("people")
        |> DB.run
        |> DB.handle_graphql_resp
        # Logger.debug("myid: " <> to_string(myid))
        # |> inspect
        # |> filter(%{id: args[:id]})
      end
    }
  end

end

# Exempel:

# mutation PublicMutation
# {
#     updateperson(id: 9, firstname: "Wesson") {
#       firstname
#       lastname
#   }
# }
