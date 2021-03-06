
- # Roam Agenda
    - MacOSX only
    - Pastes daily agenda into roam, including
        - Ideas and Projects (optional)
        - Today’s Events from iCloud Calendar
        - Today’s Tasks from Things 3
![Screenshot](https://user-images.githubusercontent.com/1575500/91783499-caf15900-ec43-11ea-9503-6766e5047144.png)
- ## Installation
        - install roamAgenda.scpt in in ~/Library/Scripts
            - As default roamAgenda does not include the Templating functions
            - To customise you will need to also add the file roamAgenda.conf to ~/Library/Scripts
                - make sure the first line is 'useTemplate true'
                - I have embedded blocks called 
                    - ‘The Lab’ for ideas in different categories
                    - ‘The Market’ for things I need to get from different ‘stalls'
                    - ‘Todays Projects’ - things I choose to work on today
                    - ‘This Weeks Projects’ - thing to do this week
                - change the reference ID for embedded blocks to those in your graph
                - save the changes you have made
        - Install roamAgenda.alfredworkflow into Alfred
            - This is a very simple workflow so you can create it yourself
                - Snippet -> Run Script (bin/bash)
                - osascript ~/Library/Scripts/roamAgenda.scpt
        - Install CalendarLib EC
            - download from https://latenightsw.com/support/freeware/
            - place in ~/Library/Script Libraries (which may have to be created)
- ## Useage
        - Type the Alfred hotkey in your Daily Notes
        - I use ‘roama ‘ (ie roama followed by a space) as the hotkey
        - If you like, drag (or reference)Tasks imported from Things to the appropriate Project in Roam
- ## Screenshots
        - [Results](screenshots/roamAgenda_complete.png)
        - [The Drawing Board](screenshots/theDrawingBoard.png)
        - [The Lab](screemshots/theLab.png)
        - [The Market](screenshots/theMarket.png)


