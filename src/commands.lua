using_servs={}
cmdfuncs={}
using_servs["MitchServ"]="mitchserv"
using_servs["Welcome"]="welcome"
using_servs["QuoteServ"]="quoteserv"
for k,v in pairs(using_servs) do
    dofile("src/services/"..v..".lua")
end

function msghandler(usr,target,msg)
    for k,v in pairs(cmdfuncs) do
        s,r=pcall(v,usr,target,msg)
        if r then
            rawline(":MitchServ ! #services :[ERROR] "..r)
        end
    end
end
