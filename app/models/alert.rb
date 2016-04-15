class Alert < ActiveRecord::Base
    belongs_to :stock
    belongs_to :user
    validates :stock, presence: true
    validates :user, presence: true
end
