# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class ShowsBattingAverageForAllTeamsTest < ApplicationSystemTestCase
  def setup
    AggregatedPlayerStat.refresh
  end

  test 'shows batting_average among all player teams' do
    visit root_path

    fill_in 'Player', with: 'john_doe'
    click_on 'Filter'

    assert_text '0.488'
  end

  test 'shows all player teams names' do
    visit root_path

    fill_in 'Player', with: 'john_doe'
    click_on 'Filter'

    assert_text 'Team A, Team B'
  end
end
