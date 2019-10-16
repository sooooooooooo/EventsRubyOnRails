class CommentsController < ApplicationController
  def create
  	comment = Comment.create(comment: params[:comment], user: current_user, event: Event.find(params[:event_id]))
  	if comment.valid?
  		redirect_back fallback_location: event_path(id: params[:event_id])
  	else
  		flash[:errors] = comment.errors.full_messages
  		redirect_back(fallback_location: event_path(id: params[:event_id]))
  	end
  end
end
