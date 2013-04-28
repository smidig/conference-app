# encoding: UTF-8
module UsersHelper

def admin_toggle_confirm_msg(user)
  if(user.admin)
    "Er du sikker på at du vil fjerne '#{user.name}' sin admin-rettighet?"
  else
    "Er du sikker på at du vil gjøre '#{user.name}' til admin?"
  end
 end

end