# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  def create
    interact = Users::Registration.call(data: params)

    if interact.success?
      super
      @user = User.where(id: current_user.id).first
    else
      render json: { error: interact.error }, status: 422
    end
  end

  private
  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'Success' }, status: :ok
  end

  def register_failed
    render json: { error: [user: 'Something went wrong.'] }
  end
end
