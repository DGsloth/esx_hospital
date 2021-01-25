![alt text](https://i.imgur.com/WEBsD2d.png "Deceitful Gaming")  
Looking for a great gaming community to join? Look no further than [Deceitful Gaming](https://discord.gg/U4kVv37ynP)  
We're a small (and growing) gaming community founded with the community and it's members in mind. We strive ourselves in being transparent and community driven by our members.

# esx_hospital
Original resource created by [qalle-git](https://github.com/qalle-git/esx-qalle-jail)  
Modified by [Warden Eternal](https://github.com/TheWardenEternal)

### Download
- Download https://github.com/TheWardenEternal/esx_hospital/archive/main.zip
- Put it in any directory

### Installation
- Add this to your `server.cfg`

```
start esx_hospital
```

- Add the SQL to your database
- Go to `server.lua` and change line 26 (or remove it) to announce that someone was hospitalized
- To use the same bed locations, get this MLO (https://www.gabzv.com/products/pillbox-hospital-v2)

### Requirements
- Nothing

### Features
- Anti-Combat Log (as soon as someone joins who was hospitalized previously, they will be put back into the hospital)
- Anti-Leave (if someone who is hospitalized leaves the set area, it will teleport them back to a bed)
- Ability to change 'bed' locations (client.lua)
- Ability to change maximum amount of time someone can be admitted (server.lua - line 14)
- Ability to unadmit players who were accidently admitted

### Information
I will not provide any kind of support for this addon. If someone makes a pull request to fix something, I may merge it.
