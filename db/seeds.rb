# encoding: utf-8

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

Ticket.create(name: 'Early Bird', price: 1750, active: true, visible: true, ticket_type: 'regular')
organizer = Ticket.create(name: 'Organizer', price: 0, active: true, visible: false, ticket_type: 'free')
Ticket.create(name: 'Sponsor', price: 0, active: true, visible: false, ticket_type: 'free')
Ticket.create(name: 'Speaker', price: 0, active: true, visible: false, ticket_type: 'speaker')

# This will seed administrators with their appropriate names and email addresses. Their password is 'password'.
administrators = [
    {:name => "Jonas Amundsen",      :email => "jonasba@gmail.com"},
    {:name => "Ivar Conradi Østhus", :email => "ivarconr@gmail.com"},
    {:name => "Edward Grönroos", :email => "edward@gronroos.se"}
]

administrators.each do |user_data|
  user_data.merge!({
      :tlf => "12345678",
      :password => 'password',
      :password_confirmation => 'password',
      :accepted_privacy => "1",
      :ticket_id => organizer.id,
      :company => 'Smidig 2013',
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

Sponsor.create(name: "Smidig 2013", url: "http://2013.smidig.no/info/sponsor", imageUrl: "https://googledrive.com/host/0Bxbse3ziIO6GUmYwQ0VxME1TRUE/sponsor.png")