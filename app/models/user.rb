class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :tasks, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :diary_comments, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  has_many :goals, dependent: :destroy
  has_many :stacks, dependent: :destroy

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def User.search(search, diary_or_user, how_search)
      if how_search == "1"
          User.where(['nickname LIKE ?', "#{search}"])
      elsif how_search == "2"
          User.where(['nickname LIKE ?', "#{search}%"])
      elsif how_search == "3"
          User.where(['nickname LIKE ?', "%#{search}"])
      elsif how_search == "4"
          User.where(['nickname LIKE ?', "%#{search}%"])
      else
          User.all
      end
  end

  def active_for_authentication?
    super && (self.is_deleted == true)   #is_deleted==trueなら（退会したユーザー）を再度ログインできないようにする
  end

  include JpPrefecture
    jp_prefecture :prefecture_code
  
	  def prefecture_name
	    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
	  end
	  
	  def prefecture_name=(prefecture_name)
	    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code 
	  end
  

end
