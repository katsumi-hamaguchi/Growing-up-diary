class Goal < ApplicationRecord
	belongs_to :user
	has_many :stacks, dependent: :destroy
end
