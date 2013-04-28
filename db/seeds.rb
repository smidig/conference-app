# encoding: utf-8

# This will seed administrators with their appropriate names and email addresses. Their password is 'password'.
administrators = [
    {:name => "Jonas Amundsen",      :email => "jonasba@gmail.com"},
    {:name => "Ivar Conradi Østhus", :email => "ivarconr@gmail.com"}
]

administrators.each do |user_data|
  user_data.merge!({
      :tlf => "12345678",
      :password => 'password',
      :password_confirmation => 'password',
      :accepted_privacy => "1",
  })

  user = User.new user_data
  user.admin = true
  user.save!
end

TalkType.create(name: 'Lyntale', duration: 10, visible: true)
TalkType.create(name: 'Kort workshop', duration: 45, visible: true)
TalkType.create(name: 'Lang workshop', duration: 90, visible: true)

TalkCategory.create(name: 'Annet')
TalkCategory.create(name: 'Smidig programmering')
TalkCategory.create(name: 'Lean startup')

Ticket.create(name: 'Early Bird', price: 1750, active: true, visible: true)
Ticket.create(name: 'Organizer', price: 0, active: true, visible: false)
Ticket.create(name: 'Sponsor', price: 0, active: true, visible: false)
Ticket.create(name: 'Speaker', price: 0, active: true, visible: false)
