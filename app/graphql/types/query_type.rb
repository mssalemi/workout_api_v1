# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    BENCH_PRESS = Exercise.new(
      id: 0,
      title: "Bench Press",
      description: "The bench press is an upper-body weight training exercise in which the trainee presses a weight upwards while lying on a weight training bench.",
      instruction: "XYZ",
      body_part: "Chest",
      created_at: "2020-11-11 00:00:00",
      updated_at: "2020-11-11 00:00:00",
      img_url: "https://www.shutterstock.com/image-illustration/closegrip-barbell-bench-press-3d-260nw-430936051.jpg"
    )

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    # Exercise Query
    ## Field to fetch a single Exercise by ID
    field :exercise, Types::ExerciseType, null: true, description: "Fetches an exercise given its ID." do
      argument :id, ID, required: true, description: "ID of the exercise."
    end

    def exercise(id:)
      return BENCH_PRESS if id == "0"

      Exercise.find_by(id: id)
    end

    ## Field to fetch all Exercises
    field :exercises, [Types::ExerciseType], null: false, description: "Fetches a list of all exercises."
    
    def exercises
      Exercise.all
    end
  end
end
