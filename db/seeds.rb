# encoding: utf-8

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

Ticket.create(name: 'Early Bird', price: 1750, active: true, visible: true, ticket_type: 'regular')
organizer = Ticket.create(name: 'Organizer', price: 0, active: true, visible: false, ticket_type: 'free')
Ticket.create(name: 'Sponsor', price: 0, active: true, visible: false, ticket_type: 'free')
Ticket.create(name: 'Speaker', price: 0, active: true, visible: false, ticket_type: 'speaker')

# This will seed administrators with their appropriate names and email addresses. Their password is 'password'.
administrators = [
    {:name => "Ivar Conradi Østhus", :email => "ivarconr@gmail.com"},
    {:name => "Edward Grönroos", :email => "edward@gronroos.se"},
    {:name => "Jonas Amundsen", :email => "jonasba@gmail.com"},
]

administrators.each do |user_data|
  user_data.merge!({
      :tlf => "12345678",
      :password => 'password',
      :password_confirmation => 'password1234',
      :accepted_privacy => "1",
      :ticket_id => organizer.id,
      :company => 'Smidig 2014',
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

Sponsor.create(name: "Smidig 2014", 
  url: "http://2014.smidig.no/info/sponsor", 
  imageUrl: "https://googledrive.com/host/0Bxbse3ziIO6GUmYwQ0VxME1TRUE/sponsor.png")
Sponsor.create(name: "Smidig 2014", 
  url: "http://2014.smidig.no/info/sponsor", 
  imageUrl: "https://googledrive.com/host/0Bxbse3ziIO6GUmYwQ0VxME1TRUE/sponsor.png")
Sponsor.create(name: "Smidig 2014", 
  url: "http://2014.smidig.no/info/sponsor", 
  imageUrl: "https://googledrive.com/host/0Bxbse3ziIO6GUmYwQ0VxME1TRUE/sponsor.png")
Sponsor.create(name: "Itera", 
  url: "http://2014.smidig.no/info/sponsor", 
  imageUrl: "http://2014.smidig.no/assets/sponsors/itera.png")
Sponsor.create(name: "BEKK", 
  url: "http://2014.smidig.no/info/sponsor", 
  imageUrl: "http://2014.smidig.no/assets/sponsors/bekk.png")
Sponsor.create(name: "Miles", 
  url: "http://2014.smidig.no/info/sponsor", 
  imageUrl: "http://2014.smidig.no/assets/sponsors/miles.png")
Sponsor.create(name: "Webstep", 
  url: "http://2014.smidig.no/info/sponsor", 
  imageUrl: "http://2014.smidig.no/assets/sponsors/webstep.png")

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
foaje = Room.create(name: "Foajé", color: "gray")
alle = Room.create(name: "Alle", color: "gray")
olympia = Room.create(name: "Olympia", color: "#F90")
film = Room.create(name: "Film", color: "#C00")
kunst = Room.create(name: "Kunst", color: "#090")
madonna = Room.create(name: "Madonna", color: "silver")
vampyr = Room.create(name: "Vampyr", color: "blue")
resturant = Room.create(name: "Resturant", color: "gray")


t1 = Timeslot.create(start: "2014-10-27 08:00:00", end: "2014-10-27 08:45:00")
Roomslot.create(:room_id => foaje.id, :timeslot_id => t1.id)

t2 = Timeslot.create(start: "2014-10-27 08:45:00", end: "2014-10-27 09:00:00")
Roomslot.create(:room_id => olympia.id, :timeslot_id => t2.id)

t3 = Timeslot.create(start: "2014-10-27 09:00:00", end: "2014-10-27 10:00:00")
Roomslot.create(:room_id => olympia.id, :timeslot_id => t3.id)

t4 = Timeslot.create(start: "2014-10-27 10:15:00", end: "2014-10-27 11:00:00")
Roomslot.create(:room_id => olympia.id, :timeslot_id => t4.id)
Roomslot.create(:room_id => film.id, :timeslot_id => t4.id)
Roomslot.create(:room_id => kunst.id, :timeslot_id => t4.id)

t5 = Timeslot.create(start: "2014-10-27 10:15:00", end: "2014-10-27 12:00:00", is_workshop_slot: true)
Roomslot.create(:room_id => madonna.id, :timeslot_id => t5.id)
Roomslot.create(:room_id => vampyr.id, :timeslot_id => t5.id)

t6 = Timeslot.create(start: "2014-10-27 11:15:00", end: "2014-10-27 12:00:00")
Roomslot.create(:room_id => olympia.id, :timeslot_id => t6.id)
Roomslot.create(:room_id => film.id, :timeslot_id => t6.id)
Roomslot.create(:room_id => kunst.id, :timeslot_id => t6.id)

t7 = Timeslot.create(start: "2014-10-27 12:00:00", end: "2014-10-27 13:15:00")
Roomslot.create(:room_id => foaje.id, :timeslot_id => t7.id)

t8 = Timeslot.create(start: "2014-10-27 13:15:00", end: "2014-10-27 14:00:00")
Roomslot.create(:room_id => olympia.id, :timeslot_id => t8.id)
Roomslot.create(:room_id => film.id, :timeslot_id => t8.id)
Roomslot.create(:room_id => kunst.id, :timeslot_id => t8.id)

t9 = Timeslot.create(start: "2014-10-27 14:15:00", end: "2014-10-27 16:30:00")
Roomslot.create(:room_id => alle.id, :timeslot_id => t9.id)

t10 = Timeslot.create(start: "2014-10-27 17:00:00", end: "2014-10-27 19:30:00")
Roomslot.create(:room_id => foaje.id, :timeslot_id => t10.id)


# dag 2
t11 = Timeslot.create(start: "2014-10-28 08:30:00", end: "2014-10-28 09:00:00")
Roomslot.create(:room_id => foaje.id, :timeslot_id => t11.id)

t12 = Timeslot.create(start: "2014-10-28 09:00:00", end: "2014-10-28 10:00:00")
Roomslot.create(:room_id => olympia.id, :timeslot_id => t12.id)

t13 = Timeslot.create(start: "2014-10-28 10:15:00", end: "2014-10-28 11:00:00")
Roomslot.create(:room_id => olympia.id, :timeslot_id => t13.id)
Roomslot.create(:room_id => film.id, :timeslot_id => t13.id)
Roomslot.create(:room_id => kunst.id, :timeslot_id => t13.id)

t14 = Timeslot.create(start: "2014-10-28 10:15:00", end: "2014-10-28 14:00:00", is_workshop_slot: true)
Roomslot.create(:room_id => madonna.id, :timeslot_id => t14.id)

t15 = Timeslot.create(start: "2014-10-28 10:15:00", end: "2014-10-28 12:00:00", is_workshop_slot: true)
Roomslot.create(:room_id => vampyr.id, :timeslot_id => t15.id)

t16 = Timeslot.create(start: "2014-10-28 11:15:00", end: "2014-10-28 12:00:00")
Roomslot.create(:room_id => olympia.id, :timeslot_id => t16.id)
Roomslot.create(:room_id => film.id, :timeslot_id => t16.id)
Roomslot.create(:room_id => kunst.id, :timeslot_id => t16.id)

t17 = Timeslot.create(start: "2014-10-28 12:00:00", end: "2014-10-28 13:15:00")
Roomslot.create(:room_id => foaje.id, :timeslot_id => t17.id)

t18 = Timeslot.create(start: "2014-10-28 13:15:00", end: "2014-10-28 14:00:00")
Roomslot.create(:room_id => olympia.id, :timeslot_id => t18.id)
Roomslot.create(:room_id => film.id, :timeslot_id => t18.id)
Roomslot.create(:room_id => kunst.id, :timeslot_id => t18.id)

t19 = Timeslot.create(start: "2014-10-28 14:15:00", end: "2014-10-28 16:30:00")
Roomslot.create(:room_id => alle.id, :timeslot_id => t19.id)

t20 = Timeslot.create(start: "2014-10-28 16:30:00", end: "2014-10-28 16:30:00")
Roomslot.create(:room_id => alle.id, :timeslot_id => t20.id)