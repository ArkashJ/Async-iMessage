#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ma
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Async Messages
# @raycast.author arkashj
# @raycast.authorURL https://raycast.com/arkashj

set varName to display dialog "Enter Your contact name or number" default answer ""
set stringReturned to text returned of varName
get stringReturned

set message to display dialog "Enter Your Message" default answer ""
set messages to text returned of message
get messages

tell application "Contacts"
	set p to first person whose (first name is stringReturned)
	set phoneNumber to value of first phone of p
end tell

set schedulingOptions to {"In 1 min", "In 2 min", "In 5 min", "In 10 minutes", "In 1 hour", "In 2 hours", "In 3 hours", "In 4 hours", "In 5 hours", "In 10 hours"}
set selectedOption to choose from list schedulingOptions with prompt "When do you want to send the message?"
# Set the delay based on the selected option
set delayInSeconds to 0
if selectedOption is "In 10 minutes" then
	set delayInSeconds to 600
else if selectedOption is "In 2 min" then
	set delayInSeconds to 60 * 2
else if selectedOption is "In 5 min" then
	set delayInSeconds to 60 * 5
else if selectedOption is "In 1 hour" then
	set delayInSeconds to 3600
else if selectedOption is "In 2 hours" then
	set delayInSeconds to 3600 * 2
else if selectedOption is "In 3 hours" then
	set delayInSeconds to 3600 * 3
else if selectedOption is "In 4 hours" then
	set delayInSeconds to 3600 * 4
else if selectedOption is "In 5 hours" then
	set delayInSeconds to 3600 * 5
else if selectedOption is "In 10 hours" then
	set delayInSeconds to 3600 * 10
else
	set delayInSeconds to 60
end if

delay delayInSeconds
with timeout of delayInSeconds seconds
	tell application "Messages"
		set messageToSend to messages
		try
			set iMessageService to (1st account whose service type = iMessage)
			set iMessageBuddy to participant phoneNumber of iMessageService
			send messageToSend to iMessageBuddy
			log ("sent as iMessage to: " & phoneNumber)
		on error
			try
				set iMessageService to (1st account whose service type = SMS)
				set iMessageBuddy to participant phoneNumber of iMessageService
				send messageToSend to iMessageBuddy
				log ("sent as SMS to: " & phoneNumber)
			on error
				log ("ERROR: COULD NOT SEND TO: " & phoneNumber)
			end try
		end try
	end tell
end timeout

tell application "Messages"
	activate
end tell
