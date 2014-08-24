# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
                                       key: '_thetvdb-feeder_session',
                                       expires_after: 3.months
