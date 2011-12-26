require 'sinatra'

require 'sequel'
DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

class ProcessHelpers
	def setup_db
		DB.create_table :tweets do
			primary_key :id
			String :text
			DateTime :date
			Boolean :complete
		end
	end

	def next_tweet

	end
end

class SimpleTweet < Sequel::Model

end


get '/' do
	next_tweet = ProcessHelpers.next_tweet
	if next_tweet.nil?
		haml :done
	else
		haml :tweet, :locals => {:text => next_tweet.text, :date => next_tweet.date, :success => session[:success]}
	end
end

get '/setup-database'
	haml :setup
end

post '/:tweet'
	# post to tumblr
	# mark in database as complete

	session[:success] = true
	#otherwise false or cleared out
end

delete '/:tweet'
	# remove from database

	session[:success] = true
	#otherwise false or cleared out
end