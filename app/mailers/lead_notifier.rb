class LeadNotifier < ApplicationMailer
  default :from => 'kirkjohnsonra@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def new_lead_notification
    
    mail( :to => 'kirkjohnsonra@gmail.com',
    :subject => 'New Lead' )
  end

end
