class Program < ApplicationRecord
  validates :title, :info,  presence: true
  has_many :discussions, dependent: :destroy
  has_many :relations,dependent: :destroy
  belongs_to :user
end
