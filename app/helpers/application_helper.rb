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
    default = 0
    options_for_select(container, default)
  end

  def ical_end_offset
    container = {
        'a week from now' => 1.week,
        'a month from now' => 1.month,
        'forever' => 5.years
    }

    default = 0
    options_for_select(container, default)
  end

  def ical_apperance_options
    container = {

    }
  end
end
