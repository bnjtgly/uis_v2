class UserDecorator < Draper::Decorator
  delegate_all

  def complete_name
    "#{first_name} #{last_name}".squish
  end

  def date_of_birth_format
    date_of_birth.try(:strftime, '%Y-%m-%d')
  end

end
