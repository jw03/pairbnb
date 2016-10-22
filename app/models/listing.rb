class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :available_dates
	has_many :reservations
	mount_uploaders :avatars, AvatarUploader
end
