require_relative 'model_helper'

describe User, :type => :model do
  context 'with a valid user' do
    it 'should save successfully' do
      expect(valid_user).to save_successfully
    end
  end

  context 'when not setting tvdb_id' do
    it 'should save unsuccessfully' do
      expect(User.create).to_not save_successfully
    end
  end

  context 'when creating a new user' do
    it 'should generate a uuid on save' do
      user = valid_user
      user.save

      expect(user.uuid).to_not be_nil
    end

    it 'should create ical settings on save' do
      user = valid_user
      user.save

      expect(user.ical_settings).to_not be_nil
    end
  end

  context 'when accessing episodes' do
    it 'should return all episodes associated with the user' do
      user = valid_user
      series = valid_series

      ep1 = valid_episode(tvdb_id: 1, series: series)
      ep2 = valid_episode(tvdb_id: 2, series: series)

      user.series << series
      [user, series, ep1, ep2].each { |m| m.save }
      expect(user.episodes.to_a.select { |e| e.tvdb_id == 1 }).to_not be_empty
      expect(user.episodes.to_a.select { |e| e.tvdb_id == 2 }).to_not be_empty
    end
  end

  context 'when looking up using User::uuid' do
    it 'should return nil if no user can be found' do
      user = User.uuid('03e5a94d-3af2-4df2-928d-8ce2d5ab78e9')
      expect(user).to be_nil
    end

    it 'should return a user if a matching user is found' do
      uuid = '03e5a94d-3af2-4df2-928d-8ce2d5ab78e9'
      user = valid_user(uuid: uuid)
      user.save

      user = User.uuid(uuid)
      expect(user).to be_a(User)
      expect(user.uuid).to eql(uuid)
    end
  end
end
