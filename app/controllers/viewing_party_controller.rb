class ViewingPartyController < ApplicationController
  def new 
    @movie = MoviedbFacade.movie_by_id(params[:movie_id])
    @user  = User.find(params[:user_id])
  end
  
  def create 
    host  = User.find(params[:user_id])
    movie = MoviedbFacade.movie_by_id(params[:movie_id])
    date  = params[:date]
    time  = params[:time]
    dur   = params[:duration]

    if valid_date_time_and_duration?(date, movie.runtime, dur, time)
      party = ViewingParty.create!(date: date, duration: dur, start_time: time)
      UserParty.create!(viewing_party_id: party.id, user_id: host.id, host: true)
      redirect_to discover_user_path(host)
    end
  end

  private 

  def valid_date_time_and_duration?(date, runtime, duration, time)
    fmt_date  = date.to_date.strftime('%m-%d-%Y').to_date
    today     = Date.today.strftime('%m-%d-%Y').to_date
    fmt_time  = time.to_time.strftime('%H:%M')
    right_now = Time.now.strftime('%H:%M')
  
    ((fmt_date > today) && (duration.to_i >= runtime)) || 
    ((fmt_date == today) && (fmt_time > right_now) && (duration.to_i >= runtime))
  end 
end