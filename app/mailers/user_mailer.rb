class UserMailer < ApplicationMailer
  def send_examination_details_tech
    @user = params[:user]
    mail(to: @user.email, subject: "FluxUS'21 - Brainiac: Details and Link for Technical Quiz")
  end

  def send_examination_details_non_tech
    @user = params[:user]
    mail(to: @user.email, subject: "FluxUS'21 - Brainiac: Details and Link for Non Technical Quiz")
  end

  def send_examination_details_both
    @user = params[:user]
    mail(to: @user.email, subject: "FluxUS'21 - Brainiac: Details and Link for Tech and Non-Tech")
  end
end
