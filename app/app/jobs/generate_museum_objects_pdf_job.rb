class GenerateMuseumObjectsPdfJob < ApplicationJob
  queue_as :default
  after_perform :send_pdf_to_user

  def perform(museum_objects, user)
    museum_objects = museum_objects.map(&:decorate)
    pdf = ApplicationController.render(pdf: 'test.pdf',
                                 template: 'museum_objects/museum_objects_pdf.html.erb',
                                 locals: {museum_objects: museum_objects})
    user.pdf_export = pdf
    user.save
  end

  private
  def send_pdf_to_user
    puts "*** FINISHED ***"
  end
end
