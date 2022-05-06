# frozen_string_literal: true

set :output, 'log/cron_log.log'

every 1.minute do
  rake 'book_management:set_statuses'
end
