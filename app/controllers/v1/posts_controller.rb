module V1
  class PostsController < ApplicationController
    skip_before_action :authenticate, only: [:index, :show]

    private

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body, :published)
    end

    # Ensure user information is included in the JSON
    # response
    def relationships
      ['user']
    end
  end
end
