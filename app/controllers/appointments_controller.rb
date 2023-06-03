class AppointmentsController < ApplicationController
  def new 
    if !current_user
      flash[:error] = "You must log in to view this page."
      redirect_to root_path
    end
  end

  def create
    appointment = Appointment.new(appointment_params)
    if appointment.save
      UserAppointment.create(user: current_user, appointment: appointment)
      flash[:success] = "You have successfully created your Date!"
      redirect_to user_dashboard_path
    else
      flash[:error] = "Error: #{error_message(appointment.errors)}"
      redirect_to new_appointment_path
    end
  end

  def show
    @appointment = Appointment.find_by(id: params[:id])
  end

  private

  def appointment_params
    params.permit(:name, :place_name, :date, :time, :notes)
  end
end