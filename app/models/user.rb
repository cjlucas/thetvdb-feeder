class User < ActiveRecord::Base
  before_create :ensure_uuid_exists
  before_create :ensure_ical_settings_exists

  has_and_belongs_to_many :series
  has_many :episodes, through: :series
  has_one :ical_settings

  def ensure_uuid_exists
    self.uuid = SecureRandom.uuid if self.uuid.nil?
  end

  def ensure_ical_settings_exists
    self.ical_settings = IcalSettings.create_with_defaults
  end
end
