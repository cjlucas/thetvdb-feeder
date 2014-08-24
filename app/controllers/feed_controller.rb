class FeedController < ApplicationController
  def ical
    @user = User.where(uuid: params[:uid]).first

    @episodes = []
    @user.episodes
    .includes(:series)
    .where('airdate > ?', DateTime.now).each { |ep| @episodes << ep }

    # render plain: ical.to_ical
    render layout: false
  end

  private
end
