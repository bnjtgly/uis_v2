class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = UserDecorator.decorate_collection(User.all)
  end
end
