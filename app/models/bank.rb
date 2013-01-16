# encoding: utf-8
# author: Boris Barroso
# email: boriscyber@gmail.com
class Bank < Account

  # Relationships
  has_one :money_store, foreign_key: :account_id, autosave: true

  # Delegations
  MONEY_METHODS = [:number, :email, :address, :phone, :website].freeze
  delegate *getters_setters_array(*MONEY_METHODS), to: :money_store
  delegate :id, to: :money_store, prefix: true

  # validations
  validates_presence_of :number
  validates :number, length: {within: 3..30}

  def self.new_bank(attrs={})
    self.new do |c|
      c.build_money_store
      c.attributes = attrs
    end
  end

  def to_s
    "#{name} #{number}"
  end

  private
  def set_defaults
    self.total_amount ||= 0.0
  end
end
