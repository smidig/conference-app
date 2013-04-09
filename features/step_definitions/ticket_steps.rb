Given /^there exist a visible ticket$/ do
  Ticket.create(
      name: 'Dummy ticket',
      price: 1,
      active: true,
      visible: true
  ) if Ticket.visible.empty?
end
