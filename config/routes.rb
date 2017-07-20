Rails.application.routes.draw do
	root to: "bots#accept_command"

	post '/' => 'bots#accept_command'
end
