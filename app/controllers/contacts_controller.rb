class ContactsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:error] = nil
      redirect_to shows_path, notice: 'Message sent successfully'
    else
      flash.now[:error] = 'Please fill in all fields before sending message'
      render :new
    end
  end
end
