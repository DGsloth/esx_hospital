# esx_hospital
### Modified by Warden Eternal

Required items for current setup
1. https://www.gabzv.com/products/pillbox-hospital

### How to setup
1. Install the provided SQL into whichever program you use
2. Drag the script into your server folder
3. Add "start esx_hospital" into your server.cfg
4. Start your server
5. Have the Police/Ambulance job and type "/admit PLAYERID REASON_WITH_SPACES"
6. Profit?
7. Hospitalized the wrong person? "/unadmit PLAYERID"

### Other Information (client.lua)
1. You may need to change the "BedLocations" if you use a different interior
2. When the person is "healed", they do not get teleported. They will be able to roam free. If you want this changed, refer to my "esx_jail" script
3. Lines 86-98: Stops the hospitalized person from getting to far away (preventing escape) - Disable if you wish

### Other Information (server.lua)
1. Line 19: May want to add a ban thing here, or at least log it
2. Line 26: You may need to change this to a normal chat message. Or you can disable other people knowing about other being jailed

-------------------
Yes, this is just an edit of esx_jail

Script is provided as-is. I will not help fix it or maintain it. Other users may make a pull request if they have fixed something and I will try my best to merge it.
