json=require"lib.json"
require"socket"
dofile("src/func.lua")
dofile("src/confparse.lua")
dofile("src/commands.lua")
config.netname=config.netname or "IotaIRC"
users={}
server=socket.bind(config.bindtoip,config.bindtoport)
if not server then print("Unable to bind to "..config.bindtoip.." "..config.bindtoport) os.exit() end
print("Now waiting for a connection from another IRC server.")
client=server:accept()
rawline("PASS "..config.pass)
rawline("PROTOCTL 2309 TOKEN NICKv2 VHP SJOIN2 SJ3 VL NS")
rawline("SERVER mitch.serv 1 :2309-Y-102 mitchserv MitchServ0.2")
rawline("NETINFO 10 "..os.time().." 2309 * 0 0 0 :"..config.netname)
users=adduser("MitchServ","MitchServ","Mitch.Serv.v0.2","MitchServ Version 0.2",users)
users=adduser("Welcome","Welcome","IotaIRC.net","Welcome to IotaIRC",users)
users=adduser("QuoteServ","QuoteServ","quote.serv","I can has quotes?",users)
recv=true
while recv==true do
    data=client:receive('*l')
    if data then
        print(data)
        serv=string.match(config.server,"^[^.]*")
        if string.find(data,":"..serv) then
            recv=false
        end
    end
end
rawline("ES")
for k,v in pairs(users) do 
    for l,w in pairs(config.channels) do 
        users=userjoin(k,w,users)
    end
end
while client do
    rawhandler(client:receive'*l')
end
