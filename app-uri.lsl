string agentURI(string agent) { if(agent == "") agent = NULL_KEY; return "secondlife:///app/agent/" + agent + "/inspect"; }
string agentAboutURI(string agent) { if(agent == "") agent = NULL_KEY; return "secondlife:///app/agent/" + agent + "/about"; }
string regionURI(string region) { return "secondlife:///app/region/" + llEscapeURL(region); }
string objectURI(string object) { return "secondlife:///app/objectim/" + object + "?name=" + llKey2Name(object) + "&owner=" + llGetOwnerKey(object); }
string groupURI(string group) { if(group == "") group = NULL_KEY; return "secondlife:///app/group/" + group + "/inspect"; }
string groupAboutURI(string group) { if(group == "") group = NULL_KEY; return "secondlife:///app/group/" + group + "/about"; }
string experienceURI(string experience) { if(experience == "") experience = NULL_KEY; return "secondlife:///app/experience/" + experience + "/profile"; }
