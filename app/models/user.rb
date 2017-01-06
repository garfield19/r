class User < ApplicationRecord
  acts_as_voter
  #attr_accessor :login
  before_save do
    self.interest.gsub!(/[\[\]\"]/, "") if attribute_present?("interest")
  end
  #mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable ,:confirmable
   has_many :updates, dependent: :destroy
   has_many :messages
   has_many :comments
   has_many :interestgroups
   has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
has_many :following, through: :active_relationships, source: :followed
has_many :followers, through: :passive_relationships, source: :follower

def follow(other)
	active_relationships.create(followed_id: other.id)
	end
def unfollow(other)
	active_relationships.find_by(followed_id: other.id).destroy
end
def following?(other)
	following.include?(other)
end


end
