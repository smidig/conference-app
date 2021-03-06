module TicketsHelper
  def ticket_for_name(tickets, name)
    tickets.select{|ticket| ticket.name == name}.first
  end

  def ticket_price(ticket)
    number_to_currency(ticket.price, unit: "NOK", separator: ",", delimiter: ".", format: "%u %n").gsub(/,00/, ',-')
  end

  def early_bird_ticket_price
    ticket_price(Ticket.where( :name => 'Early Bird 2016').first)
  end

  def regular_ticket_price
    ticket_price(Ticket.where( :name => 'Regular 2016').first)
  end
end
