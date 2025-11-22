class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @topics = Topic.all
    # @topics = [
    #   OpenStruct.new( description: "The language that borrowed from everyone, forgot to return it, and now makes the rules up as it goes.", badge: "English", image_class: "bg-topic-1"),
    #   OpenStruct.new( description: "Even their sarcasm sounds like it’s been aged in oak barrels and served with cheese.", badge: "Français", image_class: "bg-topic-2"),
    #   OpenStruct.new( description: "Passionate, rhythmic, and always ready to dance. Rolls their R’s like maracas.", badge: "Español", image_class: "bg-topic-3"),
    #   OpenStruct.new( description: "Polite, precise, and secretly a pun master. Brings origami and philosophical haikus.", badge: "Japanese", image_class: "bg-topic-4"),
    #   OpenStruct.new( description: "Speaks with their hands, sings their sentences, and turns every conversation into an opera.", badge: "Italiano", image_class: "bg-topic-5"),
    #   OpenStruct.new( description: "Consonant gymnastics. Can say “przyszczyna” without blinking.", badge: "Polski", image_class: "bg-topic-6")
    # ]
    # @events = Event.all
  end
end
