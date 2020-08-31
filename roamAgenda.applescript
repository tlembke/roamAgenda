
use scripting additions
use script "CalendarLib EC"
-- https://latenightsw.com/support/freeware/
-- nice!!
-- place in ~/Library/Script Libraries (which may have to be created)

-- set this to false if not wanting to use templates
set useTemplate to true
-- set these to the reference of the parent embeddedBlock
set theLab to "0hVOh8SGb"
set theMarket to "9Q-zHKx01"
set theDrawingBoardToday to "p-yUpe1zR"
set theDrawingBoardWeek to "lBSwKorAn"

-- change this if you want specific calendars
set theCalendarNames to {} --  default all calenders

-- start calendar part



-- find events for today from calendar

set today to (current date)
set today's time to 0
set tomorrow to today + days
set myMeetings to {}


set {year:y, month:m, weekday:w, day:d, hours:h} to (current date)



set calHours to h
if calHours < 12 then
	set timeofDay to "this Morning"
else if calHours < 16 then
	set timeofDay to "this Afternoon"
else if calHours < 19 then
	set timeofDay to "this Evening"
else
	set timeofDay to "Tonight"
end if



set theStore to fetch store
set theCalendars to fetch calendars theCalendarNames cal type list {} event store theStore
set theEvents to fetch events starting date today ending date tomorrow searching cals theCalendars event store theStore
repeat with anEvent in theEvents
	set {event_summary:theSummary, event_start_date:theStartdate, event_end_date:theEndDate, all_day:allDayEvent} to event info for event anEvent
	-- If the event's a 24-hour all-day event, or an ordinary event which ends today, prepare appropriate spoken text.
	set theTime to missing value
	if (allDayEvent as boolean) then
		set theTime to "	All-day event"
	else if (theEndDate is less than or equal to tomorrow) then
		-- Get a representation of the start time in 12-hour time.
		set {hours:Eventhour, minutes:Eventminute} to theStartdate
		set pre to item (Eventhour div 12 + 1) of {"AM", "PM"}
		set Eventhour to (Eventhour + 11) mod 12 + 1
		if (Eventminute is 0) then set Eventminute to ""
		set theTime to "	" & Eventhour & " " & Eventminute & " " & pre
	end if
	-- Put both the start date and the meeting text into the meetings list as a pair.
	if (theTime is not missing value) then set the end of myMeetings to {theStartdate, theTime & " : " & theSummary & "
"}
end repeat


set greetings to {"Let's take a quick look at your calendar:", "Let's see what you have going on today:", "Let's see how busy your day looks:", "Here's whats on your calendar:"}
set greeting to some item of greetings

set schedules to {"You currently have nothing scheduled on your calendar for ", "I was unable to locate any appointments on your calendar for ", "You currently have nothing on your calendar for ", "Your calendar has no pending appointements at this time for "}
set schedule to some item of schedules


set numberOfMeetings to (count myMeetings)
if (numberOfMeetings is 0) then
	set preamble to schedule & timeofDay
else if (numberOfMeetings is 1) then
	set preamble to greeting & "I could only locate one event for " & w
else
	set preamble to greeting & "You better get moving, there are " & numberOfMeetings & " upcoming appointments."
end if

set theText to preamble & "
"
repeat with thismeeting in myMeetings
	
	set theText to theText & "	" & item 2 of thismeeting
	
end repeat

set theEvents to theText

-- end calendar part

-- start Things part
tell application "Things3"
	
	set theText to "

"
	if useTemplate is true then
		set theText to theText & "## [[The Lab]]
	{{[[embed]]: ((" & theLab & "))}}
## [[The Market]]
	{{embed:((" & theMarket & "))}}	
## [[The Drawing Board]]
	{{embed:((" & theDrawingBoardToday & "))}}	
	{{embed: ((" & theDrawingBoardWeek & "))}}
"
	end if
	set theText to theText & "	### Scheduled Events" & "
		" & theEvents & "
	### Today's Complete Task List
			"
	--- The embeds above are blocks that you would need to replace with your own block reference
	--- 0hVOh8SGb is a block called 'Ideas'
	-- 9Q-zHKx01 is a block called 'Stalls' with shops as bullets
	--- p-yUpe1zR is a block of today's tasks
	--- lBSwKorAn is a block of this week's tasks
	
	repeat with todayToDo in to dos of list "Today"
		
		if the class of todayToDo as string is not equal to "project" then
			--- do something with each to do using toDo variable
			
			
			if the status of todayToDo is equal to completed then
				set theText to theText & "		{{[[DONE]]}}"
			else
				set theText to theText & "		{{[[TODO]]}}"
			end if
			set theText to theText & name of todayToDo & "
"
		end if
	end repeat
	
end tell
-- end Things part
set theText to theText & "
"
set the clipboard to theText
tell application "System Events" to keystroke "v" using command down