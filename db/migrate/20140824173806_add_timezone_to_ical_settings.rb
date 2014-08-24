class AddTimezoneToIcalSettings < ActiveRecord::Migration
  def change
    change_table :ical_settings do |t|
      t.string :timezone
      t.boolean :adjust_airtime
    end

    IcalSettings.all.each do |settings|
      settings.timezone = IcalSettings::DEFAULTS[:timezone]
      settings.adjust_airtime = IcalSettings::DEFAULTS[:adjust_airtime]
      settings.save
    end
  end
end
