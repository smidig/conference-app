class TalkCategoriesController < ApplicationController
  before_filter :require_admin

  # GET /talk_categories
  # GET /talk_categories.json
  def index
    @talk_categories = TalkCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @talk_categories }
    end
  end

  # GET /talk_categories/1
  # GET /talk_categories/1.json
  def show
    @talk_category = TalkCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @talk_category }
    end
  end

  # GET /talk_categories/new
  # GET /talk_categories/new.json
  def new
    @talk_category = TalkCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @talk_category }
    end
  end

  # GET /talk_categories/1/edit
  def edit
    @talk_category = TalkCategory.find(params[:id])
  end

  # POST /talk_categories
  # POST /talk_categories.json
  def create
    @talk_category = TalkCategory.new(params[:talk_category])

    respond_to do |format|
      if @talk_category.save
        format.html { redirect_to @talk_category, notice: 'Talk category was successfully created.' }
        format.json { render json: @talk_category, status: :created, location: @talk_category }
      else
        format.html { render action: "new" }
        format.json { render json: @talk_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /talk_categories/1
  # PUT /talk_categories/1.json
  def update
    @talk_category = TalkCategory.find(params[:id])

    respond_to do |format|
      if @talk_category.update_attributes(params[:talk_category])
        format.html { redirect_to @talk_category, notice: 'Talk category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @talk_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talk_categories/1
  # DELETE /talk_categories/1.json
  def destroy
    @talk_category = TalkCategory.find(params[:id])
    @talk_category.destroy

    respond_to do |format|
      format.html { redirect_to talk_categories_url }
      format.json { head :no_content }
    end
  end
end
