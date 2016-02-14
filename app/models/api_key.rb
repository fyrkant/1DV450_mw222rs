class ApiKey < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user
  before_create :generate_api_key
  scope :search, ->(keyword) { where("name ILIKE ?", "%#{keyword.downcase}%") if keyword.present? }
  scope :filter, ->(email) { joins(:user).where('users.email = ?', email) if email.present? }

  private

  def generate_api_key
    loop do
      self.key = SecureRandom.uuid.delete("-")
      break unless self.class.exists? key: key
    end
  end
end
