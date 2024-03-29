class GenerateMuseumObjectsPdfJob < ApplicationJob
  queue_as :default
  after_perform do |job|
    current_user = job.arguments.second
    current_user.pdf_export_finished = true
    current_user.pdf_export_running = false
    current_user.save
  end

  def perform(museum_objects, user)
    museum_objects = museum_objects.map(&:decorate)
    user.pdf_export_running = true
    user.save
    pdf = ApplicationController.render(
        pdf: 'test.pdf',
        template: 'museum_objects/museum_objects_pdf.html.erb',
        locals: {museum_objects: museum_objects},
        enable_local_file_access: true)
    user.pdf_export = pdf
    user.save
  end
end
