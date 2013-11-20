user_count = 0
error_count = 0

require 'rubygems'
require 'instagram'
require 'colorize'


# configuring instagram gem
# get first token by registering app and following client-side authentication on http://instagram.com/developer/

Instagram.configure do |config|
  config.access_token = "ACCESS_TOKEN"
end

# defining tags to grab pictures to like from

selected_tags = %w(
                  dog
                  beach
                  sunset
)

while 1 < 100
  
# looping through each tag

  selected_tags.each do |tag|
  
# getting the 60 most recent photos from each tag

    photos = Instagram.tag_recent_media(tag, {count: 60})
    photos.each do |photo|
    
# following each user

	  begin
        Instagram.follow_user(photo.user.id)
        user_count = user_count + 1
        puts "Followed Users:".green
        puts user_count
        sleep 10
      
# unfollowing each user

      Instagram.unfollow_user(photo.user.id)
      puts "Unfollowed User".yellow
      
# rescuing if necessary

      rescue Exception => e  
	    error_count = error_count + 1
	    puts e.message.red
	    if error_count%2 == 0  
		  puts 'Error! Retry has failed, waiting ten minutes'.red
		  sleep 600


        end
      end
    end
  end
end




