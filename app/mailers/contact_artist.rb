class ContactArtist < ApplicationMailer
  def hello(recipient, sender, content)
    @content   = content
    @sender    = sender
    @recipient = recipient
    mail(to: @recipient.email, subject: "Message de #{@sender.title}")
  end
end
