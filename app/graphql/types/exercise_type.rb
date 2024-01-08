# frozen_string_literal: true

module Types
  class ExerciseType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :description, String
    field :instruction, String
    field :body_part, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :img_url, String
  end
end
