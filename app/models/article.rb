class Article < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :articles_categories
  has_many :categories, through: :articles_categories

  validates :title, presence: true
  validates :body, presence: true
  validate :image_type

  private

  def image_type
    images.each do |image|
      unless image.content_type.in?(%w(image/jpeg image/jpg image/png))
        errors.add(:images, 'extension must be jpeg or jpg or png format')
      end
    end
  end

end
