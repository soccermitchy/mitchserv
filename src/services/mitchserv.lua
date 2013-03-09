function mitchserv(usr,target,msg)
    msg=string.gsub(msg,"\002","")
    msg=string.gsub(msg,"\001","")
    if string.match(msg,">lua (.+)") and msg:sub(1,3)==">lu" then
        if usr=="wolfmitchell" or usr=="Iota" then
            func,err=loadstring(string.match(msg,">lua (.+)"))
            if (func==nil or type(func)~="function") or err then
                if err then
                    smesg("MitchServ",target,"Your lua code errored: "..err)
                else 
                    smesg("MitchServ",target,"Your lua code has caused an unknown error.")
                end
            else
                s,r=pcall(func)
                if r then
                    smesg("MitchServ",target,r)
                else
                    smesg("MitchServ",target,"No data returned!")
                end
            end
     elseif string.match(msg,">shutdo(.-)") and msg:sub(1,3)==">sh" then
         if usr=="wolfmitchell" or usr=="iota" then
             rawline(":mitch.serv p :Shutting down :O")
             for k,v in pairs(users) do
                 rawline(":"..k.." , :Mitchserv is shutting down :O")
             end
             client:close()
             os.exit()
         else
             smesg("MitchServ",target,"You do not have the required permissions.")
         end
     end
end
end
table.insert(cmdfuncs,mitchserv)

