class Product < ApplicationRecord
  belongs_to :user
  has_many :registers, dependent: :destroy
  has_many_attached :photos
  validates :name, :year, :brand, :model, :status, :price, presence: true
  validates_inclusion_of :status, in: ["New", "Used"]

  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :name, :model, :brand, :operator ],
  using: {
    tsearch: { prefix: true }
  }
end
