class OrganizersController < ApplicationController
  def show
    @organizer = User.find(params[:id])
    @organized_events = Event.where(user: @organizer)
                             .includes(feedbacks: { pictures_attachments: :blob })
                             .order(date_time: :desc)
    @recent_photos = []

    # Collect recent photos from feedbacks of organizer's events
    @organized_events.each do |event|
      event.feedbacks.each do |feedback|
        if feedback.pictures.attached?
          feedback.pictures.each do |picture|
            @recent_photos << { picture: picture, event: event }
          end
        end
      end
    end

    # Limit to 12 most recent photos
    @recent_photos = @recent_photos.last(12).reverse

    # Get top reviews (highest rated feedbacks from organizer's events)
    @top_reviews = Feedback.joins(:event)
                          .includes(:user, :event)
                          .where(events: { user_id: @organizer.id })
                          .where("rating >= ?", 4)
                          .order(rating: :desc, created_at: :desc)
                          .limit(5)
  end
end
