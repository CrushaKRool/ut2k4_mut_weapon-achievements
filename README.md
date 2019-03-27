This Mutator counts kills from specific weapons and triggers a reward sound cue similar to the Flak Monkey and Head Hunter awards once a certain threshold with that particular weapon is reached.

Specifically these trigger after 15 kills with:
- Shield Gun (Jack Hammer)
- Assault Rifle (Gun Slinger)
- Bio Rifle (Bio Hazard)
- Link Gun secondary (Shaft Master)
- Minigun (Blue Streak)
- Rocket Launcher (Rocket Scientist)

A second tier of announcement rewards is triggered upon reaching 30 kills with a weapon.

In Onslaught matches does the Mutator also trigger a Node Buster award upon building/destroying 30[60] PowerNodes.
It also has an award cue for becoming "double powered up", i.e. having 199 health, 150 armor, UDamage or an adrenaline combo active and picking up another super pickup.
(And there is a very rare announcement if you should ever manage to land a specific skill- or luckshot.)


# Usage
You can simply activate it like any other Mutator through the game UI.

If you are a server administrator and don't want your server to become non-standard from using a Mutator that is not on the whitelist, you may also simple add this as a ServerActor:

    [Engine.GameEngine]
    ...
    ServerActors=MutWeapMilestoneAnnounce.WeapMilestoneAnnounceRules

MutWeapMilestoneAnnounce is the name of this code's package/compiled .u file.

## Caution
Initial testing on a 32 player Onslaught server indicated some performance problems that I never really further investigated. Back then, a fellow programmer from the Jailbreak mod had a suspicion that this might be caused by searching through an array of structs and suggested some solution based on tags/attachments. Unfortunately I did not really follow his train of thought back then.
