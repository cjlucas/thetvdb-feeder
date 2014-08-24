class Episode < ActiveRecord::Base
  belongs_to :series

  scope :upcoming, -> { where('airdate > ?', Date.today) }
  scope :aired_between, ->(start_date, end_date) do
    where('airdate >= ? and airdate <= ?', start_date, end_date)
  end
end