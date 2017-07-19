require_relative '../../lib/es'

module EsHelpers
  module ClassMethods
    def destroy_index
      ES::Client.indices.delete(index: ES::INDEX) if ES::Client.indices.exists(index: ES::INDEX)
    end

    def create_index
      ES::Client.indices.create(
        index: ES::INDEX,
        body: {
          mappings: {},
          settings: {
            index: {
              number_of_shards: 1,
              number_of_replicas: 0
            }
          }
        }
      ) unless ES::Client.indices.exists(index: ES::INDEX)
    end

    def create_respondent(id:, answers:, weighting:)
      body = answers.merge({ weighting: weighting })

      ES::Client.create(
        index: :survey,
        type: :respondent,
        id: id,
        refresh: true,
        body: body
      )
    end
  end

  extend ClassMethods
end