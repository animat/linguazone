require 'resolv'

class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.transition_from_crypto_providers = Authlogic::CryptoProviders::MD5
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
    c.validate_email_field = false
    c.require_password_confirmation = false
    c.ignore_blank_passwords = true
    c.validate_password_field = false
    c.maintain_sessions = false
  end

  belongs_to :school
  has_many :courses, :through => :course_registration
  has_many :posts
  has_many :comments
  has_many :high_scores
  has_many :study_histories
  has_many :audio_clips
  has_many :authentications, :dependent => :destroy
  belongs_to :subscription
  before_save :set_display_name

  validates_presence_of :first_name, :last_name, :email, :on => :create
  validates_presence_of :password, :if => :password_not_parsed?

  def password_not_parsed?
    !crypted_password?
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    ContactMailer.password_reset_instructions(self).deliver
  end

  def scores_in_game(id)
    HighScore.all(:conditions => ["user_id = ? AND available_game_id = ?", self.id, id])
  end

  def study_history_in_word_list(id)
    StudyHistory.all(:conditions => ["user_id = ? AND available_word_list_id = ?", self.id, id])
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
  
  def apply_omniauth(omniauth)
    unless omniauth['info']['email'].blank?
      self.email = omniauth['info']['email'] if self.email.blank?
    end
    unless omniauth['info']['first_name'].blank?
      self.first_name = omniauth['info']['first_name'] if self.first_name.blank?
    end
    unless omniauth['info']['last_name'].blank?
      self.last_name = omniauth['info']['last_name'] if self.last_name.blank?
    end
    
    if omniauth['info']['first_name'].blank? and omniauth['info']['last_name'].blank? 
      unless omniauth['info']['name'].blank?
        if self.first_name.blank? and self.last_name.blank?
          self.first_name = omniauth['info']['name'].split(" ")[0]
          self.last_name = omniauth['info']['name'].split(" ")[1]
        end 
      end
    end
    
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
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
  
  def has_generic_lz_email?
    (self.email =~ /lz_student_(\d+)@linguazone.com/) != nil
  end
  
  def has_username?
    (self.email =~ /(.*?)@(.*?)/) == nil
  end
  
  def has_personal_email?
    !self.has_username? and !self.has_generic_lz_email?
  end
  
  ROLES = %w[admin teacher student]

  def role_symbols
    [role.to_sym]
  end

  protected
    def set_display_name
      self.display_name = "#{self.first_name} #{self.last_name}"
    end
end
