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
				uri = URI('https://api.groupme.com/v3/bots/post')
				res = Net::HTTP.post_form(
					uri, 
					"bot_id" => ENV["test_bot_id"],
					"text" => "Did someone say bet?"
				)
				puts res.body
				render json: "Command Processed", status: 200
			end
		end
	end
end
