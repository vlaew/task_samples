# frozen_string_literal: true

module RequestHelpers
  def parsed_response_body
    JSON.parse(response.body, symbolize_names: true).with_indifferent_access
  end
end
