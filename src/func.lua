function rawline(raw) -- The base of most of the soon-to-be module API. Although that will be implemented after configuration is. And after I parse what other servers send properly.
    client:send(raw.."\n")
    client:send(":MitchServ ! "..config.logchan.." :[SERV]-->[IRCD] "..raw.."\n")
    print("[SERV]-->[IRCD] "..raw)
end
function umode(nick,mode)
    rawline(":"..nick.." G "..nick.." "..mode)
end
function adduser(nick,username,hostname,rname,users)
    rawline("& "..nick.." 1 "..os.time().." "..username.." "..hostname.." mitch.serv "..os.time().." :"..rname)
    rawline(":mitch.serv BB "..nick.." +rDRhgwlcLkKbBnGAaNCzWtZvqdX")
    umode(nick,"+o")
    users[nick]={}
    users[nick].channels={}
    users[nick].username=username
    users[nick].hostname=hostname
    users[nick].realname=rname
    print("au: type(users[nick])="..type(users[nick]))
    return users
end
function smesg(as,to,msg)
    rawline(":"..as.." ! "..to.." :"..msg)
end
function userjoin(nick,channel,users)
    if not users then users={} end
    if not users[nick] then
	    users[nick]={}
	    users[nick].channels={}
	    users[nick].username="asdf"
	    users[nick].hostname="asdf"
	    users[nick].realname="asdf"
    end
    print("uj: type(nick)="..type(nick))
    print("uj: type(users[nick])="..type(users[nick]))
    rawline(":"..nick.." C "..channel)
    table.insert(users[nick].channels,channel)
    return users
end
function stripLeadingSpaces(text)
    local temp=true
        while temp==true do
            if text:sub(1,1)==" " then
                    text=text:sub(2,#text)
                else
                    temp=false
            end
        end
        return text
end
function rawhandler(data)
    if string.match(data,"8 :(.+)") and data:sub(1,1)=="8" then
        rawline("9 mitch.serv :"..string.match(data,"8 :(.+)"))
    elseif string.match(data,":(.-) ! (.-) :(.*)") then
        local user,target,msg=string.match(data,":(.-) ! (.-) :(.*)")
        if target==k then target=user end
        msghandler(user,target,msg)
    end
    print("[IRCD]-->[SERV] "..data)
    if data:sub(1,#'[IRCD]-->[SERV]')=='[IRCD]-->[SERV]' then return end
    client:send(":MitchServ ! "..config.logchan.." :[IRCD]-->[SERV] "..stripLeadingSpaces(data).."\n")
end

