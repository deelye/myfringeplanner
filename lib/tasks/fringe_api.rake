namespace :fringe_api do
  desc "Generate daily stats report"
  task generate: :environment do
    puts "Updating info from api......"
    FringeJob.perform_now
  end
end
