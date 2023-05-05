class UserDate < ApplicationRecord
  belongs_to :user
  belongs_to :date
end