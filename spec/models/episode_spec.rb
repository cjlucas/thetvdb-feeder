require 'rails_helper'

describe Episode, :type => :model do
  context 'when looking up using Episode::upcoming' do
    it 'should not return any matches if episode has aired' do
      valid_episode(airdate: 1.week.ago).save
      expect(Episode.upcoming).to be_empty
    end

    it 'should return matches if an episode airs today' do
      valid_episode(airdate: Date.today).save
      expect(Episode.upcoming.count).to eq(1)
    end

    it 'should return matches if an episode airs in the future' do
      valid_episode(airdate: 1.day.from_now).save
      valid_episode(airdate: 1.year.from_now).save
      expect(Episode.upcoming.count).to eq(2)
    end
  end

  context 'when looking up using Episode::aired_between' do
    it 'should not return any matches if no episodes are in range' do
      valid_episode(airdate: Date.new(2012, 7, 1)).save

      episodes = Episode.aired_between(Date.new(2012, 6, 25),
                                       Date.new(2012, 6, 30))
      expect(episodes.count).to eq(0)

      episodes = Episode.aired_between(Date.new(2012, 7, 2),
                                       Date.new(2012, 7, 9))
      expect(episodes.count).to eq(0)
    end

    it 'should return a match if an episode airs on the start date' do
      valid_episode(airdate: Date.new(2012, 7, 1)).save

      episodes = Episode.aired_between(Date.new(2012, 7, 1),
                                       Date.new(2012, 7, 9))

      expect(episodes.count).to eq(1)
    end

    it 'should return a match if an episode airs on the end date' do
      valid_episode(airdate: Date.new(2012, 7, 1)).save

      episodes = Episode.aired_between(Date.new(2012, 6, 25),
                                       Date.new(2012, 7, 1))

      expect(episodes.count).to eq(1)
    end

    it 'should return a match if an episode airs in between the date bounds' do
      valid_episode(airdate: Date.new(2012, 7, 1)).save

      episodes = Episode.aired_between(Date.new(2012, 6, 1),
                                       Date.new(2012, 8, 1))

      expect(episodes.count).to eq(1)
    end
  end
end
