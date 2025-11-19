class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @topics = [
      OpenStruct.new(title: "Topic 1", description: "The language that borrowed from everyone, forgot to return it, and now makes the rules up as it goes.", badge: "English", image_class: "bg-topic-1"),
      OpenStruct.new(title: "Topic 2", description: "La langue de l’amour, des croissants, et de l’élégance — même quand on commande juste du fromage.", badge: "Français", image_class: "bg-topic-2"),
      OpenStruct.new(title: "Topic 3", description: "Rápido, ardiente y lleno de estilo — como bailar salsa con la lengua.", badge: "Español", image_class: "bg-topic-3"),
      OpenStruct.new(title: "Topic 4", description: "優雅で効率的、時に謎めいている — 一文字で哲学を語れる言語。", badge: "Japanise", image_class: "bg-topic-4"),
      OpenStruct.new(title: "Topic 5", description: "Ogni frase sembra un’opera appassionata — anche se stai solo chiedendo indicazioni.", badge: "Italiano", image_class: "bg-topic-5"),
      OpenStruct.new(title: "Topic 6", description: "Ünlüler coşkuyla dans eder, ekler kebap gibi üst üste dizilir — lezzetli ve ifade dolu.", badge: "Türkçe", image_class: "bg-topic-6")
    ]
  end
end
