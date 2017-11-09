# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )



Rails.application.config.assets.precompile += %w( ride_log.js )
Rails.application.config.assets.precompile += %w( ride_log.css )
Rails.application.config.assets.precompile += %w( .css )
Rails.application.config.assets.precompile += %w( boriscam.js )
Rails.application.config.assets.precompile += %w( boriscam.css )
Rails.application.config.assets.precompile += %w( jquery_ujs.js )
Rails.application.config.assets.precompile += %w( greghome.css )
Rails.application.config.assets.precompile += %w( diary_entry.css )
Rails.application.config.assets.precompile += %w( diary_entry.js )
Rails.application.config.assets.precompile += %w( devise.css )
Rails.application.config.assets.precompile += %w( finances.css )
Rails.application.config.assets.precompile += %w( finances/accounts.css )
Rails.application.config.assets.precompile += %w( ratrace.css )
