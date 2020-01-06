
-- Global menu table for additions
rawset(_G, "Menus", {})

-- Sample Menu
Menus.sample = {
    menudef = {name = "", x = 66, y = 40, spacing = 20, prefix = "\130", sfx = "sfx_menu1", z_order = 0, align = "center"},
    {text = "1 Player", func = function() print("function sent! (now playing sfx_s3k68)") S_StartSound(nil, sfx_s3k68) end},
    {text = "Multiplayer", func = function() end},
    {text = "Extras", func = function() end},
    {text = "Addons", func = function() end},
    {text = "Options", func = function() end},
    {text = "Quit Game", func = function() for player in players.iterate do P_KillMobj(player.mo) end end},
}


--local current_menu = "MainCopy"
local active_menus = {
    "sample",
}

-- Currently selected item
local current_menu_item = 1

hud.add(function(v, player)
    
    -- Iterate through active_menus for a list of active menus added to this list
    for activeMenusItem=1, #active_menus do

        -- Get the name of the current table list item
        local activeMenuName = active_menus[activeMenusItem]

        -- Iterate through each menu definition in the global menus table
        for i=1, #Menus[activeMenuName] do

            -- Our menu definition line for settings
            local defs = Menus[activeMenuName]["menudef"]
            
            local prefix = ""
            
            if (i == current_menu_item) then
                prefix = defs.prefix
            else
                prefix = ""
            end

            -- Draw each string in the text field
            -- TODO: offset x,y for offsetting each line by a value
            v.drawString(defs.x, defs.y+ defs.spacing*i, prefix .. Menus[activeMenuName][i].text, defs.flags, defs.align)
        end
    end

end)



addHook("ThinkFrame", function()

    for player in players.iterate() do

        -- Control handle to scroll through items
        if (player.buttonstate["up"] == 1) then
            current_menu_item = current_menu_item - 1
            S_StartSound(nil, sfx_menu1)
            if (current_menu_item < 1) then
                current_menu_item = #Menus["sample"]
            end
        elseif (player.buttonstate["down"] == 1) then
            S_StartSound(nil, sfx_menu1)
            current_menu_item = current_menu_item + 1
            if (current_menu_item > #Menus["sample"]) then
                current_menu_item = 1
            end
        elseif (player.buttonstate[BT_JUMP] == 1) then
            do Menus["sample"][current_menu_item].func() end
        end
    end

end)
