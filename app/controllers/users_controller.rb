class UsersController < ApplicationController
  before_filter :require_admin

  # GET /users
  # GET /users.xml
  def index
    @users = User.order("created_at desc").all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users
  # GET /users.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def complete
    @user = User.find(params[:id])
    @user.completed = @user.completed ? nil : true
    @user.save!

    respond_to do |format|
      format.html { redirect_to :action => :index}
      format.json { head :no_content }
    end
  end

  def make_admin
    @user = User.find(params[:id])
    @user.admin = @user.admin ? false : true
    @user.save!

    respond_to do |format|
      format.html { redirect_to :action => :index}
      format.json { head :no_content }
    end
  end
end