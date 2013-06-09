class UsersController < ApplicationController
  before_filter :require_admin
  before_filter lambda { @body_class = 'admin' }

  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      format.csv  {
        @filename = "Smidig_deltakere_#{Date.today.to_formatted_s(:db)}.csv"
      }
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
    user = User.find(params[:id])

    user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def edit
    @user = User.find(params[:id])
    @tickets = Ticket.all
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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

  def delete
    @user = User.find(params[:id])
  end
end