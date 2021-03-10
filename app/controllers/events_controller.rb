class EventsController < ApplicationController

    before_action :set_event, only: [:show, :destroy, :edit, :update]
    
    def index
        @event = Event.new
            if params[:event] && params[:event][:category_ids] 
                @events = @current_user.upcoming_five_events.select{|event| event.category_ids.include?(params[:event][:category_ids].to_i) }
            else
                @events = @current_user.upcoming_five_events
            end
        @all_events = @current_user.events
      
    end

    def create
        event = @current_user.events.create(event_params)
        EventCategory.create(event: event, category_id: params[:event][:category_ids])
        redirect_to event_path(event)
    end

    def show
        @event_category = EventCategory.new
        @categories = Category.all
        flash[:event_id] = @event.id
        @events = @current_user.events

    end
    
    def edit 
    end

    def update 
       
        # event = @current_user.events.update(event_params)
        # EventCategory.update(event: @event, category_id: params[:event][:category_ids])
        # redirect_to event_path(event)
        
        # alternative solution
        # EventCategory.update(event: @event, category_id: params[:event][:category_ids])
        @event = Event.find(params[:id])
        @event.update(event_params)
        redirect_to event_path(@event)
    end

    def destroy 
        @event.destroy 
        redirect_to events_path
    end
    
    private

    def set_event
        @event = @current_user.events.find(params[:id])
    end
     
    def event_params
        params.require(:event).permit(:title, :description, :address, :date)
    end  

end
