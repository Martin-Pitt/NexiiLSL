#define DAMAGE_TYPE_MEDICAL 100
#define DAMAGE_TYPE_REPAIR 101
#define DAMAGE_TYPE_EXPLOSIVE 102
#define DAMAGE_TYPE_CRUSHING 103
#define DAMAGE_TYPE_ANTI_ARMOR 104
#define DAMAGE_TYPE_SUFFOCATION 105
#define DAMAGE_TYPE_REDEPLOY 106

// Returns name of the constant that identifies the damage type
string DamageTypeAsConstant(integer type)
{
    if(type == DAMAGE_TYPE_IMPACT) return "DAMAGE_TYPE_IMPACT";
    if(type == DAMAGE_TYPE_GENERIC) return "DAMAGE_TYPE_GENERIC";
    if(type == DAMAGE_TYPE_ACID) return "DAMAGE_TYPE_ACID";
    if(type == DAMAGE_TYPE_BLUDGEONING) return "DAMAGE_TYPE_BLUDGEONING";
    if(type == DAMAGE_TYPE_COLD) return "DAMAGE_TYPE_COLD";
    if(type == DAMAGE_TYPE_ELECTRIC) return "DAMAGE_TYPE_ELECTRIC";
    if(type == DAMAGE_TYPE_FIRE) return "DAMAGE_TYPE_FIRE";
    if(type == DAMAGE_TYPE_FORCE) return "DAMAGE_TYPE_FORCE";
    if(type == DAMAGE_TYPE_NECROTIC) return "DAMAGE_TYPE_NECROTIC";
    if(type == DAMAGE_TYPE_PIERCING) return "DAMAGE_TYPE_PIERCING";
    if(type == DAMAGE_TYPE_POISON) return "DAMAGE_TYPE_POISON";
    if(type == DAMAGE_TYPE_PSYCHIC) return "DAMAGE_TYPE_PSYCHIC";
    if(type == DAMAGE_TYPE_RADIANT) return "DAMAGE_TYPE_RADIANT";
    if(type == DAMAGE_TYPE_SLASHING) return "DAMAGE_TYPE_SLASHING";
    if(type == DAMAGE_TYPE_SONIC) return "DAMAGE_TYPE_SONIC";
    if(type == DAMAGE_TYPE_EMOTIONAL) return "DAMAGE_TYPE_EMOTIONAL";
    if(type == DAMAGE_TYPE_MEDICAL) return "DAMAGE_TYPE_MEDICAL";
    if(type == DAMAGE_TYPE_REPAIR) return "DAMAGE_TYPE_REPAIR";
    if(type == DAMAGE_TYPE_EXPLOSIVE) return "DAMAGE_TYPE_EXPLOSIVE";
    if(type == DAMAGE_TYPE_CRUSHING) return "DAMAGE_TYPE_CRUSHING";
    if(type == DAMAGE_TYPE_ANTI_ARMOR) return "DAMAGE_TYPE_ANTI_ARMOR";
    if(type == DAMAGE_TYPE_SUFFOCATION) return "DAMAGE_TYPE_SUFFOCATION";
    if(type == DAMAGE_TYPE_REDEPLOY) return "DAMAGE_TYPE_REDEPLOY";
    return (string)type;
}

// Returns damage type as a noun for use in sentences to describe the damage type
string DamageTypeAsNoun(integer type)
{
    if(type == DAMAGE_TYPE_IMPACT) return "impact";
    if(type == DAMAGE_TYPE_GENERIC) return "generic";
    if(type == DAMAGE_TYPE_ACID) return "acid";
    if(type == DAMAGE_TYPE_BLUDGEONING) return "bludgeoning";
    if(type == DAMAGE_TYPE_COLD) return "cold";
    if(type == DAMAGE_TYPE_ELECTRIC) return "electric";
    if(type == DAMAGE_TYPE_FIRE) return "fire";
    if(type == DAMAGE_TYPE_FORCE) return "force";
    if(type == DAMAGE_TYPE_NECROTIC) return "necrotic";
    if(type == DAMAGE_TYPE_PIERCING) return "shot"; // "piercing";
    if(type == DAMAGE_TYPE_POISON) return "poison";
    if(type == DAMAGE_TYPE_PSYCHIC) return "psychic";
    if(type == DAMAGE_TYPE_RADIANT) return "radiant";
    if(type == DAMAGE_TYPE_SLASHING) return "slashing";
    if(type == DAMAGE_TYPE_SONIC) return "sonic";
    if(type == DAMAGE_TYPE_EMOTIONAL) return "emotional";
    if(type == DAMAGE_TYPE_MEDICAL) return "medical";
    if(type == DAMAGE_TYPE_REPAIR) return "repair";
    if(type == DAMAGE_TYPE_EXPLOSIVE) return "explosive";
    if(type == DAMAGE_TYPE_CRUSHING) return "crushing";
    if(type == DAMAGE_TYPE_ANTI_ARMOR) return "anti-armor";
    if(type == DAMAGE_TYPE_SUFFOCATION) return "suffocation";
    if(type == DAMAGE_TYPE_REDEPLOY) return "redeploy";
    return "unknown";
}

