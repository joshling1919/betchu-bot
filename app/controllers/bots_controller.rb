require 'net/http'
require 'uri'

class BotsController < ApplicationController
	def accept_command
		puts params
		if params["sender_type"] == "user"
			text_arr = params["text"].downcase.split(" ")
			last_i = text_arr.length - 1
			last_word = text_arr[last_i].gsub(/[[:punct:]]/, '')

			if text_arr.include?("bet") || last_word == "bet"
				if params["group_id"] == ENV["group_id"] 
					bot_id = ENV["bot_id"]
				elsif	params["group_id"] == ENV["test_group_id"]
					bot_id = ENV["test_bot_id"]
				end

				uri = URI('https://api.groupme.com/v3/bots/post')
				res = Net::HTTP.post_form(
					uri, 
					"bot_id" => bot_id,
					"text" => "Did someone say bet?"
				)
				puts res.body
				render json: "Command Processed", status: 200
			end
		end
	end
end
