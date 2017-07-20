require 'net/http'
require 'uri'

class BotsController < ApplicationController
	def accept_command
		if params["group_id"] == ENV["group_id"] || 
			params["group_id"] == ENV["test_group_id"] && 
			params["sender_type"] == "user"

			text_arr = params["text"].downcase.split(" ")

			if text_arr.include?("bet")
				post_obj = {}
				post_obj["bot_id"] = ENV["test_bot_id"]
				post_obj["text"] = "Did someone say bet?"
				Net::HTTP.post URI('https://api.groupme.com/v3/bots/post'),
					post_obj.to_json,
					"Content-Type" => "application/json"
				render json: "Command Processed", status: 200
			end
		end
	end
end
