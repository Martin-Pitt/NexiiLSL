#define DAMAGE_TYPE_MEDICAL 100
#define DAMAGE_TYPE_REPAIR 101
#define DAMAGE_TYPE_EXPLOSIVE 102
#define DAMAGE_TYPE_CRUSHING 103
#define DAMAGE_TYPE_ANTI_ARMOR 104

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
    if(type == DAMAGE_TYPE_PIERCING) return "piercing";
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
    return "";
}

string DamageTypeAsVerb(integer type)
{
    //if(type == DAMAGE_TYPE_IMPACT) return "impacted";
    //if(type == DAMAGE_TYPE_GENERIC) return "damaged";
    //if(type == DAMAGE_TYPE_ACID) return "acid?";
    if(type == DAMAGE_TYPE_BLUDGEONING) return "bludgeoned";
    if(type == DAMAGE_TYPE_COLD) return "frozen";
    if(type == DAMAGE_TYPE_ELECTRIC) return "electrocuted";
    if(type == DAMAGE_TYPE_FIRE) return "burnt";
    //if(type == DAMAGE_TYPE_FORCE) return "forced?";
    //if(type == DAMAGE_TYPE_NECROTIC) return "nectrotic?";
    if(type == DAMAGE_TYPE_PIERCING) return "pierced";
    if(type == DAMAGE_TYPE_POISON) return "poisoned";
    //if(type == DAMAGE_TYPE_PSYCHIC) return "psychic?";
    //if(type == DAMAGE_TYPE_RADIANT) return "radiant?";
    if(type == DAMAGE_TYPE_SLASHING) return "slashed";
    //if(type == DAMAGE_TYPE_SONIC) return "sonic?";
    //if(type == DAMAGE_TYPE_EMOTIONAL) return "emotional?";
    if(type == DAMAGE_TYPE_MEDICAL) return "healed";
    if(type == DAMAGE_TYPE_REPAIR) return "repaired";
    if(type == DAMAGE_TYPE_EXPLOSIVE) return "exploded";
    if(type == DAMAGE_TYPE_CRUSHING) return "crushed";
    //if(type == DAMAGE_TYPE_ANTI_ARMOR) return "anti-armor?";
    return "";
}
