class Activity < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :distance, numericality: {greater_than: 0}, presence: true
  validates :hours, numericality: { greater_than_or_equal_to: 0 }
  validates :minutes, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 60 }
  validates :seconds, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 60 }, presence: true
  validates :run_at, presence: true
  validates :description, length: { maximum: 140 }
end
