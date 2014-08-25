require 'rails_helper'

describe FeedHelper, type: :helper do
  it 'should convert airtime string into seconds' do
    secs = helper.airtime_to_secs('2:01 PM')
    expect(secs).to be(50460)
  end

  it 'should return a valid start time for an episode' do
    series = valid_series(airtime: '8:00 PM')
    episode = valid_episode(airdate: Date.new(1988, 11, 7), series: series)
    time = helper.episode_start_time(episode)

    expect(time).to be_a(Time)
    expect(time).to eql(Time.new(1988, 11, 7, 20, 0, 0))
  end

  it 'should return a valid end time for an episode' do
    series = valid_series(airtime: '8:00 PM', runtime: 60)
    episode = valid_episode(airdate: Date.new(1988, 11, 7), series: series)
    time = helper.episode_end_time(episode)

    expect(time).to be_a(Time)
    expect(time).to eql(Time.new(1988, 11, 7, 21, 0, 0))
  end
end