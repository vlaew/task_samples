# frozen_string_literal: true

RSpec.shared_examples 'paginated collection response' do
  it 'returns only 500 posts from 1 page' do
    get @request_path

    posts = parsed_response_body[:data]
    expect(posts.size).to eq(@per_page)
  end

  it 'returns total number of records' do
    get @request_path

    expect(parsed_response_body[:meta][:total_count]).to eq(@total_records)
  end
end
