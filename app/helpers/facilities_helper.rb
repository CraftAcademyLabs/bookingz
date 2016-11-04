module FacilitiesHelper

  def unassigned_users
    users = []
    User.where(superadmin: false).where(facility: nil).each do |user|
      users.push({id: user.id, email: user.email})
    end
    users
  end
end
