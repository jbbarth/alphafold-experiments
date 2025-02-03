# Specify an alternate logger class:
Delayed.logger = ActiveSupport::Logger.new($stdout)

# Specify a default log level for all job lifecycle logging:
Delayed.default_log_level = 'info'
