class Question < ApplicationRecord
  has_many :options
  has_many :question_images
end
