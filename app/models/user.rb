class User < ApplicationRecord
  acts_as_booker
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :facility
  #after_create :set_admin

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  private

  # def set_admin
  #   if  User.count == 1
  #     User.first.update_attribute(:approved, true)
  #   else
  #     return true
  #   end
  # end
end
