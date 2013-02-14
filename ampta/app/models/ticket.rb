class Ticket < ActiveRecord::Base
  attr_accessible :description, :name, :status_id, :user_id, :project_id

  validates :description, :presence => true
  validates :name, :presence => true

  belongs_to :project
  belongs_to :user
  belongs_to :status
  
end
