class User < ApplicationRecord
  belongs_to :pinned_hopper, class_name: "Hopper", optional: true
  
  has_many :hoppers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def pin(hopper)
    self.pinned_hopper = hopper

    if hopper.pinned_task.nil? && !hopper.tasks.empty?
      hopper.pinned_task = hopper.tasks.sample
    end

    self.show_greeting = false
  end
end
