class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  validates :name, :year, :brand, :model, :status, :price, presence: true
  validates_inclusion_of :status, in: ["Nuevo", "Usado"]
end
