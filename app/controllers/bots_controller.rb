class BotsController < ApplicationController
	def accept_command
		puts params
		render json: "Command Processed", status: 200
	end
end
