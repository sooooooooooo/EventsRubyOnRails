class JoinsController < ApplicationController
  def create
  	join = Join.create(user: current_user, event: Event.find(params[:event_id]))
  	if join.valid?
  		redirect_back(fallback_location: events_path)
  	else
  		flash[:errors] = join.errors.full_messages
  		redirect_back(fallback_location: events_path)
  	end
  end

  def destroy
  	join = Join.find(params[:id])
  	join.destroy
  	redirect_back(fallback_location: events_path)
  end
end
