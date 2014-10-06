class TippedUsersController < ApplicationController
  no_authorization!

  def create
    tipped_user = TippedUser.new params[:tipped_user]

    if tipped_user.save
      SmidigMailer.tip_a_friend(tipped_user.email).deliver

      flash[:success] = "En invitasjon er sendt til din venn"
    else
      flash[:error] = tipped_user.errors[:email].join ", "
    end

    redirect_to root_path :anchor => "flash"
  end
end

