# esx_hospital
Resource created by someone (idk who) I just heavily modified it to my needs.
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

### Features
- Anti-Combat Log (as soon as someone joins who was hospitalized previously, they will be put back into the hospital)
- Anti-Leave (if someone who is hospitalized leaves the set area, it will teleport them back to a bed)
- Ability to change 'bed' locations (client.lua)
- Ability to change maximum amount of time someone can be admitted (server.lua - line 14)
- Ability to unadmit players who were accidently admitted

### Information
I will not provide any kind of support for this addon. If someone makes a pull request to fix something, I may merge it.
