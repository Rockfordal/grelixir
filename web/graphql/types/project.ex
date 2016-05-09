defmodule App.Type.Project do
  @type_string %{type: %GraphQL.Type.String{}}

  def get do
    %GraphQL.Type.ObjectType{
      name: "Project",
      fields: %{
        id: @type_string,
        firstname: @type_string,
        lastname: @type_string,
        username: @type_string,
      }
    }
  end
end
