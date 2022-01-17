class Book < ApplicationRecord
  belongs_to :user

  has_one_attached :profile_image
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}




  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end
end