// Returns damage type as a verb for use in sentences as how it was applied to a target
string DamageTypeAsVerb(integer type)
{
    if(type == DAMAGE_TYPE_IMPACT) return "impacted";
    if(type == DAMAGE_TYPE_GENERIC) return "damaged";
    if(type == DAMAGE_TYPE_ACID) return "corroded";
    if(type == DAMAGE_TYPE_BLUDGEONING) return "bludgeoned";
    if(type == DAMAGE_TYPE_COLD) return "frozen";
    if(type == DAMAGE_TYPE_ELECTRIC) return "electrocuted";
    if(type == DAMAGE_TYPE_FIRE) return "burnt";
    if(type == DAMAGE_TYPE_FORCE) return "smashed";
    if(type == DAMAGE_TYPE_NECROTIC) return "necrotised";
    if(type == DAMAGE_TYPE_PIERCING) return "shot"; // "pierced";
    if(type == DAMAGE_TYPE_POISON) return "poisoned";
    if(type == DAMAGE_TYPE_PSYCHIC) return "assaulted";
    if(type == DAMAGE_TYPE_RADIANT) return "raptured";
    if(type == DAMAGE_TYPE_SLASHING) return "slashed";
    if(type == DAMAGE_TYPE_SONIC) return "ruptured";
    if(type == DAMAGE_TYPE_EMOTIONAL) return "traumatised";
    if(type == DAMAGE_TYPE_MEDICAL) return "healed";
    if(type == DAMAGE_TYPE_REPAIR) return "repaired";
    if(type == DAMAGE_TYPE_EXPLOSIVE) return "exploded";
    if(type == DAMAGE_TYPE_CRUSHING) return "crushed";
    if(type == DAMAGE_TYPE_ANTI_ARMOR) return "punched through";
    if(type == DAMAGE_TYPE_SUFFOCATION) return "suffocated";
    if(type == DAMAGE_TYPE_REDEPLOY) return "redeployed";
    return "damaged";
}

