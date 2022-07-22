function onLoad()
    print("Updatet!")
    checkForUpdate()
end

ScriptVersion = 4
ScriptClass = 'MyUtility'

function checkForUpdate()
    WebRequest.get("https://raw.githubusercontent.com/MrMetube/TTS/main/test.json", function(res)
        if (not(res.is_error)) then
            local response = JSON.decode(res.text)
            if (response[ScriptClass] > ScriptVersion) then
                print('New Version ('..response[ScriptClass]..') of '..ScriptClass..' is available!')
                -- install update?
                installUpdate(response[ScriptClass])
            end
        else
            error(res)
        end
    end)
end

function installUpdate(newVersion)
	print('[33ff33]Installing Upgrade to '..ScriptClass..'('..tostring(newVersion)..')[-]')
	WebRequest.get('https://raw.githubusercontent.com/MrMetube/TTS/main/test.lua', function(res)
        if res.is_error then return error(res) end
        print(res.text)
        self.setLuaScript(res.text)
        -- self.reload()
        print('[33ff33]Installation Successful[-]')
    end)
end
