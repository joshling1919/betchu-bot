require 'net/http'
require 'uri'

class BotsController < ApplicationController
	def accept_command
		puts params
		if params["sender_type"] == "user"
			text_arr = params["text"].downcase.split(" ")
			last_i = text_arr.length - 1
			last_word = text_arr[last_i].gsub(/[[:punct:]]/, '')

			uri = URI('https://api.groupme.com/v3/bots/post')
			bot_id = ENV["bot_id"]

			if	params["group_id"] == ENV["test_group_id"]
				bot_id = ENV["test_bot_id"]
			end

			last_reminder = Reminder.last 
			if Reminder.last && 
			   Reminder.last.user == params["name"] &&
				 Reminder.last.reminder_datetime == nil 

				date = params["text"].split("/")
				month = date[0].to_int 
				day = date[1].to_int
				year = date[2].to_int 
				
				Reminder.last.update(
					reminder_datetime: DateTime.new(year, month, day, 12, 0, 0)					
				)

				res = Net::HTTP.post_form(
					uri, 
					"bot_id" => bot_id,
					"text" => "Thanks!"
				)
				puts res.body
				render json: "Command Processed", status: 200 

			elsif text_arr[0] == "@betchu-bot"
				res = Net::HTTP.post_form(
					uri, 
					"bot_id" => bot_id,
					"text" => "Great, and when does your bet end? (MM/DD/YY)"
				)

				bet = text_arr[1, last_i].join(" ")
				Reminder.create(
					user: params["name"],
					user_groupme_id: params["user_id"],
					reminder: bet
				)
				puts res.body
				render json: "Command Processed", status: 200 

			elsif text_arr.include?("bet") || last_word == "bet"

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
