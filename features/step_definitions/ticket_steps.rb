Given /^there exist a visible ticket$/ do
  Ticket.create(
      name: 'Dummy ticket',
      price: 1,
      ticket_type: 'regular',
      active: true,
      visible: true,
      ticket_type: 'regular'
  ) if Ticket.visible.empty?
end

Given /^there exist a speaker ticket$/ do
  Ticket.create(
      name: 'Dummy ticket',
      price: 1,
      active: true,
      ticket_type: 'speaker',
      visible: true
  ) if Ticket.find_by_ticket_type("speaker").nil?
end
