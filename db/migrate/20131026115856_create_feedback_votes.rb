class CreateFeedbackVotes < ActiveRecord::Migration
  def change
    create_table :feedback_votes do |t|
	  t.references :talk
      t.string :comment
      t.integer :vote

      t.timestamps
    end
  end
end
