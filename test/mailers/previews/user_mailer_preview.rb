# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_examination_details_both
    user = User.first
    UserMailer.with(user: user).send_examination_details_both
  end

  def send_examination_details_tech
    user = User.last
    UserMailer.with(user: user).send_examination_details_tech
  end

  def send_examination_details_non_tech
    user = User.last
    UserMailer.with(user: user).send_examination_details_non_tech
  end
end
