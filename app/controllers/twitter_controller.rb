class TwitterController < ApplicationController
  no_authorization!

  def smidig_feed
  	feed = Twitter.user_timeline("smidig")
  	respond_to do |format|
      format.json { render json: feed }
    end
  end
end

