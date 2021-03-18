# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class UserCanFilterByYearTest < ApplicationSystemTestCase
  def setup
    AggregatedPlayerStat.refresh
  end

  test 'user filters by year' do
    visit root_path

    select '2017', from: 'Year'
    click_on 'Filter'

    assert_text '2017'
    assert_no_text '2018'
  end

  test 'user filters by player_id' do
    visit root_path

    fill_in 'Player', with: 'jane_doe'
    click_on 'Filter'

    assert_text 'jane_doe'
    assert_no_text 'john_doe'
  end
end
