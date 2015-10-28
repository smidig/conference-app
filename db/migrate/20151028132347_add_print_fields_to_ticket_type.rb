class AddPrintFieldsToTicketType < ActiveRecord::Migration
  def change
    add_column :tickets, :printflag, :boolean, :default => true, :null => false
    add_column :tickets, :printname, :string
  end
end
