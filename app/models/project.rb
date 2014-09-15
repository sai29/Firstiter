class Project < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC')}
	validates :name, presence: true, length: { maximum:30 }
	validates :tagline, presence: true, length: { maximum:140 }
	validates :description, presence: true, length: { maximum:500 }
	validates :user_id, presence: true
end
