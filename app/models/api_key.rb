class ApiKey < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user
  before_create :generate_api_key

  private

  def generate_api_key
    loop do
      self.key = SecureRandom.uuid.delete("-")
      break unless self.class.exists? key: key
    end
  end
end
