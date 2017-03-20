module FacilitiesHelper

  def unassigned_users_select_options
    User.where(superadmin: false).where(facility: nil).collect {|p| [ p[:email], p[:id] ] }
  end
end
