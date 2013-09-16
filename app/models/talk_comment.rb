class TalkComment < ActiveRecord::Base
  attr_accessible :content, :user_id, :talk_id
  belongs_to :talk
  belongs_to :user
end
