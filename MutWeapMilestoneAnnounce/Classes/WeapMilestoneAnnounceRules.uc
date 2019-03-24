//------------------------------------------------------------------------------
// Takes care of catching the actual kill notifications for us.
//------------------------------------------------------------------------------
class WeapMilestoneAnnounceRules extends GameRules;

#exec OBJ LOAD FILE="..\Sounds\MutWeapMilestoneAnnounce_Snd.uax"

struct _PlayerDamageData
{
    var Controller C;
    var class<DamageType> LastDamageType;
    var int ShieldGunCount, AssaultRifleCount, BioRifleCount, MinigunCount,
     LinkGunCount, RocketLauncherCount, AVRiLCount, HeadCount, ShomboCount,
      FlakCount, NodeCount;
};
var array<_PlayerDamageData> DamageData;
var sound ShieldGunAnnounce, AssaultRifleAnnounce, BioRifleAnnounce, MinigunAnnounce,
 LinkGunAnnounce, RocketLauncherAnnounce, AVRiLAnnounce, NodeBusterAnnounce,
  HeadHunterAnnounce,FlakCannonAnnounce, ShomboAnnounce, JuggernautAnnounce,
   UnrealAnnounce, BullsEyeAnnounce;

const AWARD_COUNT = 15;
const UNREAL_AWARD_COUNT = 30;
const AWARD_MESSAGE_DELAY = 15;
const DUAL_AWARD_MESSAGE_DELAY = 32;

function PostBeginPlay()
{
    if ( Level.Game.GameRulesModifiers == None )
        Level.Game.GameRulesModifiers = self;
    else
        Level.Game.GameRulesModifiers.AddGameRules(self);

    // Make sure clients have the sounds available!
    AddToPackageMap("MutWeapMilestoneAnnounce_Snd.uax");
}


function ScoreKill(Controller Killer, Controller Killed)
{
    local int i;

    if (Killer != Killed && UnrealPlayer(Killer) != None && Killed != None)
    {
        for (i = 0; i < DamageData.Length; i++)
        {
            if (DamageData[i].C == Killed)
            {
                CheckDamageType(Killer, DamageData[i].LastDamageType);
                break;
            }
            else if (DamageData[i].C == None)
            {
                DamageData.Remove(i, 1);
                i--;
            }
        }

    }

    if ( NextGameRules != None )
        NextGameRules.ScoreKill(Killer,Killed);
}

