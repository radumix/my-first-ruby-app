class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash[:success] = "Contact created successfully!"
      redirect_to contacts_path  # Redirect to the index page after success
    else
      flash[:error] = "Failed to create contact."
      render :new  # Re-render the new page if the save fails
    end
  end

  # GET /contacts/:id
  def show
    # This action automatically loads the contact via `set_contact`
  end

  # GET /contacts/:id/edit
  def edit
    # This action automatically loads the contact via `set_contact`
  end

  # PATCH/PUT /contacts/:id
  def update
    if @contact.update(contact_params)
      flash[:success] = "Contact updated successfully!"
      redirect_to contacts_path  # Redirect to the index page after success
    else
      flash[:error] = "Failed to update contact."
      render :edit  # Re-render the edit page if the update fails
    end
  end

  # DELETE /contacts/:id
  def destroy
    @contact.destroy
    flash[:success] = "Contact deleted successfully!"
    redirect_to contacts_path  # Redirect to the index page after deleting the contact
  end

  rescue_from ActiveRecord::RecordNotFound, with: :contact_not_found

  private

  # Find the contact by id for show, edit, update, and destroy actions
  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_not_found
    flash[:error] = "Contact not found."
    redirect_to contacts_path
  end

  # Strong parameters for creating or updating contacts
  def contact_params
    params.require(:contact).permit(:name, :email)
  end
end
