class UsersController < ApplicationController
  before_action :authenticate_user!

  def update_rest_time
    user = User.find(params[:id])

    if user == current_user && user.update(rest_time: params[:rest_time])
      render json: { rest_time: user.rest_time }
    else
      render json: { error: "Could not update rest time" }, status: :unprocessable_entity
    end
  end
end
