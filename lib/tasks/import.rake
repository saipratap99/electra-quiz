require "csv"

namespace :import do
  desc "Imports the participants data"

  task users: :environment do
    file = Rails.root.join("lib/assets/quiz.csv")
    CSV.foreach(file, :headers => true) do |row|
      u = User.create(row.to_hash)
      u.password = "Brainiac@" + u.id.to_s
      u.save!
    end
  end
end
