# frozen_string_literal: true

class Users::RegistrationValidator
  include Helper::BasicHelper
  include ActiveModel::API

  attr_accessor(
    :email,
    :password,
    :password_confirmation,
    :first_name,
    :last_name,
    :date_of_birth
  )

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_confirmation_of :password
  validate :required, :email_exist, :password_requirements, :valid_dob

  def submit
    persist!
  end

  private

  def persist!
    return true if valid?

    false
  end

  def required
    errors.add(:email, REQUIRED_MESSAGE) if email.blank?
    errors.add(:password, REQUIRED_MESSAGE) if password.blank?
    errors.add(:password_confirmation, REQUIRED_MESSAGE) if password_confirmation.blank?
    errors.add(:first_name, REQUIRED_MESSAGE) if first_name.blank?
    errors.add(:last_name, REQUIRED_MESSAGE) if last_name.blank?
    errors.add(:date_of_birth, REQUIRED_MESSAGE) if date_of_birth.blank?
  end

  def password_requirements
    return if password.blank? || password =~ /\A(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x

    errors.add(:password, PASSWORD_REQUIREMENTS)
  end

  def email_exist
    errors.add(:email, EMAIL_EXISTS) if User.exists?(email: email.try(:downcase).try(:strip))
  end

  def valid_dob
    errors.add(:date_of_birth, INVALID_DOB) unless valid_date?(date_of_birth)
  end
end