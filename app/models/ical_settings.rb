class IcalSettings < ActiveRecord::Base
  belongs_to :user

  def self.create_with_defaults
    user = new(start_offset: 0, end_offset: 0)
  end
end