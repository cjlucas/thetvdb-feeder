require 'rails_helper'

describe FeedHelper, type: :helper do
  it 'should convert airtime string into seconds' do
    secs = helper.airtime_to_secs('2:01 PM')
    expect(secs).to be(50460)
  end
end