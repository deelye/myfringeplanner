class ShortlistsController < ApplicationController
  def show
    @follows = current_user.all_follows
  end
end
