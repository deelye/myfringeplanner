class ShortlistsController < ApplicationController
  def show
    @shortlist = current_user.all_follows
  end
end
