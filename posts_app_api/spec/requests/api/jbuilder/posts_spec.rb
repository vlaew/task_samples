# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Jbuilder::Posts', type: :request do
  include RequestHelpers
  include AuthHelper

  before(:all) do
    @endpoint_path = '/api/jbuilder/posts'
  end

  it_behaves_like 'posts endpoint'
end
