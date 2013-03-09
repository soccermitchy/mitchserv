local f=io.open("conf.json","r")
if not f then print("Please make a configuration file... it's easy.") os.exit() end
config=json:decode(f:read'*a')
if not config.bindtoip   then print("conf:bindtoip is not defined.")  os.exit() end
if not config.bindtoport then print("conf:bindtoport is not defined.") os.exit() end
if not config.channels     then print("conf:bindtoport is not defined. will not join anywhere.") os.exit() end
if not config.logchan      then print("conf:logchan is not defined. not logging.") os.exit() end
if not config.pass         then print("conf:pass is not defined.") os.exit() end
if not config.server       then print("conf:server is not defined.") os.exit() end
f:close()
