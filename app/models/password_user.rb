class PasswordUser < ApplicationRecord
  belongs_to :password
  belongs_to :user
end
