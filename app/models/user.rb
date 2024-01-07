class User < ApplicationRecord

  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "leader_id", dependent: :destroy
  # can change following to leaders
  has_many :following, through: :active_relationships, source: :leader
  has_many :followers, through: :passive_relationships

  def follow(other_user)
    active_relationships.create(leader_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(leader_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
