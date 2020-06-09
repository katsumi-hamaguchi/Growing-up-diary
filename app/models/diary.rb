class Diary < ApplicationRecord
	belongs_to :user
	attachment :image
     has_many :diary_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    def Diary.search(search, diary, how_search)
	    if how_search == "1"
	        Diary.where(['title LIKE ?', "#{search}"])
	    elsif how_search == "2"
	        Diary.where(['title LIKE ?', "#{search}%"])
	    elsif how_search == "3"
	        Diary.where(['title LIKE ?', "%#{search}"])
	    elsif how_search == "4"
	        Diary.where(['title LIKE ?', "%#{search}%"])
	    else
	        Diary.all
	    end
    end

    def Diary.search(search, diary_or_user, how_search)
	    if how_search == "1"
	        Diary.where(['title LIKE ?', "#{search}"])
	    elsif how_search == "2"
	        Diary.where(['title LIKE ?', "#{search}%"])
	    elsif how_search == "3"
	        Diary.where(['title LIKE ?', "%#{search}"])
	    elsif how_search == "4"
	        Diary.where(['title LIKE ?', "%#{search}%"])
	    else
	        Diary.all
	    end
    end

end
