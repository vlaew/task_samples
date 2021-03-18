# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  include RequestHelpers
  include AuthHelper

  before(:all) do
    @endpoint_path = '/api/v1/posts'
  end

  it_behaves_like 'posts endpoint'
end
