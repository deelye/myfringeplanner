class Transition < ApplicationRecord
  belongs_to :planner_to, class_name: 'Planner'
  belongs_to :planner_from, class_nmae: 'Planner'
end
