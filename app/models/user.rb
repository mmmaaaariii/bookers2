class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :books, dependent: :destroy

  validates :name,
    uniqueness: true,
    length: { minimum: 2, maximum: 20 }

  validates :introduction,
    length: { maximum: 50 }

end
