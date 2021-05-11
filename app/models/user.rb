class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :remove_image

  has_many :articles
  has_one_attached :image

  validates :first_name, :last_name, presence: true
  validate :correct_image_type

  private

  def correct_image_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/jpg image/png))
      errors.add(:image, 'extension must be a jpeg or jpg or png format')
    end
  end

  after_save :purge_image, if: :remove_image
  def purge_image
    image.purge_later
  end

end
