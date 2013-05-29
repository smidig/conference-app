class AddTicketTypeToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :ticket_type, :string
  	Ticket.all.each do |ticket|
      ticket.update_attributes!(:ticket_type => 'regular')
    end
  end
end
