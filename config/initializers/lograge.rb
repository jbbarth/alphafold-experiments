ActiveRecord::Base.logger.level = :info
Rails.application.configure do
  config.log_level = :info
  config.lograge.enabled = true
  config.lograge.keep_original_rails_log = false
end
