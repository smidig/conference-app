Given /^there exist a visible ticket$/ do
  Ticket.create(
      name: 'Dummy ticket',
      price: 1,
      active: true,
      visible: true,
      ticket_type: 'regular'
  ) if Ticket.visible.empty?
end