// Returns PRIM_TEXTURE params for rendering the damage type as an icon
list DamageTypeAsIcon(integer type)
{
    vector offset; integer variant = (integer)llFrand(32.0);
    if(type == DAMAGE_TYPE_IMPACT) offset = <variant % 4, 0, 0>;
    else if(type == DAMAGE_TYPE_GENERIC) offset = <4, 0, 0>;
    else if(type == DAMAGE_TYPE_ACID)  offset = <5, 0, 0>;
    else if(type == DAMAGE_TYPE_BLUDGEONING)  offset = <6, 0, 0>;
    else if(type == DAMAGE_TYPE_COLD)  offset = <7, 0, 0>;
    else if(type == DAMAGE_TYPE_ELECTRIC)  offset = <8, 0, 0>;
    else if(type == DAMAGE_TYPE_FIRE)  offset = <9, 0, 0>;
    else if(type == DAMAGE_TYPE_FORCE)  offset = <10, 0, 0>;
    else if(type == DAMAGE_TYPE_NECROTIC)  offset = <11, 0, 0>;
    else if(type == DAMAGE_TYPE_PIERCING)  offset = <12, 0, 0>;
    else if(type == DAMAGE_TYPE_POISON)  offset = <13, 0, 0>;
    else if(type == DAMAGE_TYPE_PSYCHIC)  offset = <14, 0, 0>;
    else if(type == DAMAGE_TYPE_RADIANT)  offset = <15, 0, 0>;
    else if(type == DAMAGE_TYPE_SLASHING)  offset = <0, 1, 0>;
    else if(type == DAMAGE_TYPE_SONIC)  offset = <1 + (variant % 2), 1, 0>;
    else if(type == DAMAGE_TYPE_EMOTIONAL)  offset = <3, 1, 0>;
    else if(type == DAMAGE_TYPE_MEDICAL)  offset = <4 + (variant % 2), 1, 0>;
    else if(type == DAMAGE_TYPE_REPAIR)  offset = <6 + (variant % 2), 1, 0>;
    else if(type == DAMAGE_TYPE_EXPLOSIVE)  offset = <8, 1, 0>;
    else if(type == DAMAGE_TYPE_CRUSHING)  offset = <9, 1, 0>;
    else if(type == DAMAGE_TYPE_ANTI_ARMOR)  offset = <10, 1, 0>;
    else if(type == DAMAGE_TYPE_SUFFOCATION)  offset = <12, 1, 0>;
    else if(type == DAMAGE_TYPE_REDEPLOY) offset = <8, 3, 0>;
    
    // These are not damage types but additional icons related to combat
    else if(type == -100) offset = <0, 3, 0>; // Death
    else if(type == -101) offset = <1, 3, 0>; // Enemy Death
    else if(type == -102) offset = <2, 3, 0>; // Friendly Death
    else if(type == -103) offset = <3, 3, 0>; // Object Death
    else if(type == -104) offset = <4, 3, 0>; // Vehicle Death
    else if(type == -105) offset = <5, 3, 0>; // Aircraft Death
    else if(type == -106) offset = <6, 3, 0>; // Unconscious/Downed
    else if(type == -107) offset = <7, 3, 0>; // Revive Requested
    else if(type == -108) offset = <8, 3, 0>; // Being Revived
    
    /*
        Potential other icons:
        - Respawn, Redeploy
        - Mech Death
        - Shield Hit, Armor Hit, Critical Hit, EMP Hit
        - Critical Hit, Enemy Critical Hit, Friendly Critical Hit
        - Blocked Hit, Enemy Blocked Hit, Friendly Blocked Hit
        - Missed Hit, Enemy Missed Hit, Friendly Missed Hit
        - Civilian Down, Enemy Down, Friendly Down
        - Kill Assist
        - Headshot
        - Target Locked, Target Lost
        - Out of Ammo, Low Ammo, Reloading
        - Overheated, Jammed, Hacked, Disarmed, Suppressed, Spotted, Invisible
        - Invulnerable, Vulnerable
        - Buffed, Debuffed
    */
    
    return [
        "2d053029-7baa-104d-fd8e-34b2112b4b78",
        <128./2048., 128./512., 0>,
        <(offset.x - 7.5) / 16, (1.5 - offset.y) / 4, 0>,
        0
    ];
}

