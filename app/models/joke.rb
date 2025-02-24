class Joke < ApplicationRecord
  validates_presence_of :prompt
  validates_presence_of :secret
  before_validation :generate_secret, on: :create

  has_one_attached :cartoon

  broadcasts_refreshes

  private

  def generate_secret
    self.secret ||= SecureRandom.uuid
  end
end