// Increase an individual player's kill counter with a specific weapon if he killed someone with it.
function CheckDamageType(Controller Killer, class<DamageType> DmgType)
{
    local int i;
    local _PlayerDamageData NewStruct;

    for (i = 0; i < DamageData.Length; i++)
    {
        if (DamageData[i].C == Killer)
        {
            if (ClassIsChildOf(DmgType, class'DamTypeAssaultBullet'))
            {
                DamageData[i].AssaultRifleCount++;
                if (DamageData[i].AssaultRifleCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(AssaultRifleAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].AssaultRifleCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(AssaultRifleAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeBioGlob'))
            {
                DamageData[i].BioRifleCount++;
                if (DamageData[i].BioRifleCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(BioRifleAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].BioRifleCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(BioRifleAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeLinkShaft'))
            {
                DamageData[i].LinkGunCount++;
                if (DamageData[i].LinkGunCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(LinkGunAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].LinkGunCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(LinkGunAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeShieldImpact'))
            {
                DamageData[i].ShieldGunCount++;
                if (DamageData[i].ShieldGunCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(ShieldGunAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].ShieldGunCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(ShieldGunAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeRocket'))
            {
                DamageData[i].RocketLauncherCount++;
                if (DamageData[i].RocketLauncherCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(RocketLauncherAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].RocketLauncherCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(RocketLauncherAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeONSAVRiLRocket'))
            {
                DamageData[i].AVRiLCount++;
                if (DamageData[i].AVRiLCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(AVRiLAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].AVRiLCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(AVRiLAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeMinigunBullet'))
            {
                DamageData[i].MinigunCount++;
                if (DamageData[i].MinigunCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(MinigunAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].MinigunCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(MinigunAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeShockCombo'))
            {
                DamageData[i].ShomboCount++;
                if (DamageData[i].ShomboCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(ShomboAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeFlakChunk'))
            {
                DamageData[i].FlakCount++;
                if (DamageData[i].FlakCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(FlakCannonAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeClassicHeadshot') || ClassIsChildOf(DmgType, class'DamTypeSniperHeadshot'))
            {
                DamageData[i].HeadCount++;
                if (DamageData[i].HeadCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(HeadHunterAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeTelefragged'))
            {
                UnrealPlayer(Killer).ClientDelayedAnnouncement(BullsEyeAnnounce, AWARD_MESSAGE_DELAY); // Yeah, being creative…
            }
            return;
        }
        else if (DamageData[i].C == None)
        {
            DamageData.Remove(i, 1);
            i--;
        }
    }

    // Don't have it yet? Add a struct and try again!
    NewStruct.C = Killer;
    DamageData[DamageData.Length] = NewStruct;

    for (i = 0; i < DamageData.Length; i++)
    {
        if (DamageData[i].C == Killer)
        {
            if (ClassIsChildOf(DmgType, class'DamTypeAssaultBullet'))
            {
                DamageData[i].AssaultRifleCount++;
                if (DamageData[i].AssaultRifleCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(AssaultRifleAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].AssaultRifleCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(AssaultRifleAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeBioGlob'))
            {
                DamageData[i].BioRifleCount++;
                if (DamageData[i].BioRifleCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(BioRifleAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].BioRifleCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(BioRifleAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeLinkShaft'))
            {
                DamageData[i].LinkGunCount++;
                if (DamageData[i].LinkGunCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(LinkGunAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].LinkGunCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(LinkGunAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeShieldImpact'))
            {
                DamageData[i].ShieldGunCount++;
                if (DamageData[i].ShieldGunCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(ShieldGunAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].ShieldGunCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(ShieldGunAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeRocket'))
            {
                DamageData[i].RocketLauncherCount++;
                if (DamageData[i].RocketLauncherCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(RocketLauncherAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].RocketLauncherCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(RocketLauncherAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeONSAVRiLRocket'))
            {
                DamageData[i].AVRiLCount++;
                if (DamageData[i].AVRiLCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(AVRiLAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].AVRiLCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(AVRiLAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeMinigunBullet'))
            {
                DamageData[i].MinigunCount++;
                if (DamageData[i].MinigunCount == AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(MinigunAnnounce, AWARD_MESSAGE_DELAY);
                }
                else if (DamageData[i].MinigunCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(MinigunAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeShockCombo'))
            {
                DamageData[i].ShomboCount++;
                if (DamageData[i].ShomboCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(ShomboAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeFlakChunk'))
            {
                DamageData[i].FlakCount++;
                if (DamageData[i].FlakCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(FlakCannonAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeClassicHeadshot') || ClassIsChildOf(DmgType, class'DamTypeSniperHeadshot'))
            {
                DamageData[i].HeadCount++;
                if (DamageData[i].HeadCount == UNREAL_AWARD_COUNT)
                {
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                    UnrealPlayer(Killer).ClientDelayedAnnouncement(HeadHunterAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                }
            }
            else if (ClassIsChildOf(DmgType, class'DamTypeTelefragged'))
            {
                UnrealPlayer(Killer).ClientDelayedAnnouncement(BullsEyeAnnounce, AWARD_MESSAGE_DELAY); // Yeah, being creative…
            }
            return;
        }
    }
}

// Catch what damagetype is going to cause a player's death.
function bool PreventDeath(Pawn Killed, Controller Killer, class<DamageType> damageType, vector HitLocation)
{
    if (NextGameRules != None && NextGameRules.PreventDeath(Killed,Killer, damageType,HitLocation))
        return True;
    else
    {
        if (Killed != None && Killed.Controller != None)
            AddDamageType(Killed.Controller, DamageType);

        return False;
    }
}

// Remembers the last damagetype that a player got hurt by before he's likely to die.
function AddDamageType(Controller Playa, class<DamageType> DamType)
{
    local int i;
    local _PlayerDamageData NewStruct;

    for (i = 0; i < DamageData.Length; i++)
    {
        if (DamageData[i].C == Playa)
        {
            DamageData[i].LastDamageType = DamType;
            return;
        }
        else if (DamageData[i].C == None)
        {
            DamageData.Remove(i, 1);
            i--;
        }
    }
    NewStruct.C = Playa;
    NewStruct.LastDamageType = DamType;
    DamageData[DamageData.Length] = NewStruct;
}



/* OverridePickupQuery()
when pawn wants to pickup something, gamerules given a chance to modify it.  If this function
returns true, bAllowPickup will determine if the object can be picked up.

In this modified version are we simply checking for as many indicators as possible
that could make a player be considered an "overpowered juggernaut".
Namely having a UDamage or adrenaline combo while picking up another super powerup.
*/
function bool OverridePickupQuery(Pawn Other, Pickup item, out byte bAllowPickup)
{
    if (UnrealPlayer(Other.Controller) != None)
    {
        if (TournamentPickup(item) != None && (item.IsSuperItem() || item.MaxDesireability >= 2.f) && IsPoweredUp(Other))
        {
            UnrealPlayer(Other.Controller).ClientDelayedAnnouncement(JuggernautAnnounce, AWARD_MESSAGE_DELAY);
        }
    }

    return super.OverridePickupQuery(Other, item, bAllowPickup);
}

function bool IsPoweredUp(Pawn Other)
{
    return (Other.HasUDamage() || Other.InCurrentCombo() || Other.Health == Other.SuperHealthMax || (xPawn(Other) != None && Other.ShieldStrength == xPawn(Other).ShieldStrengthMax));
}

// Check for Node Buster award. We simply assume that Nodes are the only objective that is scored in ONS.
function ScoreObjective(PlayerReplicationInfo Scorer, Int Score)
{
    local int i;

    if (UnrealPlayer(Scorer.Owner) != None && Level.Game != None && Level.Game.IsA('ONSOnslaughtGame'))
    {
        for (i = 0; i < DamageData.Length; i++)
        {
            if (DamageData[i].C == Scorer.Owner)
            {
                 DamageData[i].NodeCount++;
                 if (DamageData[i].NodeCount == 30)
                 {
                     UnrealPlayer(Scorer.Owner).ClientDelayedAnnouncement(NodeBusterAnnounce, AWARD_MESSAGE_DELAY);
                 }
                 else if (DamageData[i].NodeCount == 60)
                 {
                     UnrealPlayer(Scorer.Owner).ClientDelayedAnnouncement(UnrealAnnounce, AWARD_MESSAGE_DELAY);
                     UnrealPlayer(Scorer.Owner).ClientDelayedAnnouncement(NodeBusterAnnounce, DUAL_AWARD_MESSAGE_DELAY);
                 }
                 break;
            }
        }
    }

    if ( NextGameRules != None )
        NextGameRules.ScoreObjective(Scorer, Score);
}

DefaultProperties
{
    ShieldGunAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_JackHammer'
    AssaultRifleAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_Gunslinger'
    BioRifleAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_Biohazard'
    MinigunAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_BlueStreak'
    LinkGunAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_ShaftMaster'
    RocketLauncherAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_RocketScientist'
    AVRiLAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_BigGameHunter'
    NodeBusterAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_NodeBuster'
    JuggernautAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_Juggernaut'
    UnrealAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_Unreal'
    BullsEyeAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_BullsEye'
    ShomboAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_ComboKing'
    FlakCannonAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_FlakMaster'
    HeadHunterAnnounce = sound'MutWeapMilestoneAnnounce_Snd.Announcements.A_RewardAnnouncer_HeadHunter'
}