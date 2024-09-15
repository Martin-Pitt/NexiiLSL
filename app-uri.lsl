#define agentURI(agent) "secondlife:///app/agent/" + (string)agent + "/inspect"
#define agentAboutURI(agent) "secondlife:///app/agent/" + (string)agent + "/about"
#define regionURI(region) "secondlife:///app/region/" + llEscapeURL(region)
#define objectURI(object) "secondlife:///app/objectim/" + (string)object + "?name=" + llKey2Name(object) + "&owner=" + llGetOwnerKey(object)
#define groupURI(group) "secondlife:///app/group/" + (string)group + "/inspect"
#define groupAboutURI(group) "secondlife:///app/group/" + (string)group + "/about"
#define experienceURI(experience) "secondlife:///app/experience/" + (string)experience + "/profile"
#define chatURI(channel, message) "secondlife:///app/chat/" + (string)channel + "/" + llEscapeURL(message)
#define encodeLink(link, label) "[" + link + " " + label + "]"
