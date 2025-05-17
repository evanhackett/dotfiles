hs.hotkey.bind({"cmd", "alt", "ctrl"}, "P", function()
	hs.osascript.applescript([[tell application "Pages"
		make new document with properties {name:"Unititled"}
		activate
	end tell]])
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "N", function()
	hs.osascript.applescript([[tell application "Brave Browser"
    	make new window
	end tell]])
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "I", function()
	hs.osascript.applescript([[tell application "Chrome"
    	make new window
	end tell]])
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
	hs.osascript.applescript([[tell application "Finder"
    	open folder "Macintosh HD:Users:evan"
    	activate
	end tell]])
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
	hs.osascript.applescript([[tell application "Finder"
    	open folder "Macintosh HD:Users:evan:Desktop"
    	activate
	end tell]])
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
	hs.osascript.applescript([[tell application "iTerm2"
    	create window with default profile
	end tell]])
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
	hs.osascript.applescript([[tell application "Brave Browser"
    	make new window
    	open location "https://pop-os.local/"
	end tell]])
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "E", function()
	hs.osascript.applescript([[tell application "System Events"
    	do shell script "/usr/local/bin/sublime --new-window"
	end tell]])
end)

-- open finder's "Go to Folder" dialog.
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "G", function()
	local script = [[
    	tell application "Finder" to activate
    	tell application "System Events"
        	tell process "Finder"
            	click menu item "Go to Folder…" of menu "Go" of menu bar 1
        	end tell
    	end tell
  	]]
	hs.osascript.applescript(script)
end)