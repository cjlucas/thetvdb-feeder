module ApplicationHelper
  def current_user
    @current_user ||= session[:uuid].nil? \
    ? nil : User.where(uuid: session[:uuid]).first
  end

  def ical_start_offset
    container = {
        'a month ago' => (0 - 1.month),
        'a week ago' => (0 - 1.week),
        'now' => 0,
    }
    default = current_user.ical_settings.start_offset
    options_for_select(container, default)
  end

  def ical_end_offset
    container = {
        'a week from now' => 1.week,
        'a month from now' => 1.month,
        'forever' => 5.years.to_i
    }

    default = current_user.ical_settings.end_offset
    options_for_select(container, default)
  end

  def ical_timezone
    options_for_select(TZInfo::Timezone.all_country_zone_identifiers.sort,
                       current_user.ical_settings.timezone)
  end

  def ical_adjust_airtime
    container = {
        'do' => true,
        'do not' => false,
    }
    options_for_select(container, current_user.ical_settings.adjust_airtime)
  end

  def last_scanned_in_words
    user = current_user
    user.scanned_at.nil? \
      ? 'never' : "#{time_ago_in_words(user.scanned_at)} ago"
  end
end
