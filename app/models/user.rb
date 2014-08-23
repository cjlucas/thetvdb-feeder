class User < ActiveRecord::Base
  has_and_belongs_to_many :series
  has_many :episodes, through: :series
end
