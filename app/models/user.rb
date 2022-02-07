class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :books,dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :name, uniqueness: true, length: {minimum: 2,maximum: 20}
  validates :introduction,length: {maximum: 50}

  def self.guest
    find_or_create_by!(name: 'guestuser',email: 'guest@example.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    user.name = "guestuser"
   end
  end


  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
     profile_image
  end
end
