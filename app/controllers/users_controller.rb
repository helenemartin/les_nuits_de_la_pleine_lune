class UsersController < ApplicationController
  def create
    user = User.create(params["user"])
    require 'sendgrid-ruby'

    # As a hash
    client = SendGrid::Client.new(api_key: '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')

    # Or as a block
    client = SendGrid::Client.new do |c|
      c.api_key = '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'
    end
    mail = SendGrid::Mail.new do |m|
      m.to = user.email
      m.from = 'taco@cat.limo'
      m.subject = "Hello #{user.name}"
      m.text = 'I heard you like pineapple.'
    end

res = client.send(mail)
puts res.code
puts res.body
# 200
# {"message"=>"success"}
    redirect_to home_pages_path
  end


end