class Episode < ActiveRecord::Base
  belongs_to :series

  scope :upcoming, -> { where('airdate >= ?', Date.today) }
  scope :aired_between, ->(start_date, end_date) do
    where('airdate >= ? AND airdate <= ?',
          start_date.to_date, end_date.to_date)
  end
end