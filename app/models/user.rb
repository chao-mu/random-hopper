class User < ApplicationRecord
  belongs_to :pinned_hopper, class_name: "Hopper", optional: true
  
  has_many :hoppers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.last_seen(start)
    User.where("last_seen_at > ?", start)
  end
end
