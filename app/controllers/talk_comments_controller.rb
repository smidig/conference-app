class TalkCommentsController < ApplicationController
   authorize_admin!

  # GET /talk_comments
  # GET /talk_comments.json
  def index
    @talk_comments = TalkComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @talk_comments }
    end
  end

  # GET /talk_comments/1
  # GET /talk_comments/1.json
  def show
    @talk_comment = TalkComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @talk_comment }
    end
  end

  # GET /talk_comments/new
  # GET /talk_comments/new.json
  def new
    @talk_comment = TalkComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @talk_comment }
    end
  end

  # GET /talk_comments/1/edit
  def edit
    @talk_comment = TalkComment.find(params[:id])
  end

  # POST /talk_comments
  # POST /talk_comments.json
  def create
    @talk_comment = TalkComment.new(params[:talk_comment])

    respond_to do |format|
      if @talk_comment.save
        format.html { redirect_to @talk_comment, notice: 'Talk comment was successfully created.' }
        format.json { render json: @talk_comment, status: :created, location: @talk_comment }
      else
        format.html { render action: "new" }
        format.json { render json: @talk_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /talk_comments/1
  # PUT /talk_comments/1.json
  def update
    @talk_comment = TalkComment.find(params[:id])

    respond_to do |format|
      if @talk_comment.update_attributes(params[:talk_comment])
        format.html { redirect_to @talk_comment, notice: 'Talk comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @talk_comment}
      end
    end
  end

  # DELETE /talk_comments/1
  # DELETE /talk_comments/1.json
  def destroy
    @talk_comment = TalkComment.find(params[:id])
    @talk_comment.destroy

    respond_to do |format|
      format.html { redirect_to talk_comments_url }
      format.json { head :no_content }
    end
  end
end
