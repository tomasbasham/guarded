module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate, only: :create

    private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
