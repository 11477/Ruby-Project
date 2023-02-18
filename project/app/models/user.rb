class User < ApplicationRecord
  has_many :relations ,dependent: :destroy
  has_many :programs ,dependent: :destroy
end
