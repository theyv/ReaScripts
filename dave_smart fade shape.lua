--[[
 * ReaScript Name: dave_Smart toggle within fade shapes in item at mouse cursor 
 * Description: left half of item = fade in / right half = fade out
 * Version: 0.1
 * Author: dave
 * Repository URI: https://github.com/theyv/dave_ReaScript
 --]]


--[[
 * Changelog:
  
 * v0.1 - May 8 2018
    + initial release
    --]]
    
function main()
	reaper.Main_OnCommand(40289,1)
	reaper.BR_GetMouseCursorContext()
	 item = reaper.BR_GetMouseCursorContext_Item()
	 pos_cur = reaper.BR_GetMouseCursorContext_Position()
	 tr =  reaper.BR_GetMouseCursorContext_Track()
	if item then
	    reaper.SetMediaItemInfo_Value(item, "B_UISEL", 1)   
		 pos = reaper.GetMediaItemInfo_Value(item, 'D_POSITION')
		 len = reaper.GetMediaItemInfo_Value(item, 'D_LENGTH' ) 
		if ((len/2) >  pos_cur - pos) then 
	reaper.Main_OnCommand(41520,1)
		else

	reaper.Main_OnCommand(41527,1)

end
reaper.UpdateArrange()
end
end
script_title = "dave_smart fade shape in/out"
reaper.Undo_BeginBlock()
main()
reaper.Undo_EndBlock(script_title, 0)

