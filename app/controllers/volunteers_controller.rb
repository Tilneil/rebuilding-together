# frozen_string_literal: true

class VolunteersController < ApplicationController
    
before_action :authenticate_user!

  def index
    # set permission that only the administrator can see the index
    # also set up function/action either here or in devise that when the user
        # first sign up for login credentials they're redirected to a creat your
        # profile page. 
  # @repair = Repair.all
    @volunteer = Volunteer.all
  end

  def new
  # @repair = Repair.all
    @volunteer = Volunteer.new
    if current_user.volunteer != nil
          redirect_to volunteer_path(current_user.volunteer.id)
    end
  end
  
  def show
    @volunteer = current_user.volunteer
  end
  
  def create
    # @repair = Repair.all
    @volunteer = Volunteer.new(volunteer_params)
    @volunteer.user_id = current_user.id
    if @volunteer.save
          redirect_to volunteer_path(@volunteer.id)
    else
      render 'new'
    end
  end

  def edit
    # @repair = Repair.all
    @volunteer = Volunteer.find(current_user.id)
  end

  def update
      volunteer = Volunteer.find(params[:id])
      volunteer.update!(volunteer_params)
      volunteer.user_id = current_user.id  #put this seperate because doesn't seem to work included as strong params
      redirect_to volunteer_path(volunteer.id)
  end

  # def (action to view projects)
  #   # show projects available based on their skills?
  #   # show past projects they've completed?
  #   # show current projects and profiles for their team members?
  # end

  def add
    # for volunteer to sign up for a project
    # if volunteer signs up, a message or notification gets sent to the administrator
  end

  def remove
    # for volunteer to remove project, perhaps include a note for why they're
    # no longer available?
  end

private
    def volunteer_params
      params.require(:volunteer).permit(:picture,:first_name,:last_name,:email,
      :mobile_phone, :birthdate, :gender, :city, :state, :employer, :position,
      :availability, :skill, :volunteer_notes)
    end
end