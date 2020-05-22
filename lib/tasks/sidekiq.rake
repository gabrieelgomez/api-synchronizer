namespace :sidekiq do
  desc 'Verify if there is Sidekiq Processes and execute them if not'
  task verify_jobs: :environment do
    processes = Sidekiq::ProcessSet.new
    Rails.logger.info '!!!======>> Verifying Jobs'
    Rails.logger.info "!!!======>> Jobs Processes = #{processes.size}"
    if processes.size.zero?
      Rails.logger.info '!!!======>> Restoring Jobs'
      system "bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e #{Rails.env}"
      sleep 5
      Rails.logger.info "!!!======>> Jobs Processes Now = #{processes.size}"
    end
  end
end
