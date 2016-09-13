-- Utility snippets for use in DataGrip (placeholders prompt for input at run time)

-- Move a talk to a different user
UPDATE talks SET user_id = :USER_ID WHERE id = :TALK_ID;

