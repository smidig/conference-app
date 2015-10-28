# -*- encoding : utf-8 -*-
class NametagsController < ApplicationController

  authorize_admin!

  def index
    start_id = params[:start_id] || "0";
    @registrations = User.includes(:ticket).find(:all, :conditions => 'id >= ' +start_id).select{|u| u.ticket.printflag == true}
    @registrations += @registrations if params.has_key? "double"
    @registrations.sort! { |a, b| a.name <=> b.name }

    prawnto :prawn => {
        :page_layout => :portrait,
        :page_size => 'A6',
        :margin=>0 }
  end

  def show
    @registration = User.find(params[:id])

    prawnto :prawn => {
          :page_layout => :portrait,
          :page_size => 'A6',
          :margin => 0 }
  end

end
