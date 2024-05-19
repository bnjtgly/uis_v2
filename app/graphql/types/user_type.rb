# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String
    field :last_name, String
    field :date_of_birth, GraphQL::Types::ISO8601DateTime
  end
end
