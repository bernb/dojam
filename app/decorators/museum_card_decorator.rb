class MuseumCardDecorator < Draper::Decorator
  decorates :museum_object
  delegate_all

  
end
