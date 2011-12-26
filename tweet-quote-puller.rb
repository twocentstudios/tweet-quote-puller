require 'rubygems'
require 'twitter'

user = ARGV[0] || "twitter"

output = []

#16 pages total = 3200 tweets max
16.times do |i|
	timeline = Twitter.user_timeline(user, :count => 200, :trim_user => true, :exclude_replies => true, :page => i)
	puts "Page #{i} downloaded"
	timeline.each do |status|
		unless status.text.match(/"*"/).nil?
			output << "#{status.text}\n#{status.created_at}\n\n"
		end
	end
	sleep(60)	#helps with twitter api throttling
end

File.open('output.txt','w') do |file|
	file.puts output
end