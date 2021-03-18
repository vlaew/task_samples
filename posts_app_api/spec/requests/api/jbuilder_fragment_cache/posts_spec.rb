# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::JbuilderFragmentCache::Posts', type: :request do
  include RequestHelpers
  include AuthHelper

  before(:all) do
    @endpoint_path = '/api/jbuilder_fragment_cache/posts'
  end

  it_behaves_like 'posts endpoint'
end
