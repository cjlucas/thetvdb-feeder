require 'icalendar'

module ActionView
  module Template::Handler
    class Caliber
      def self.call(template)
        'ical = Icalendar::Calendar.new;' +
        template.source + '; ical.to_ical'
      end

      def supports_streaming?
        false
      end
    end # Caliber
  end # Handler

  Template.register_template_handler :caliber, Template::Handler::Caliber
end # ActionView

