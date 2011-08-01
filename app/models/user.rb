require 'resolv'

class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.transition_from_crypto_providers = Authlogic::CryptoProviders::MD5
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
    c.validate_email_field = false
    c.require_password_confirmation = false
    c.ignore_blank_passwords = true
    c.validate_password_field = false
  end
  
  belongs_to :school
  has_many :courses, :through => :course_registration
  has_many :posts
  has_many :comments
  has_many :audio_clips
  belongs_to :subscription
  
  validates_presence_of :first_name, :last_name, :email, :password, :on => :create
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    ContactMailer.deliver_password_reset_instructions(self)  
  end
  
  def scores_in_game(id)
    HighScore.all(:conditions => ["user_id = ? AND game_id = ?", self.id, id])
  end
  
  def study_history_in_word_list(id)
    StudyHistory.all(:conditions => ["user_id = ? AND word_list_id = ?", self.id, id])
  end
  
  def is_teacher?
    self.role == "teacher"
  end
  
  def is_premium_subscriber?
    if self.role == "teacher"
      self.subscription.subscription_plan.name == "premium" or self.subscription.subscription_plan.name == "trial"
    elsif self.role == "admin"
      true
    else
      false
    end
  end
  
  def self.is_valid_email_domain(addr)
    if addr.nil?
      false
    else
      domain = addr.match(/\@(.+)/)[1]
      Resolv::DNS.open do |dns|
          @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      end
      @mx.size > 0 ? true : false
    end
  end
  
  def self.is_email_in_use(addr)
    @results = User.all(:conditions => ["email = ?", addr])
    @results.length > 0
  end
  
  ROLES = %w[admin teacher student]
  
  def role_symbols
    [role.to_sym]
  end
end
