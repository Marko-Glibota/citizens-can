class UserMailer < ApplicationMailer
  def request
    @user = params[:user]
    @representative = params[:representative]
    @message = params[:message]
    @objet = params[:objet]
    mail(to: @representative.email, subject: "#{@objet}")
  end
end
