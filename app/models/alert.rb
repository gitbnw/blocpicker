class Alert < ActiveRecord::Base
  belongs_to :stock
  belongs_to :user
  validates :stock, presence: true
  validates :user, presence: true
  validate :target_initial_fields_are_not_equal

  scope :active, -> { where(active: true) }
  scope :expired, -> { where("expire < ?", Time.zone.now) }
  scope :active_expired, -> {active.expired}
  scope :above_price_triggered, -> {where("stock.lasttradeonly >= price_target")}# compare initial price with last trade
  scope :below_price_triggered, -> {where("")}


  def target_initial_fields_are_not_equal
    self.errors.add(:base, 'Initial price and target price cannot be equal.') if self.price_target == self.price_initial
  end
end
