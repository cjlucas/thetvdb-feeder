class User < ActiveRecord::Base
  before_create :ensure_uuid_exists
  before_create :ensure_ical_settings_exists
  validates_presence_of :tvdb_id

  has_and_belongs_to_many :series
  has_many :episodes, through: :series
  has_one :ical_settings

  def self.uuid(uuid)
    where(uuid: uuid).include_settings.first
  end

  def self.include_settings
    includes(:ical_settings)
  end

  def ensure_uuid_exists
    self.uuid = SecureRandom.uuid if self.uuid.nil?
  end

  def ensure_ical_settings_exists
    self.ical_settings = IcalSettings.create_with_defaults
  end
end
