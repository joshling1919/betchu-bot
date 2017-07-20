class BotsController < ApplicationController
	def accept_command
		render json: "Command Processed", status: 200
	end
end
