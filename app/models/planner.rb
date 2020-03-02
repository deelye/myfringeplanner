class Planner < ApplicationRecord
  belongs_to :user
  belongs_to :show
  has_many :arriving_transitions, class_name: "Transition", foreign_key: :planner_to_id
  has_many :departing_transitions, class_name: 'Transition', foreign_key: :planner_from_id
end
