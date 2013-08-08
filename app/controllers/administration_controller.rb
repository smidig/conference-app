class AdministrationController < ApplicationController
  authorize_admin!

  def statistics
    users = User.all
    @antall = users.count
    @antallBetalende = 0
    @antallPrBillett = {}
    @antallPrJobbrolle = {}
    @antallPrFirma = {}

    users.each do |user|   
      if user.completed
        @antallBetalende += 1
      end

      if @antallPrBillett[user.ticket.name] == nil
        @antallPrBillett[user.ticket.name] = 1
      else
        @antallPrBillett[user.ticket.name] = @antallPrBillett[user.ticket.name] + 1
      end

      if user.role == '' or user.role == nil
        if(@antallPrJobbrolle['Ikke definert'] == nil)
          @antallPrJobbrolle['Ikke definert'] = 1
        else 
          @antallPrJobbrolle['Ikke definert'] = @antallPrJobbrolle['Ikke definert'] + 1
        end
      else
        if @antallPrJobbrolle[user.role] == nil
          @antallPrJobbrolle[user.role] = 1
        else
          @antallPrJobbrolle[user.role] = @antallPrJobbrolle[user.role] + 1
        end
      end

      if @antallPrFirma[user.company] == nil
        @antallPrFirma[user.company] = 1
      else
        @antallPrFirma[user.company] = @antallPrFirma[user.company] + 1
      end
    end

    respond_to do |format|
    format.html # index.html.erb
    format.json  { render :json => @antallPrJobbrolle }
  end
end
end
