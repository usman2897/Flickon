class Feedback < ApplicationRecord
    belongs_to :user
    self.primary_keys = :user_id,:time_date
end
