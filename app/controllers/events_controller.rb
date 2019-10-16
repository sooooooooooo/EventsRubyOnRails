class EventsController < ApplicationController
  def index
  	@user = User.find(session[:user_id])
  	@event_local = Event.where(state: @user.state)
  	@event_other = Event.where.not(state: @user.state)
  end

  def create
  	event = Event.new(event_params)
  	if event.save
  		redirect_to "/events"
  	else
  		flash[:errors] = event.errors.full_messages
  		redirect_to "/events"
  	end
  end

  def show
  	if Event.exists?(params[:id])
  		@event = Event.find(params[:id])
	  	@joinees = @event.joins
	  	@comments = Comment.where(event_id: params[:id])
  	else
  		redirect_to "/events"
  	end
  end

  def edit
  	@event = Event.find(params[:id])
  end

  def update
  	updated_event = Event.find(params[:id])
  	updated_event.update(name: event_params[:name], date: event_params[:date], location: event_params[:location], state: event_params[:state])
  	if updated_event.valid?
  		flash[:success] = "Successfully updated event"
  		redirect_to "/events"
  	else
  		flash[:errors] = updated_event.errors.full_messages
  		redirect_back fallback_location: edit_event_path(id: updated_event.id)
  	end
  end

  def destroy
  	deleted_event = Event.find(params[:id])
  	deleted_event.destroy
  	redirect_back fallback_location: events_path
  end

  private
  	def event_params
  		params.require(:event).permit(:name, :date, :location, :state).merge(user: current_user)
  	end
end
