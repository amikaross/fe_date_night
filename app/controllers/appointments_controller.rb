class AppointmentsController < ApplicationController
  def new 
    if !current_user
      flash[:error] = "You must log in to view this page."
      redirect_to root_path
    end
  end

  def create
    appointment = Appointment.new(appointment_params)
    # appointment.place_name = current_user.favorites.find_by(google_id: params[:place_id]).name
    if appointment.save
      UserAppointment.create(user: current_user, appointment: appointment, owner: true)
      flash[:success] = "You have successfully created your Date!"
      redirect_to appointments_path
    else
      flash[:error] = "Error: #{error_message(appointment.errors)}"
      redirect_to new_appointment_path
    end
  end

  def show
    @appointment = Appointment.find_by(id: params[:id])
  end

  def edit
    @appointment = Appointment.find_by(id: params[:id])
  end

  def update
    appointment = Appointment.find_by(id: params[:id])
    appointment.update(appointment_params)
    
    redirect_to appointment_path(appointment)
  end

  def destroy
    appointment = Appointment.find_by(id: params[:id])
    appointment.destroy

    redirect_to appointments_path
  end

  private

  def appointment_params
    params.permit(:name, :place_name, :date, :time, :notes)
  end
end