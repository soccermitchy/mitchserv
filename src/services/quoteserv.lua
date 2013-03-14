function quoteserv(usr,target,msg)
    if string.match(msg,">quote (.+)") and msg:sub(1,6)==">quote" then
        if string.match(msg,">quote get (.+)") then
            local f=io.open("data/quoteserv/qdb.json","r")
            local qdb=json:decode(f:read'*a') or {}
            f:close()
            if not tonumber(string.match(msg,">quote get (.+)")) then smesg("QuoteServ",target,"Invalid quote ID (Not a number)") else
                local found=false
                if qdb[tonumber(string.match(msg,">quote get (.+)"))] then found=true quoteinfo=qdb[tonumber(string.match(msg,">quote get (.+)"))] end
                if found==false then smesg("QuoteServ",target,"Invalid quote ID (Quote not found. Latest quote ID: "..#qdb or "None submitted"..")") else
                    if quoteinfo.nick then
                        text="From channel "..quoteinfo.channel.." Submitted by "..quoteinfo.submittedBy.." at "..quoteinfo.timestamp.." ID: "..quoteinfo.id.." Quote: <"..quoteinfo.nick.."> "..quoteinfo.quote
                    else
                        text="From channel "..quoteinfo.channel.." Submitted by "..quoteinfo.submittedBy.." at "..quoteinfo.timestamp.." ID: "..quoteinfo.id.." Quote: "..quoteinfo.quote
                    end
                    smesg("QuoteServ",target,text)
                    text=nil
                end
            end
        elseif string.match(msg,">quote add (.+)") then
            local f=io.open("data/quoteserv/qdb.json","r")
            local qdb=json:decode(f:read'*a') or {}
            f:close()
            local newID=#qdb+1
            if not target:sub(1,1)=="#" then smesg("QuoteServ",target,"This must be used in a channel.") else
                local quoteinfo={}
                quoteinfo.channel=target
                quoteinfo.id=newID
                local rawQuote=string.match(msg,">quote add (.+)")
                quoteinfo.nick =string.match(rawQuote,"<([%w-_]*)> .+") or nil
                if quoteinfo.nick then
                    quoteinfo.quote=string.match(rawQuote,"<"..quoteinfo.nick.."> (.+)") or rawQuote
                else
                    quoteinfo.quote=rawQuote
                end
                quoteinfo.submittedBy=usr
                local tmp="["..os.date("%m").."/"..os.date("%d").."/"..os.date("%y").." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S").."]"
                quoteinfo.timestamp=tmp
                table.insert(qdb,quoteinfo)
                local jsontext=json:encode_pretty(qdb)
                f=io.open("data/quoteserv/qdb.json","w")
                f:write(jsontext)
                f:close()
                smesg("QuoteServ",target,"Quote added as ID "..quoteinfo.id)
            end
        end
    end
end

