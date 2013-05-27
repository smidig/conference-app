# encoding: UTF-8

class SmidigMailer < ActionMailer::Base
  default_url_options[:host] = "2013.smidig.no"
  FROM_EMAIL = 'Smidig 2013 <kontakt@smidig.no>'
  SUBJECT_PREFIX = "[Smidig 2013]"

  default :from => FROM_EMAIL

  def registration_confirmation(user)
    @user = user
    mail(:to => user.email,
         :subject => "#{SUBJECT_PREFIX} Bruker #{user.email} er registrert")
  end

  def payment_confirmation(user)
    @name = user.name
    @payment_text = user.ticket.name
    @amount = user.ticket.price.to_i
    @mva = user.ticket.mva
    mail(:to => user.email,
   :subject => "#{SUBJECT_PREFIX} Betalingskvittering for #{user.email}")
  end

  def free_registration_confirmation(user)
    @name = user.name
    @email = user.email
    mail(:to => user.email,
   :subject => "#{SUBJECT_PREFIX} Bruker #{user.email} er registrert")
  end

  def free_registration_notification(user, users_url)
    @name = user.name
    @email = user.email
    @description = user.ticket.name,
    @users_url = users_url
    mail(:to => FROM_EMAIL, :reply_to => "#{user.name} <#{user.email}>",
   :subject => "#{SUBJECT_PREFIX} Bruker #{user.email} har registrert seg som #{user.ticket.name}")
  end

  def user_added_to_order_confirmation(user, added_by_user, reset_password_url)
    @name = user.name
    @email = user.email
    @added_by_user_name = added_by_user.name
    @reset_password_url = reset_password_url
    mail(:to => user.email, :reply_to => "#{user.name} <#{user.email}>",
   :subject => "#{SUBJECT_PREFIX} Bruker #{user.email} er registrert")
  end

  def manual_payment_created_confirmation(payment)
    user = payment.order.owner
    @name = user.name
    @amount = payment.price
    mail(:to => user.email,
   :subject => "#{SUBJECT_PREFIX} Faktura opprettet")
  end

  def manual_payment_created_notification(payment, payments_manual_url)
    @name = payment.order.owner.name
    @amount = payment.price
    @payments_manual_url = payments_manual_url
    mail(:to => FROM_EMAIL,
   :subject => "#{SUBJECT_PREFIX} Fakturaforespørsel opprettet")
  end

end