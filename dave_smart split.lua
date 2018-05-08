-- @description Smart split  at mouse cursor (preserve fade In / Out)
-- @version 1.0
-- @author dave
-- @about
--   # Your Package Title
--   Longer description/documentation for this package in *markdown*.
-- @changelog
--   + Initial release


local function SaveSelectedItems (table)
	for i = 0, reaper.CountSelectedMediaItems(0)-1 do
		if reaper.GetSelectedMediaItem(0, i) ~= nil then
			table[i+1] =  reaper.BR_GetMediaItemGUID( reaper.GetSelectedMediaItem(0, i) )
		end
	end
end
local function RestoreSelectedItems (table)
  reaper.Main_OnCommand(40289, 0) -- Unselect all items
  for _, item in ipairs(table) do
  	tempitem =  reaper.BR_GetMediaItemByGUID( 0, item )
  	if   tempitem ~= nil then 
  		reaper.SetMediaItemSelected(item, true)

  	end
  end
end
function main()
	init_sel_items = {}
	SaveSelectedItems(init_sel_items)
	reaper.Main_OnCommand(40289,1)
	reaper.BR_GetMouseCursorContext()
	item = reaper.BR_GetMouseCursorContext_Item()
	pos_cur = reaper.BR_GetMouseCursorContext_Position()
	tr =  reaper.BR_GetMouseCursorContext_Track()
	if item then
		reaper.SetMediaItemInfo_Value(item, "B_UISEL", 1)   
		pos = reaper.GetMediaItemInfo_Value(item, 'D_POSITION')
		len = reaper.GetMediaItemInfo_Value(item, 'D_LENGTH' ) 
		local fadeoutbef = reaper.GetMediaItemInfo_Value(item,'D_FADEOUTLEN')
		local fadeoutautobef = reaper.GetMediaItemInfo_Value(item,'D_FADEOUTLEN_AUTO')		
		local fadeinbef = reaper.GetMediaItemInfo_Value(item,'D_FADEINLEN')
		local fadeinautobef = reaper.GetMediaItemInfo_Value(item,'D_FADEINLEN_AUTO')

		if ((len/2) >  pos_cur - pos) then 
 reaper.Main_OnCommand(40748,1) -- split andselect right
 local itemright =  reaper.GetSelectedMediaItem( 0,0 )
 reaper.SetMediaItemInfo_Value(itemright, 'D_FADEINLEN_AUTO', -1)
 reaper.SetMediaItemInfo_Value(itemright, 'D_FADEINLEN', 0.100)
 reaper.DeleteTrackMediaItem( tr, item )
else
	local item = reaper.BR_GetMouseCursorContext_Item()
	local pos_cur = reaper.BR_GetMouseCursorContext_Position()

	reaper.Main_OnCommand(40748,1) 
	reaper.SetMediaItemInfo_Value(item, 'D_FADEOUTLEN_AUTO', fadeoutautobef)
	reaper.SetMediaItemInfo_Value(item, 'D_FADEOUTLEN', fadeoutbef)
	local itemright =  reaper.GetSelectedMediaItem( 0,0 )
	reaper.DeleteTrackMediaItem( tr, itemright )
end
RestoreSelectedItems(init_sel_items)
reaper.UpdateArrange()
end
end
script_title = "dave_smart split with fade  in/out"
reaper.Undo_BeginBlock()
main()
reaper.Undo_EndBlock(script_title, 0)
