class Wallet < ApplicationRecord
  belongs_to :user
  has_many :positions, dependent: :destroy

  validates :name, presence: true
end
