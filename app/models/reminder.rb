require 'net/http'
require 'uri'

class Reminder < ApplicationRecord
  def remind 
    uri = URI('https://api.groupme.com/v3/bots/post')
    bot_id = ENV["bot_id"]

    if	params["group_id"] == ENV["test_group_id"]
      bot_id = ENV["test_bot_id"]
    end

    res = Net::HTTP.post_form(
      uri, 
      "bot_id" => bot_id,
      "text" => "Your bet of '#{reminder}' is up today!"
    )
  end

  handle_asynchronously :remind, :run_at => Proc.new { self.last.reminder_datetime; }
end
