# -*- encoding : utf-8 -*-
class RademadeAdmin::GalleryController < RademadeAdmin::AbstractController

  def upload
    gallery_service.upload_images(params[:gallery_id], params[:files])
    render :json => {
      :gallery_images_html => gallery_service.gallery_images_html
    }
  rescue Exception => e
    show_error(e)
  end

  def remove
    gallery_service.remove_image(params[:id])
    render :json => { }
  rescue Exception => e
    show_error(e)
  end

  def sort
    gallery_service.sort_images(params[:images])
    render :json => { }
  rescue Exception => e
    show_error(e)
  end

  private

  def show_error(error)
    render :json => { :error => error.to_s }, :status => :unprocessable_entity
  end

  def gallery_service
    @gallery_service ||= RademadeAdmin::Gallery::Manager.new(params[:class_name])
  end

end