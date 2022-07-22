--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]

--[[ The onLoad event is called after the game save finishes loading. --]]
function onLoad()
	print("UPDATED")
    checkForUpdate()
end

ScriptVersion = 3
ScriptClass = 'MyUtility'

function checkForUpdate()
    -- WebRequest.get("https://api.github.com/repos/MrMetube/TTS/contents/test.json", function(res)
    WebRequest.get("https://raw.githubusercontent.com/MrMetube/TTS/main/test.json", function(res)
        if (not(res.is_error)) then
            local response = JSON.decode(res.text)
            table.print(response)
            if (response[ScriptClass] > ScriptVersion) then
                print('New Version ('..response[ScriptClass]..') of '..ScriptClass..' is available!')
                -- install update?
                installUpdate(response[ScriptClass])
            end
        else
            error(res)
        end
    end)


    -- WebRequest.get("https://api.github.com/repos/MrMetube/TTS/contents/Test.json", function(request)
    --     if request.is_error then
    --         log(request.error)
    --     else
    --         print(request.text)
    --     end
    -- end)
end

function installUpdate(newVersion)
	print('[33ff33]Installing Upgrade to '..ScriptClass..'['..tostring(newVersion)..']')
	WebRequest.get('https://github.com/MrMetube/TTS/blob/main/test.lua', function(res)
        if (not(res.is_error)) then
		self.setLuaScript(res.text)
		self.reload()
		print('[33ff33]Installation Successful[-]')
        else
            error(res)
        end
    end)
end

function table.print(input,surkey)
if surkey == nil then surkey = "" end 
    for k,v in pairs(input) do
        k=surkey..""..k
        if type(v)=="table" then table.print(v,k)
        elseif type(v)=="boolean" then print(k..": "..tostring(v))
        else print(k..": "..v) end
    end
end
