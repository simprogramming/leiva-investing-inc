class Position < ApplicationRecord
  belongs_to :wallet
  belongs_to :stock

  validates :size, :entry, presence: true
end
