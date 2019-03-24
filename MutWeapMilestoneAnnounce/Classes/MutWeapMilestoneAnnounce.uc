//------------------------------------------------------------------------------
// A Mutator that plays the 15-kills announcements (Flak Monkey, etc.) for more
// weapons than just Flak, Shock and Sniper.
//
// $wotgreal_dt: 04.11.2012 04:27:29$
// by Crusha K. Rool, sound courtesy by Epic Games
//------------------------------------------------------------------------------
class MutWeapMilestoneAnnounce extends Mutator;

function PostBeginPlay()
{
    local WeapMilestoneAnnounceRules G;

    Super.PostBeginPlay();
    G = spawn(class'WeapMilestoneAnnounceRules');
    // That's it. These GameRules take care of adding themselves in PostBeginPlay().
}

DefaultProperties
{
     GroupName="Announcement"
     FriendlyName="Weapon Streak Announcement"
     Description="Announces streaks for every weapon, not just for Flak Monkeys and Combo Whores."
}