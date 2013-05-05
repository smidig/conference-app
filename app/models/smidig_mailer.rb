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
end