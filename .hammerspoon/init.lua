hs.hotkey.bind({"cmd", "alt", "ctrl"}, "P", function()
	hs.osascript.applescript([[tell application "Pages"
		make new document with properties {name:"Unititled"}
		activate
	end tell]])
end)

