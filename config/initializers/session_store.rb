Rails.application.config.session_store :cookie_store,
                                       key: '_scalecart_session',
                                       expire_after: 30.minutes,
                                       secure: Rails.env.production?
