class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("user_mailer.account_activation.subject")
  end

  def password_reset
    @greeting = t "user_mailer.password_reset.greeting"
    mail to: t("user_mailer.password_reset.mail")
  end
end
