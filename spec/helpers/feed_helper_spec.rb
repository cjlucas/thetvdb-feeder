describe FeedHelper, type: :helper do
  it 'should convert airtime string into seconds' do
    time = helper.airtime_to_time('2:01 PM')
    expect(time.hour).to eq(14)
    expect(time.minute).to eq(1)
  end
end