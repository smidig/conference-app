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
    {:name => "Edward Grönroos", :email => "edward@gronroos.se"},
    {:name => "Trude Martinsen", :email => "trude.martinsen@gmail.com"}
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

lyntale = TalkType.create(name: 'Lyntale', duration: 10, visible: true)
TalkType.create(name: 'Kort workshop', duration: 45, visible: true)
TalkType.create(name: 'Lang workshop', duration: 90, visible: true)

TalkCategory.create(name: 'Annet')
TalkCategory.create(name: 'Smidig programmering')
TalkCategory.create(name: 'Lean startup')

Sponsor.create(name: "Smidig 2013", url: "http://2013.smidig.no/info/sponsor", imageUrl: "https://googledrive.com/host/0Bxbse3ziIO6GUmYwQ0VxME1TRUE/sponsor.png")

# Approved talks:
for i in 0..10
  t = Talk.create(
    title: "Lorem ipsum test " + i.to_s, 
    description: "Lorem ipusm...", 
    talk_type_id: lyntale.id,
    talk_category_id: TalkCategory.all.first.id)
  t.status = "approved_and_confirmed";
  t.user = User.all.first
  t.save!
end

# rooms
foaje = Room.create(name: "Foajé")
olympia = Room.create(name: "Olympia")
film = Room.create(name: "Film")
kunst = Room.create(name: "Kunst")
madonna = Room.create(name: "Madonna")
vampyr = Room.create(name: "Vampyr")
resturant = Room.create(name: "Resturant")


t1 = Timeslot.create(start: "2013-11-05 08:00:00", end: "2013-11-05 08:45:00")
t2 = Timeslot.create(start: "2013-11-05 08:45:00", end: "2013-11-05 09:00:00")
t3 = Timeslot.create(start: "2013-11-05 09:00:00", end: "2013-11-05 10:00:00")
t4 = Timeslot.create(start: "2013-11-05 10:15:00", end: "2013-11-05 11:00:00")

Roomslot.create(:room_id => foaje.id, :timeslot_id => t1.id)

Roomslot.create(:room_id => olympia.id, :timeslot_id => t2.id)
Roomslot.create(:room_id => olympia.id, :timeslot_id => t3.id)

# lyntaler row 1
Roomslot.create(:room_id => olympia.id, :timeslot_id => t4.id)
Roomslot.create(:room_id => film.id, :timeslot_id => t4.id)
Roomslot.create(:room_id => kunst.id, :timeslot_id => t4.id)
Roomslot.create(:room_id => madonna.id, :timeslot_id => t4.id)
Roomslot.create(:room_id => vampyr.id, :timeslot_id => t4.id)