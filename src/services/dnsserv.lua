dnsserv={}

function dnscheck(zone,i)
	i=i+1
	smesg("MitchServ","#debug.lua","[DNSBL] Checking "..zone.." (Currently on check #"..tostring(i)..")")
	local digout=io.popen("dig "..zone):read'*a'
	return digout:match", status: (.+), id: "
end
function dnsserv.reverseoctecs(ip)
	local octec1,octec2,octec3,octec4=ip:match"(%d+)%.(%d+)%.(%d+)%.(%d+)"
	local reversedIP=octec4.."."..octec3.."."..octec2.."."..octec1 or nil
	return reversedIP
end

dnsserv.zones={
	"ircbl.ahbl.org",
	"dnsbl.ahbl.org",
}
function dnsserv.command(usr,target,msg)
	runcount=0
	if msg:sub(1,#">dnsbl")==">dnsbl" then
		local ip=msg:sub(#">dnsbl  ",#msg)
		local lookup=msg:sub(#">dnsbl  ",#msg)
		
		ip=dnsserv.reverseoctecs(ip)
		if ip==lookup then
			smesg("MitchServ",target,"Invalid IP!")
			return
		end
		for k,v in pairs(dnsserv.zones) do
			smesg("MitchServ","#somewhereelse",v)
			local dnsresponse=dnscheck(ip.."."..v,runcount)
			if dnsresponse=="NOERROR" then
				smesg("MitchServ",target,"The IP "..lookup.." was found in the DNSBL "..v)
			else
				smesg("MitchServ",target,"No response from "..v.." via "..lookup.." ("..ip.."."..v..")")
			end
		end
	end
end
table.insert(cmdfuncs,dnsserv.command)
