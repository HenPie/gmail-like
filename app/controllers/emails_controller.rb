class EmailsController < ApplicationController
  def index
    @emails = Email.all
  end

  def create 
    @email = Email.new(object: Faker::Book.title, body: Faker::Lorem.paragraph)
    if @email.save
      redirect_to root_path
      flash[:notice] = "Email created"
    else
      redirect_to root_path
      flash[:notice] = "Please try again"
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
    end
  end

  def show
    @email = Email.find(params[:id])
    @email.update(read: true)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
    end
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_path }
      format.js { }
    end
  end

  def update
    @email = Email.find(params[:id])
    @email.toggle(:read).save
    flash[:notice] = "Email edited"
    respond_to do |format|
      format.html { redirect_to emails_path }
      format.js { }
    end
  end

end
