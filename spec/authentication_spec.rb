require 'spec_helper'

describe "authentication" do

  should_not_require_authentication(:controller => :info, :action => :index)
  should_not_require_authentication(:controller => :info, :action => :about)
  should_not_require_authentication(:controller => :info, :action => :sponsor)
  should_not_require_authentication(:controller => :info, :action => :godbiter)

  should_require_user_authentication(:controller => :my_profile, :action => :index)
  should_require_user_authentication(:controller => :my_profile, :action => :receipt)
  should_require_user_authentication(:controller => :my_profile, :action => :dinner_registration)

  ticket = Ticket.default || FactoryGirl.create(:ticket)

  user_params = {
      :name      => 'John Doe',
      :email     => 'john.doe@email.com',
      :tlf       => '22228888',
      :ticket_id => ticket.id
  }

  should_require_user_authentication( :controller => :orders, :action => :show)
  should_require_user_authentication( :controller => :orders, :action => :new_user)
  should_require_user_authentication({:controller => :orders, :action => :add_user}.merge({ :user => user_params}))

  should_require_admin_authentication(:controller => :orders, :action => :index)
  should_require_admin_authentication(:controller => :orders, :action => :destroy, :method => :delete, :id => FactoryGirl.create(:order))

  should_require_admin_authentication(:controller => :sponsors, :action => :index)
  should_require_admin_authentication(:controller => :sponsors, :action => :show,                        :id => FactoryGirl.create(:sponsor))
  should_require_admin_authentication(:controller => :sponsors, :action => :new)
  should_require_admin_authentication(:controller => :sponsors, :action => :create,  :method => :post,   :id => FactoryGirl.create(:sponsor))
  should_require_admin_authentication(:controller => :sponsors, :action => :edit,                        :id => FactoryGirl.create(:sponsor))
  should_require_admin_authentication(:controller => :sponsors, :action => :update,  :method => :post,   :id => FactoryGirl.create(:sponsor))
  should_require_admin_authentication(:controller => :sponsors, :action => :destroy, :method => :delete, :id => FactoryGirl.create(:sponsor))

  should_require_admin_authentication(:controller => :talk_categories, :action => :index)
  should_require_admin_authentication(:controller => :talk_categories, :action => :show,                        :id => FactoryGirl.create(:talk_category))
  should_require_admin_authentication(:controller => :talk_categories, :action => :new)
  should_require_admin_authentication(:controller => :talk_categories, :action => :create,  :method => :post,   :id => FactoryGirl.create(:talk_category))
  should_require_admin_authentication(:controller => :talk_categories, :action => :edit,                        :id => FactoryGirl.create(:talk_category))
  should_require_admin_authentication(:controller => :talk_categories, :action => :update,  :method => :post,   :id => FactoryGirl.create(:talk_category))
  should_require_admin_authentication(:controller => :talk_categories, :action => :destroy, :method => :delete, :id => FactoryGirl.create(:talk_category))

  should_require_admin_authentication(:controller => :talk_types, :action => :index)
  should_require_admin_authentication(:controller => :talk_types, :action => :show,                        :id => FactoryGirl.create(:talk_type))
  should_require_admin_authentication(:controller => :talk_types, :action => :new)
  should_require_admin_authentication(:controller => :talk_types, :action => :create,  :method => :post,   :id => FactoryGirl.create(:talk_type))
  should_require_admin_authentication(:controller => :talk_types, :action => :edit,                        :id => FactoryGirl.create(:talk_type))
  should_require_admin_authentication(:controller => :talk_types, :action => :update,  :method => :post,   :id => FactoryGirl.create(:talk_type))
  should_require_admin_authentication(:controller => :talk_types, :action => :destroy, :method => :delete, :id => FactoryGirl.create(:talk_type))

  should_require_admin_authentication(:controller => :tickets, :action => :index)
  should_require_admin_authentication(:controller => :tickets, :action => :show,                        :id => FactoryGirl.create(:ticket))
  should_require_admin_authentication(:controller => :tickets, :action => :new)
  should_require_admin_authentication(:controller => :tickets, :action => :create,  :method => :post,   :id => FactoryGirl.create(:ticket))
  should_require_admin_authentication(:controller => :tickets, :action => :edit,                        :id => FactoryGirl.create(:ticket))
  should_require_admin_authentication(:controller => :tickets, :action => :update,  :method => :post,   :id => FactoryGirl.create(:ticket))
  should_require_admin_authentication(:controller => :tickets, :action => :destroy, :method => :delete, :id => FactoryGirl.create(:ticket))

  payment_params = {
      :manual_payment => {
          :manual_invoice_id => 1
      }
  }

  should_require_admin_authentication( :controller => :payments, :action => :index)
  should_require_admin_authentication( :controller => :payments, :action => :manual)
  should_require_admin_authentication( :controller => :payments, :action => :finish,                      :id => FactoryGirl.create(:manual_payment, :order => FactoryGirl.create(:order)))
  should_require_admin_authentication({:controller => :payments, :action => :invoice_sent,                :id => FactoryGirl.create(:manual_payment)}.merge(payment_params))
  should_require_admin_authentication( :controller => :payments, :action => :show,                        :id => FactoryGirl.create(:manual_payment))
  should_require_admin_authentication( :controller => :payments, :action => :destroy, :method => :delete, :id => FactoryGirl.create(:manual_payment))

  should_require_admin_authentication(:controller => :administration, :action => :registrations)
  should_require_admin_authentication(:controller => :administration, :action => :send_mail)
  should_require_admin_authentication(:controller => :administration, :action => :statistics)

end
