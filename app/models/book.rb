class Book < ApplicationRecord
	
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :book
	has_many :book_comments, dependent: :destroy
	
	is_impressionable counter_cache: true

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	
	scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } # 前週
	
	def self.search(search, word)
		if search == "forward_match"
			@book = Book.where("title LIKE?","#{word}%")
		elsif search == "backward_match"
			@book = Book.where("title LIKE?","%#{word}")
		elsif search == "perfect_match"
			@book = Book.where("#{word}")
		elsif search == "partial_match"
			@book = Book.where("title LIKE?","%#{word}%")
		else
			@book = Book.all
		end
	end
	
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
