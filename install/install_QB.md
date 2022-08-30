QBCORE INSTALL QUIDE

1. Download all dependencies!
    Dependencies:
    ox_lib | https://github.com/overextended/ox_lib
    es_extended / qb-core

2. Add Images to your inventory
    qb-inventory > html > images
    Paste images from folder images to qb-inventory > html > images 

3. Add Items to your inventory
    qb-core > shared.lua
    ["bodycam"] 		 	 	 	 = {["name"] = "bodycam",           			["label"] = "Bodycam",	 		["weight"] = 200, 		["type"] = "item", 		["image"] = "bodycam.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil, ["description"] = "Bodycam for police officers!"},

4. add ensure drc_bodycam into your server.cfg

5. Enjoy your new bodycam script from DRC SCRIPTS!
