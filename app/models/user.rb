class User < ActiveRecord::Base
  before_create :ensure_uuid_exists

  has_and_belongs_to_many :series
  has_many :episodes, through: :series

  def ensure_uuid_exists
    self.uuid = SecureRandom.uuid if self.uuid.nil?
  end
end
