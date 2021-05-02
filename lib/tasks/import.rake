require "csv"

namespace :import do
  desc "Imports the participants data"

  task users: :environment do
    file = Rails.root.join("lib/assets/brainiac.csv")
    CSV.foreach(file, :headers => true) do |row|
      User.create(row.to_hash)
    end
  end
end
