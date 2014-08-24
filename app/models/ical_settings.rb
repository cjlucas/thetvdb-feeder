class IcalSettings < ActiveRecord::Base
  DEFAULTS = {
      start_offset: 0,
      end_offset: 0,
      timezone: 'America/New_York',
      adjust_airtime: false,
  }
  belongs_to :user

  def self.create_with_defaults
    create(**DEFAULTS)
  end
end