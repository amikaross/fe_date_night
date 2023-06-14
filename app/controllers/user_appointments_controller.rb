class UserAppointmentsController < ApplicationController
  def update
    record = UserAppointment.find_by(id: params[:id])
    record.update(status: params[:status])
    
    redirect_to appointments_path
  end
end