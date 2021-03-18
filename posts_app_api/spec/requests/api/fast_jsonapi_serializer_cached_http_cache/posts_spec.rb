# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::FastJsonapiSerializerCachedHttpCache::Posts', type: :request do
  include RequestHelpers
  include AuthHelper

  before(:all) do
    @endpoint_path = '/api/fast_jsonapi_serializer_cached_http_cache/posts'
  end

  it_behaves_like 'posts endpoint'
end
