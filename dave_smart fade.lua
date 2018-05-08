-- @description  dave_Smart Fade In / Out at mouse cursor
-- @version 0.1
-- @author dave
-- @changelog
-- Repository URI https://github.com/theyv/ReaScripts
--   + Initial release

    function main()
      reaper.BR_GetMouseCursorContext()
      local item = reaper.BR_GetMouseCursorContext_Item()
      local pos_cur = reaper.BR_GetMouseCursorContext_Position()
      if item then
        local pos = reaper.GetMediaItemInfo_Value(item, 'D_POSITION')
        local len = reaper.GetMediaItemInfo_Value(item, 'D_LENGTH' )   
        if ((len/2) >  pos_cur - pos) then 
          reaper.SetMediaItemInfo_Value(item, 'D_FADEINLEN_AUTO', -1)
          reaper.SetMediaItemInfo_Value(item, 'D_FADEINLEN', pos_cur - pos)
        else
         reaper.SetMediaItemInfo_Value(item, 'D_FADEOUTLEN_AUTO', -1)
         reaper.SetMediaItemInfo_Value(item, 'D_FADEOUTLEN', (pos+len)-pos_cur)
       end
       reaper.UpdateItemInProject(item)
     end
   end
   script_title = "dave_smart fade in/out"
   reaper.Undo_BeginBlock()
   main()
   reaper.Undo_EndBlock(script_title, 0)