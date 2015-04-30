module TicketsHelper
  def ticket_for_name(tickets, name)
    tickets.select{|ticket| ticket.name == name}.first
  end

  def ticket_price(ticket)
    number_to_currency(ticket.price, unit: "NOK", separator: ",", delimiter: ".", format: "%u %n").gsub(/,00/, ',-')
  end

  def regular_ticket_price
    ticket_price(Ticket.where( :name => 'Regular 2015').first)
  end
end
