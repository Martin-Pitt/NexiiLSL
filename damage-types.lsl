#define DAMAGE_TYPE_MEDICAL 100
#define DAMAGE_TYPE_REPAIR 101
#define DAMAGE_TYPE_EXPLOSIVE 102
#define DAMAGE_TYPE_CRUSHING 103
#define DAMAGE_TYPE_ANTI_ARMOR 104
#define DAMAGE_TYPE_SUFFOCATION 105

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
    return (string)type;
}

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
    return "unknown";
}

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
    return "damaged";
}

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
    
    // These are not damage types but additional icons related to combat
    else if(type == -100) offset = <0, 3, 0>; // Death
    else if(type == -101) offset = <1, 3, 0>; // Enemy Death
    else if(type == -102) offset = <2, 3, 0>; // Friendly Death
    else if(type == -103) offset = <3, 3, 0>; // Object Death
    else if(type == -104) offset = <4, 3, 0>; // Vehicle Death
    else if(type == -105) offset = <5, 3, 0>; // Aircraft Death
    
    return [
        "808176f8-c8c4-c17c-4509-cf7598ea2186",
        <128./2048., 128./512., 0>,
        <(offset.x - 7.5) / 16, (1.5 - offset.y) / 4, 0>,
        0
    ];
}

/*
How to apply anti-armor damage with LBA compatibility:

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

*/