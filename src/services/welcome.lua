function welcome(usr,target,msg)
    if usr=="Services" then
        if string.match(msg,"(.-) REGISTER: (.+)") then
            founder,chan=string.match(msg,"(.-) REGISTER: (.+)")
            --userjoin("Welcome",chan)
	    chan=string.gsub(chan,"\2","")
	    rawline(":Welcome  C "..chan)
            smesg("Welcome",chan,"Welcome to FurryLand "..founder.."!")
            smesg("Welcome",chan,"If you need some help, see http://furryland.net/services/chan and http://furryland.net/services/bot")
            smesg("Welcome",chan,"Anything not mentioned there? Join #help and ask!")
            rawline(":Welcome D "..chan.." :Thanks for registering your channel!")
        end
    end
end
--cmdfuncs[welcome]=welcome
