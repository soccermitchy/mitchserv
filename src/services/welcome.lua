function welcome(usr,target,msg)
    if usr=="Services" then
        if string.match(msg,"(.-) REGISTER (.+)") then
            founder,chan=string.match(msg,"(.-) REGISTER (.+)")
            userjoin("Welcome",chan)
            smesg("Welcome",chan,"Welcome to IotaIRC"..founder.."!")
            smesg("Welcome",chan,"If you need some help, see http://iotairc.net/services/chan and http://iotairc.net/services/bot")
            smesg("Welcome",chan,"Anything not mentioned there? Join #help and ask!")
            rawline(":Welcome D "..chan.." :Thanks for registering your channel!")
        end
    end
end
table.insert(cmdfuncs,welcome)