string DamageTypeAsReason(integer type)
{
    #define FRIENDLY_FIRE [\
        "OWNER confirmed TARGET as 'probably hostile'",\
        "TARGET was eliminated by OWNER's outstanding target identification skills",\
        "OWNER won the team's internal conflict against TARGET",\
        "TARGET discovered OWNER's IFF system was decorative",\
        "OWNER engaged the nearest available lifeform: TARGET",\
        "TARGET fell to allied fire from OWNER. Emphasis on allied",\
        "OWNER mistook TARGET for a tactical opportunity",\
        "TARGET was killed by OWNER's aggressive interpretation of teamwork",\
        "OWNER secured a friendly kill on TARGET. Mission unclear",\
        "TARGET learned not to stand between OWNER and bad decisions",\
        "OWNER demonstrated why positive identification matters TARGET objected briefly",\
        "TARGET walked into OWNER's extremely friendly burst fire",\
        "TARGET caught OWNER's suppressive fire non-suppressed",\
        "TARGET discovered OWNER's safety selector was permanently set to optimism",\
        "OWNER found TARGET faster than the enemy",\
        "OWNER introduced TARGET to friendly fire",\
        "OWNER secured an enemy-adjacent kill on TARGET",\
        "TARGET was promoted to hostile by OWNER",\
        "OWNER carried the enemy team by killing TARGET",\
        "TARGET lost an internal faction dispute with OWNER",\
        "OWNER treated TARGET like hostile armor",\
        "TARGET was killed by OWNER's unwavering confidence and limited accuracy",\
        "TARGET walked directly into OWNER's line of fire",\
        "OWNER killed TARGET after TARGET challenged basic firearm safety",\
        "TARGET aggressively occupied OWNER's muzzle space",\
        "OWNER shot TARGET, who appeared suddenly and unhelpfully",\
        "TARGET crossed in front of OWNER's burst fire and won a prize",\
        "OWNER eliminated TARGET, who selected poor timing as a lifestyle",\
        "TARGET intercepted rounds clearly intended for somebody else",\
        "OWNER's bullets met TARGET halfway",\
        "TARGET inserted themselves into OWNER's tactical problem",\
        "OWNER killed TARGET after TARGET performed unauthorized bullet interception",\
        "TARGET peeked exactly where OWNER was already shooting",\
        "OWNER dropped TARGET, who entered the doorway at maximum inconvenience",\
        "TARGET hugged the enemy while OWNER was engaging the enemy",\
        "OWNER's suppressive fire was suppressed by TARGET's positioning",\
        "TARGET discovered why you don't cross the firing lane OWNER demonstrated",\
        "OWNER secured a friendly kill after TARGET sprinted through active gunfire",\
        "TARGET performed close-quarters teamwork incorrectly near OWNER",\
        "OWNER shot TARGET, who materialized directly in the optic picture",\
        "TARGET tested OWNER's trigger discipline at point-blank range",\
        "OWNER accidentally fulfilled TARGET's request for covering fire",\
        "TARGET treated OWNER's firing lane as a shortcut",\
        "OWNER killed TARGET, who confused suppressive fire with navigational guidance",\
        "TARGET successfully identified where OWNER was shooting by standing there",\
        "OWNER eliminated TARGET after TARGET ignored several visible warning signs",\
        "TARGET attempted advanced teamwork without situational awareness. OWNER intervened",\
        "OWNER shot TARGET, who committed aggressively to being in the way",\
        "TARGET became an unexpected variable in OWNER's ballistic calculations",\
        "OWNER's aim was fine. TARGET's pathfinding was not",\
        "TARGET inserted themselves between OWNER and success",\
        "OWNER killed TARGET after TARGET made themselves tactically unavoidable"\
    ]
    #define IMPACT [\
        "TARGET punched the ground. The ground punched back",\
        "TARGET tested the structural integrity of a nearby wall",\
        "TARGET tested the structural integrity of a nearby floor",\
        "TARGET tested the structural integrity of a nearby ceiling",\
        "TARGET discovered the upper limit of their movement enhancer",\
        "TARGET achieved terminal mobility",\
        "TARGET mistook momentum for a survival strategy",\
        "TARGET lost a close-quarters engagement with the terrain",\
        "TARGET deployed directly into solid matter",\
        "TARGET accelerated confidently into disaster",\
        "TARGET's movement tech delivered exactly as advertised",\
        "TARGET learned that velocity has consequences",\
        "TARGET attempted advanced maneuvering without adult supervision",\
        "TARGET converted speed into an immediate medical issue",\
        "TARGET overshot the objective by several meters and one life",\
        "TARGET used tactical sprint offensively against themselves",\
        "TARGET was outplayed by basic map geometry",\
        "TARGET trusted the jump pack. The jump pack disagreed",\
        "TARGET discovered an undocumented interaction between boosters and concrete",\
        "TARGET briefly achieved flight before remembering they weren't aviation-capable",\
        "TARGET's landing request was denied by physics",\
        "TARGET found the map boundary emotionally and physically",\
        "TARGET turned mobility equipment into a kinetic weapon against TARGET",\
        "TARGET's combat stim demanded speed; the wall accepted payment",\
        "TARGET exceeded recommended operating velocity",\
        "TARGET weaponized their own momentum",\
        "TARGET slammed into cover with unnecessary enthusiasm",\
        "TARGET's parkour certification has been revoked",\
        "TARGET hit mach jesus and forgot the braking phase",\
        "TARGET went from combatant to projectile",\
        "TARGET speedran the respawn screen",\
        "TARGET demonstrated why boosters come with warning labels",\
        "TARGET challenged Newtonian mechanics and lost unanimously",\
        "TARGET's movement enhancer secured a confirmed kill",\
        "TARGET achieved excellent airtime and poor decision-making",\
        "TARGET discovered a new route directly into the ground",\
        "TARGET attempted vertical gameplay and received horizontal consequences",\
        "TARGET became one with nearby infrastructure",\
        "OWNER knocked TARGET into a wall",\
        "TARGET slammed into cover after OWNER's attack",\
        "OWNER sent TARGET crashing into terrain",\
        "TARGET hit the ground hard thanks to OWNER",\
        "OWNER forced TARGET into a fatal collision",\
        "TARGET lost momentum after meeting OWNER's fire",\
        "OWNER knocked TARGET off balance and into solid concrete",\
        "TARGET pancaked into the environment under pressure from OWNER",\
        "OWNER turned gravity against TARGET",\
        "TARGET lost a high-speed argument with physics courtesy of OWNER"\
    ]
    #define GENERIC [\
        "OWNER killed TARGET",\
        "TARGET was eliminated by OWNER",\
        "OWNER took down TARGET",\
        "TARGET was neutralized by OWNER",\
        "OWNER removed TARGET from the battlefield",\
        "TARGET fell to OWNER",\
        "OWNER dropped TARGET",\
        "TARGET was defeated by OWNER",\
        "OWNER finished TARGET",\
        "TARGET was taken out by OWNER"\
    ]
    #define ACID [\
        "OWNER dissolved TARGET with corrosives",\
        "TARGET melted under OWNER's chemical attack",\
        "OWNER splashed TARGET with lethal acid",\
        "TARGET succumbed to OWNER's corrosive payload",\
        "OWNER reduced TARGET's gear to sludge",\
        "TARGET was chemically erased by OWNER",\
        "OWNER turned chemistry into a weapon against TARGET",\
        "TARGET couldn't withstand OWNER's acid attack",\
        "OWNER corroded TARGET beyond repair",\
        "TARGET dissolved under OWNER's assault"\
    ]
    #define BLUDGEONING [\
        "OWNER beat TARGET down",\
        "TARGET was crushed by OWNER's blunt force",\
        "OWNER smashed TARGET into submission",\
        "TARGET took a fatal blunt hit from OWNET",\
        "OWNER battered TARGET into the dirt",\
        "TARGET was flattened by OWNER",\
        "OWNER hammered TARGET",\
        "TARGET couldn't survive OWNER's heavy impact",\
        "OWNER delivered overwhelming blunt trauma to TARGET",\
        "TARGET was broken by OWNER's strike"\
    ]
    #define COLD [\
        "OWNER froze TARGET solid",\
        "TARGET succumbed to OWNER's cryogenic attack",\
        "OWNER chilled TARGET beyond recovery",\
        "TARGET iced over under OWNER's assault",\
        "OWNER turned TARGET into a frozen casualty",\
        "TARGET could not survive OWNER's cold exposure",\
        "OWNER locked TARGET down with extreme cold",\
        "TARGET froze to death fighting OWNER",\
        "OWNER weaponized winter against TARGET",\
        "TARGET lost the heat war against OWNER"\
    ]
    #define ELECTRIC [\
        "OWNER electrocuted TARGET",\
        "TARGET was shocked to death by OWNER",\
        "OWNER overloaded TARGET with electricity",\
        "TARGET caught lethal voltage from OWNER",\
        "OWNER lit TARGET up with electrical discharge",\
        "TARGET's nervous system failed under OWNER's attack",\
        "OWNER short-circuited TARGET",\
        "TARGET couldn't handle OWNER's high-voltage solution",\
        "OWNER fried TARGET",\
        "TARGET sparked out under OWNER's assault"\
    ]
    #define FIRE [\
        "OWNER burned TARGET alive",\
        "TARGET was incinerated by OWNER",\
        "OWNER engulfed TARGET in flames",\
        "TARGET cooked under OWNER's incendiaries",\
        "OWNER reduced TARGET to ashes",\
        "TARGET caught fire thanks to OWNER",\
        "OWNER scorched TARGET off the battlefield",\
        "TARGET lost the thermal exchange with OWNER",\
        "OWNER roasted TARGET",\
        "TARGET was consumed by OWNER's flames"\
    ]
    #define FORCE [\
        "OWNER blasted TARGET apart",\
        "TARGET was launched by OWNER's attack",\
        "OWNER overwhelmed TARGET with raw force",\
        "TARGET absorbed a fatal shockwave from OWNER",\
        "OWNER hit TARGET with devastating force",\
        "TARGET couldn't withstand OWNER's impact",\
        "OWNER violently displaced TARGET",\
        "TARGET got freight-trained by OWNER",\
        "OWNER crushed TARGET with concussive power",\
        "TARGET was blown back by OWNER"\
    ]
    #define NECROTIC [\
        "OWNER drained the life from TARGET",\
        "TARGET withered under OWNER's attack",\
        "OWNER consumed TARGET's vitality",\
        "TARGET decayed under OWNER's assault",\
        "OWNER left TARGET biologically ruined",\
        "TARGET faded under OWNER's lethal touch",\
        "OWNER reduced TARGET to a husk",\
        "TARGET's life force failed against OWNER",\
        "OWNER brought slow death to TARGET",\
        "TARGET succumbed to OWNER's necrotic damage"\
    ]
    #define PIERCING [\
        "OWNER riddled TARGET with bullets",\
        "TARGET was cut down by OWNER's rifle fire",\
        "OWNER stitched TARGET with automatic fire",\
        "TARGET caught a burst from OWNER",\
        "OWNER perforated TARGET with incoming rounds",\
        "TARGET was drilled by OWNER's gunfire",\
        "OWNER landed center-mass hits on TARGET",\
        "TARGET lost the firefight against OWNER",\
        "OWNER filled TARGET with lead",\
        "TARGET was perforated by OWNER"\
    ]
    #define POISON [\
        "OWNER poisoned TARGET",\
        "TARGET succumbed to OWNER's toxins",\
        "OWNER contaminated TARGET fatally",\
        "TARGET deteriorated under OWNER's chemicals",\
        "OWNER dosed TARGET with lethal poison",\
        "TARGET's body gave out under OWNER's attack",\
        "OWNER weaponized toxins against TARGET",\
        "TARGET couldn't survive OWNER's poison",\
        "OWNER delivered a toxic end to TARGET",\
        "TARGET died from OWNER's chemical exposure"\
    ]
    #define PSYCHIC [\
        "OWNER shattered TARGET's mind",\
        "TARGET suffered mental collapse under OWNER",\
        "OWNER overwhelmed TARGET psychologically",\
        "TARGET's thoughts failed against OWNER",\
        "OWNER broke TARGET mentally",\
        "TARGET lost the cognitive battle with OWNER",\
        "OWNER overloaded TARGET's mind",\
        "TARGET was psychologically neutralized by OWNER",\
        "OWNER destabilized TARGET completely",\
        "TARGET couldn't process OWNER's assault"\
    ]
    #define RADIANT [\
        "OWNER overwhelmed TARGET with radiant energy",\
        "TARGET was burned by OWNER's radiation",\
        "OWNER blasted TARGET with destructive light",\
        "TARGET glowed briefly thanks to OWNER",\
        "OWNER irradiated TARGET fatally",\
        "TARGET succumbed to OWNER's energy discharge",\
        "OWNER seared TARGET with pure energy",\
        "TARGET lost against OWNER's radiance",\
        "OWNER exposed TARGET to lethal radiation",\
        "TARGET was annihilated by OWNER's energy"\
    ]
    #define SLASHING [\
        "OWNER cut TARGET down",\
        "TARGET was carved apart by OWNER",\
        "OWNER opened TARGET up",\
        "TARGET met OWNER's blade",\
        "OWNER sliced through TARGET",\
        "TARGET suffered fatal cuts from OWNER",\
        "OWNER shredded TARGET",\
        "TARGET was torn apart by OWNER",\
        "OWNER made short work of TARGET",\
        "TARGET found the sharp end of OWNER"\
    ]
    #define SONIC [\
        "OWNER blasted TARGET with sonic force",\
        "TARGET's senses collapsed under OWNER's attack",\
        "OWNER overwhelmed TARGET with pressure waves",\
        "TARGET couldn't survive OWNER's sonic blast",\
        "OWNER deafened TARGET permanently",\
        "TARGET was rocked by OWNER's acoustic weaponry",\
        "OWNER weaponized sound against TARGET",\
        "TARGET lost the volume war against OWNER",\
        "OWNER shattered TARGET with sonic energy",\
        "TARGET was concussed by OWNER's sonic assault"\
    ]
    #define EMOTIONAL [\
        "OWNER emotionally devastated TARGET",\
        "TARGET's morale collapsed under OWNER",\
        "OWNER broke TARGET's spirit",\
        "TARGET suffered critical emotional damage from OWNER",\
        "OWNER crushed TARGET's confidence",\
        "TARGET lost the psychological war with OWNER",\
        "OWNER destroyed TARGET's morale",\
        "TARGET couldn't recover from OWNER's pressure",\
        "OWNER left TARGET mentally defeated",\
        "TARGET took the loss from OWNER personally"\
    ]
    #define MEDICAL [\
        "OWNER's treatment killed TARGET",\
        "TARGET did not survive OWNER's medical intervention",\
        "OWNER flatlined TARGET during treatment",\
        "TARGET received one medic too many from OWNER",\
        "OWNER's battlefield medicine failed TARGET catastrophically",\
        "TARGET died under OWNER's care",\
        "OWNER healed TARGET into the afterlife",\
        "TARGET trusted OWNER's medkit incorrectly",\
        "OWNER's treatment proved terminal for TARGET",\
        "TARGET was medically neutralized by OWNER"\
    ]
    #define REPAIR [\
        "OWNER repaired TARGET into catastrophic failure",\
        "TARGET did not survive OWNER's maintenance",\
        "OWNER's field repairs ended TARGET",\
        "TARGET experienced rapid unscheduled disassembly by OWNER",\
        "OWNER pushed TARGET beyond operational limits",\
        "TARGET failed under OWNER's repair attempt",\
        "OWNER turned maintenance into a kill",\
        "TARGET's systems collapsed under OWNER's adjustments",\
        "OWNER overclocked TARGET to destruction",\
        "TARGET became nonfunctional thanks to OWNER"\
    ]
    #define EXPLOSIVE [\
        "OWNER blew TARGET apart",\
        "TARGET was caught in OWNER's blast radius",\
        "OWNER introduced TARGET to high explosives",\
        "TARGET ate OWNER's grenade",\
        "OWNER detonated TARGET",\
        "TARGET couldn't outrun OWNER's explosives",\
        "OWNER erased TARGET with a blast",\
        "TARGET was shredded by OWNER's detonation",\
        "OWNER reduced TARGET to debris",\
        "TARGET stood too close to OWNER's ordnance"\
    ]
    #define CRUSHING [\
        "OWNER crushed TARGET",\
        "TARGET was flattened by OWNER",\
        "OWNER compressed TARGET into failure",\
        "TARGET was pinned and crushed by OWNER",\
        "OWNER turned pressure into a weapon against TARGET",\
        "TARGET folded under OWNER's force",\
        "OWNER reduced TARGET to scrap",\
        "TARGET was compacted by OWNER",\
        "OWNER buried TARGET under overwhelming pressure",\
        "TARGET lost the compression test against OWNER"\
    ]
    #define ANTI_ARMOR [\
        "OWNER punched through TARGET's armor",\
        "TARGET was penetrated by OWNER's anti-armor fire",\
        "OWNER defeated TARGET with AP rounds",\
        "TARGET's armor failed against OWNER",\
        "OWNER cracked TARGET open with anti-vehicle fire",\
        "TARGET couldn't stop OWNER's penetrators",\
        "OWNER turned TARGET's armor into a liability",\
        "TARGET was gutted by OWNER's heavy ordnance",\
        "OWNER landed a clean anti-armor kill on TARGET",\
        "TARGET lost the armor check against OWNER"\
    ]
    #define SUFFOCATION [\
        "OWNER deprived TARGET of oxygen",\
        "TARGET suffocated because of OWNER",\
        "OWNER left TARGET without breathable air",\
        "TARGET ran out of air fighting OWNER",\
        "OWNER choked the life out of TARGET",\
        "TARGET couldn't breathe under OWNER's attack",\
        "OWNER turned atmosphere into a privilege TARGET didn't have",\
        "TARGET lost oxygen access thanks to OWNER",\
        "OWNER asphyxiated TARGET",\
        "TARGET forgot breathing was mandatory while fighting OWNER"\
    ]
    #define REDEPLOY [\
        "TARGET redeployed to a new position",\
        "TARGET returned to the deployment queue",\
        "TARGET chose to redeploy",\
        "TARGET cycled back to spawn",\
        "TARGET withdrew for redeployment",\
        "TARGET repositioned via redeploy",\
        "TARGET abandoned the current position",\
        "TARGET respawned elsewhere",\
        "TARGET reset their tactical situation",\
        "TARGET redeployed out of the combat zone",\
        "TARGET took the express route back to spawn",\
        "TARGET performed a tactical respawn",\
        "TARGET sought better life choices via redeploy",\
        "TARGET changed their mind — and location",\
        "TARGET performed tactical disappearance",\
        "TARGET reconsidered their surroundings",\
        "TARGET pressed the redeploy button",\
        "TARGET found a more survivable ZIP code",\
        "TARGET left to spawn somewhere less explosive",\
        "TARGET took a strategic timeout"\
    ]
    
    integer variant = (integer)llFrand(64.0);
    if(type == DAMAGE_TYPE_IMPACT) return llList2String(IMPACT, variant % 48);
    if(type == DAMAGE_TYPE_GENERIC) return llList2String(GENERIC, variant % 10);
    if(type == DAMAGE_TYPE_ACID) return llList2String(ACID, variant % 10);
    if(type == DAMAGE_TYPE_BLUDGEONING) return llList2String(BLUDGEONING, variant % 10);
    if(type == DAMAGE_TYPE_COLD) return llList2String(COLD, variant % 10);
    if(type == DAMAGE_TYPE_ELECTRIC) return llList2String(ELECTRIC, variant % 10);
    if(type == DAMAGE_TYPE_FIRE) return llList2String(FIRE, variant % 10);
    if(type == DAMAGE_TYPE_FORCE) return llList2String(FORCE, variant % 10);
    if(type == DAMAGE_TYPE_NECROTIC) return llList2String(NECROTIC, variant % 10);
    if(type == DAMAGE_TYPE_PIERCING) return llList2String(PIERCING, variant % 10);
    if(type == DAMAGE_TYPE_POISON) return llList2String(POISON, variant % 10);
    if(type == DAMAGE_TYPE_PSYCHIC) return llList2String(PSYCHIC, variant % 10);
    if(type == DAMAGE_TYPE_RADIANT) return llList2String(RADIANT, variant % 10);
    if(type == DAMAGE_TYPE_SLASHING) return llList2String(SLASHING, variant % 10);
    if(type == DAMAGE_TYPE_SONIC) return llList2String(SONIC, variant % 10);
    if(type == DAMAGE_TYPE_EMOTIONAL) return llList2String(EMOTIONAL, variant % 10);
    if(type == DAMAGE_TYPE_MEDICAL) return llList2String(MEDICAL, variant % 10);
    if(type == DAMAGE_TYPE_REPAIR) return llList2String(REPAIR, variant % 10);
    if(type == DAMAGE_TYPE_EXPLOSIVE) return llList2String(EXPLOSIVE, variant % 10);
    if(type == DAMAGE_TYPE_CRUSHING) return llList2String(CRUSHING, variant % 10);
    if(type == DAMAGE_TYPE_ANTI_ARMOR) return llList2String(ANTI_ARMOR, variant % 10);
    if(type == DAMAGE_TYPE_SUFFOCATION) return llList2String(SUFFOCATION, variant % 10);
    if(type == DAMAGE_TYPE_REDEPLOY) return llList2String(REDEPLOY, variant % 20);
    if(type == -100) return llList2String(FRIENDLY_FIRE, variant % 52);
    return "TARGET was killed by OWNER's " + DamageTypeAsNoun(type) + " damage";
}


/*
How to apply anti-armor damage in Combat2, with compatibility fallback to LBA (Listen Based Armor):

// Anti-Armor damage
if(llGetHealth(target) > 0) llDamage(target, damage, DAMAGE_TYPE_ANTI_ARMOR);
else
{
    // LBA damage fallback
    string desc = (string)llGetObjectDetails(target, [OBJECT_DESC]);
    if(llGetSubString(desc, 0, 5) == "LBA.v.")
    {
        integer channelLBA = integer("0x" + llGetSubString(llMD5String(target, 0), 0, 3));
        llRegionSayTo(target, channelLBA, target + "," + (string)damage);
    }
}


Alternatively if you have llDetectedType available, such as from a collision or a sensor,
use that instead of llGetHealth as you can check for DAMAGEABLE which is better, as it
signifies the object can actually *process damage*

*/