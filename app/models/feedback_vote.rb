class FeedbackVote < ActiveRecord::Base
  attr_accessible :comment, :vote, :talk_id
  belongs_to :talk
end
