class Micropost < ApplicationRecord
  belongs_to :user
  scope :firstest, ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.microposts.content_maximum}
  validate :picture_size

  private

  def picture_size
    if picture.size > Settings.microposts.picture_size.megabytes
      errors.add(:picture, t("microposts.destroy.model"))
    end
  end
end
