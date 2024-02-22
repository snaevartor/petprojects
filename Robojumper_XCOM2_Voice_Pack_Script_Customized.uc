//Custom script for creating voice pack mods for XCOM 2.
//Credit for original script goes to Robojumper. Fixes and updates by me.

<[YOUR_MOD_NAME_HERE].uc>

class [YOUR_MOD_NAME_HERE] extends XComCharacterVoice;

struct SoundCueMap
{
	var() name EventName;
	var() SoundCue Cue;
};

var() editinline array<SoundCueMap> Events;

function PlaySoundForEvent(Name nEvent, Actor Owner)
{
	local SoundCue Cue;
	local bool bProfileSettingsEnabledChatter;
	local bool bKismetDistabledChatter;
	local bool bChatterDistabledByINI;
	local array<string> EventStrings;

	bProfileSettingsEnabledChatter = `XPROFILESETTINGS != none && `XPROFILESETTINGS.Data.m_bEnableSoldierSpeech;
	bKismetDistabledChatter = `BATTLE != none && `BATTLE.m_kDesc.m_bDisableSoldierChatter;
	bChatterDistabledByINI = class'X2BodyPartTemplateManager'.static.GetBodyPartTemplateManager().DisableCharacterVoices;

	if(!bProfileSettingsEnabledChatter || bKismetDistabledChatter || bChatterDistabledByINI)
		return;

	Cue = FindSoundCue(nEvent);
	if (Cue != none)
	{
		Owner.PlaySound(Cue, true);
	}
	else
	{
		//If we didn't find a match, see if this was a whisper line or personality line. If so, try falling back to the regular variant.
		EventStrings = SplitString(string(nEvent), "_");
		if(EventStrings.Length > 0)
		{
			Cue = FindSoundCue(Name(EventStrings[0]));
			if(Cue != none)
			{
				Owner.PlaySound(Cue, true);
			}
		}
	}
}

function SoundCue FindSoundCue(name nmEvent)
{
	local int i;
	i = Events.Find('EventName', nmEvent);
	if (i != INDEX_NONE)
	{
		return Events[i].Cue;
	}
	`log("Unhandled event:" @ nmEvent);
	return none;
}


defaultproperties
{
	Events.Add((EventName="Acid"))
	Events.Add((EventName="ActivateConcealment"))
	Events.Add((EventName="ADVENTsighting"))
	Events.Add((EventName="AlienMoving"))
	Events.Add((EventName="AlienNotStunned"))
	Events.Add((EventName="AlienReinforcements"))
	Events.Add((EventName="AlienRetreat"))
	Events.Add((EventName="AmmoOut"))
	Events.Add((EventName="ArmorHit"))
	Events.Add((EventName="AttemptingHack"))
	Events.Add((EventName="BlasterLauncher"))
	Events.Add((EventName="BulletShred"))
	Events.Add((EventName="Burning"))
	Events.Add((EventName="CapacitorDischarge"))
	Events.Add((EventName="CivilianRescue"))
	Events.Add((EventName="CombatStim"))
	Events.Add((EventName="ConcealedSpotted"))
	Events.Add((EventName="Confused"))
	Events.Add((EventName="CriticallyWounded"))
	Events.Add((EventName="Dashing"))
	Events.Add((EventName="DeathScream"))
	Events.Add((EventName="Domination"))
	Events.Add((EventName="DroppingBody"))
	Events.Add((EventName="EnemyPatrolSpotted"))
	Events.Add((EventName="EngineerScienceVIP"))
	Events.Add((EventName="EnterSquadConcealment"))
	Events.Add((EventName="EVAC"))
	Events.Add((EventName="EVACrequest"))
	Events.Add((EventName="Explosion"))
	Events.Add((EventName="FanFire"))
	Events.Add((EventName="Flamethrower"))
	Events.Add((EventName="GenericHackFailed"))
	Events.Add((EventName="GenericHackSuccess"))
	Events.Add((EventName="GrapplingHook"))
	Events.Add((EventName="HackDoor"))
	Events.Add((EventName="HackDoorSuccess"))
	Events.Add((EventName="HackTurret"))
	Events.Add((EventName="HackTurretFailed"))
	Events.Add((EventName="HackUnit"))
	Events.Add((EventName="HackUnitFailed"))
	Events.Add((EventName="HackWorkstation"))
	Events.Add((EventName="HaywireProtocol"))
	Events.Add((EventName="HealingAlly"))
	Events.Add((EventName="HiddenMovementVox"))
	Events.Add((EventName="HostileVIP"))
	Events.Add((EventName="HunkerDown"))
	Events.Add((EventName="Insanity"))
	Events.Add((EventName="Inspire"))
	Events.Add((EventName="InTheZone"))
	Events.Add((EventName="ItemCollected"))
	Events.Add((EventName="KillZone"))
	Events.Add((EventName="LootCaptured"))
	Events.Add((EventName="LootSpotted"))
	Events.Add((EventName="LowAmmo"))
	Events.Add((EventName="MedicalProtocol"))
	Events.Add((EventName="Mindblast"))
	Events.Add((EventName="MissionAbortRequest"))
	Events.Add((EventName="Moving"))
	Events.Add((EventName="MultipleTargetsKilled"))
	Events.Add((EventName="NullLance"))
	Events.Add((EventName="NullShield"))
	Events.Add((EventName="ObjectFireSpreading"))
	Events.Add((EventName="ObjectiveSighted"))
	Events.Add((EventName="Overwatch"))
	Events.Add((EventName="PanickedBreathing"))
	Events.Add((EventName="PanicScream"))
	Events.Add((EventName="PickingUpBody"))
	Events.Add((EventName="PlasmaBlaster"))
	Events.Add((EventName="Poison"))
	Events.Add((EventName="Reaper"))
	Events.Add((EventName="Reloading"))
	Events.Add((EventName="RestorativeMist"))
	Events.Add((EventName="RocketLauncher"))
	Events.Add((EventName="RunAndGun"))
	Events.Add((EventName="SaturationFire"))
	Events.Add((EventName="ShredderGun"))
	Events.Add((EventName="ShredStormCannon"))
	Events.Add((EventName="SmokeGrenade"))
	Events.Add((EventName="SoldierControlled"))
	Events.Add((EventName="SoldierFailsControl"))
	Events.Add((EventName="SoldierFlanked"))
	Events.Add((EventName="SoldierResistsMindControl"))
	Events.Add((EventName="SquadConcealmentBroken"))
	Events.Add((EventName="SquadMemberDead"))
	Events.Add((EventName="StabilizingAlly"))
	Events.Add((EventName="StunnedAlien"))
	Events.Add((EventName="Suppressed"))
	Events.Add((EventName="Suppressing"))
	Events.Add((EventName="SwordMiss"))
	Events.Add((EventName="TakingDamage"))
	Events.Add((EventName="TakingFire"))
	Events.Add((EventName="TargetArmorHit"))
	Events.Add((EventName="TargetHeard"))
	Events.Add((EventName="TargetKilled"))
	Events.Add((EventName="TargetMissed"))
	Events.Add((EventName="TargetWinged"))
	Events.Add((EventName="ThrowFlashbang"))
	Events.Add((EventName="ThrowGrenade"))
	Events.Add((EventName="TrippedBurrow"))
	Events.Add((EventName="TurnWhileConfused"))
	Events.Add((EventName="VIPRescueComplete"))
	Events.Add((EventName="VIPsighted"))
	Events.Add((EventName="VoidRift"))
	
	// World Narrative	
	Events.Add((EventName="AlienExperimentSighted"))
	Events.Add((EventName="AlienFacilitySighted"))
	Events.Add((EventName="AlienFloraSighted"))
	Events.Add((EventName="CheckpointSighted"))
	Events.Add((EventName="GenericSighting"))
	Events.Add((EventName="GraffitiSighted"))
	Events.Add((EventName="MeatFactorySighted"))
	
	// While Concealed	
	Events.Add((EventName="CivilianSighted_w"))
	Events.Add((EventName="Dashing_w"))
	Events.Add((EventName="Moving_w"))
	Events.Add((EventName="ObjectiveSighted_w"))
	Events.Add((EventName="OrderConfirm_w"))
	Events.Add((EventName="Overwatch_w"))
	Events.Add((EventName="VIPsighted_w"))
	
	// Faction Heroes for WOTC
	
	// Templar	
	Events.Add((EventName="Rend"))
	Events.Add((EventName="Volt"))
	Events.Add((EventName="Amplify"))
	Events.Add((EventName="Pillar"))
	Events.Add((EventName="Invert"))
	Events.Add((EventName="Exchange"))
	Events.Add((EventName="Ghost"))
	Events.Add((EventName="IonicStorm"))
	Events.Add((EventName="VoidConduit"))
	Events.Add((EventName="StunStrike"))

	// Reaper	
	Events.Add((EventName="Shadow"))
	Events.Add((EventName="TargetDefinition"))
	Events.Add((EventName="HomingMine"))
	Events.Add((EventName="RemoteStart"))
	Events.Add((EventName="Banish"))
	Events.Add((EventName="Sting"))
	
	// Skirmisher
	Events.Add((EventName="FullThrottle"))
	Events.Add((EventName="CombatPresence"))
	Events.Add((EventName="Justice"))
	Events.Add((EventName="ManualOverride"))
	Events.Add((EventName="Whiplash"))
	Events.Add((EventName="Judgement"))
	Events.Add((EventName="Interrupt"))
	Events.Add((EventName="Battlelord"))

/*
	// Attitudes for vanilla XCOM 2
	Events.Add((EventName="GenericVIP_BY_THE_BOOK"))
	Events.Add((EventName="GenericVIP_HAPPY_GO_LUCKY"))
	Events.Add((EventName="GenericVIP_HARD_LUCK"))
	Events.Add((EventName="GenericVIP_INTENSE"))
	Events.Add((EventName="GenericVIP_LAID_BACK"))
	Events.Add((EventName="GenericVIP_TWITCHY"))
	
	Events.Add((EventName="HackWorkstation_BY_THE_BOOK"))
	Events.Add((EventName="HackWorkstation_HAPPY_GO_LUCKY"))
	Events.Add((EventName="HackWorkstation_HARD_LUCK"))
	Events.Add((EventName="HackWorkstation_INTENSE"))
	Events.Add((EventName="HackWorkstation_LAID_BACK"))
	Events.Add((EventName="HackWorkstation_TWITCHY"))
	
	Events.Add((EventName="HostileVIP_BY_THE_BOOK"))
	Events.Add((EventName="HostileVIP_HAPPY_GO_LUCKY"))
	Events.Add((EventName="HostileVIP_HARD_LUCK"))
	Events.Add((EventName="HostileVIP_INTENSE"))
	Events.Add((EventName="HostileVIP_LAID_BACK"))
	Events.Add((EventName="HostileVIP_TWITCHY"))
	
	Events.Add((EventName="LootCaptured_BY_THE_BOOK"))
	Events.Add((EventName="LootCaptured_HAPPY_GO_LUCKY"))
	Events.Add((EventName="LootCaptured_HARD_LUCK"))
	Events.Add((EventName="LootCaptured_INTENSE"))
	Events.Add((EventName="LootCaptured_LAID_BACK"))
	Events.Add((EventName="LootCaptured_TWITCHY"))
	
	Events.Add((EventName="LootSpotted_BY_THE_BOOK"))
	Events.Add((EventName="LootSpotted_HAPPY_GO_LUCKY"))
	Events.Add((EventName="LootSpotted_HARD_LUCK"))
	Events.Add((EventName="LootSpotted_INTENSE"))
	Events.Add((EventName="LootSpotted_LAID_BACK"))
	Events.Add((EventName="LootSpotted_TWITCHY"))
	
	Events.Add((EventName="Moving_BY_THE_BOOK"))
	Events.Add((EventName="Moving_HAPPY_GO_LUCKY"))
	Events.Add((EventName="Moving_HARD_LUCK"))
	Events.Add((EventName="Moving_INTENSE"))
	Events.Add((EventName="Moving_LAID_BACK"))
	Events.Add((EventName="Moving_TWITCHY"))
	
	Events.Add((EventName="Panic_BY_THE_BOOK"))
	Events.Add((EventName="Panic_HAPPY_GO_LUCKY"))
	Events.Add((EventName="Panic_HARD_LUCK"))
	Events.Add((EventName="Panic_INTENSE"))
	Events.Add((EventName="Panic_LAID_BACK"))
	Events.Add((EventName="Panic_TWITCHY"))
	
	Events.Add((EventName="PickingUpBody_BY_THE_BOOK"))
	Events.Add((EventName="PickingUpBody_HAPPY_GO_LUCKY"))
	Events.Add((EventName="PickingUpBody_HARD_LUCK"))
	Events.Add((EventName="PickingUpBody_INTENSE"))
	Events.Add((EventName="PickingUpBody_LAID_BACK"))
	Events.Add((EventName="PickingUpBody_TWITCHY"))
	
	Events.Add((EventName="SoldierVIP_BY_THE_BOOK"))
	Events.Add((EventName="SoldierVIP_HAPPY_GO_LUCKY"))
	Events.Add((EventName="SoldierVIP_HARD_LUCK"))
	Events.Add((EventName="SoldierVIP_INTENSE"))
	Events.Add((EventName="SoldierVIP_LAID_BACK"))
	Events.Add((EventName="SoldierVIP_TWITCHY"))
	
	Events.Add((EventName="TargetEliminated_BY_THE_BOOK"))
	Events.Add((EventName="TargetEliminated_HAPPY_GO_LUCKY"))
	Events.Add((EventName="TargetEliminated_HARD_LUCK"))
	Events.Add((EventName="TargetEliminated_INTENSE"))
	Events.Add((EventName="TargetEliminated_LAID_BACK"))
	Events.Add((EventName="TargetEliminated_TWITCHY"))
	
	Events.Add((EventName="TargetKilled_BY_THE_BOOK"))
	Events.Add((EventName="TargetKilled_HAPPY_GO_LUCKY"))
	Events.Add((EventName="TargetKilled_HARD_LUCK"))
	Events.Add((EventName="TargetKilled_INTENSE"))
	Events.Add((EventName="TargetKilled_LAID_BACK"))
	Events.Add((EventName="TargetKilled_TWITCHY"))
	
	Events.Add((EventName="UsefulVIP_BY_THE_BOOK"))
	Events.Add((EventName="UsefulVIP_HAPPY_GO_LUCKY"))
	Events.Add((EventName="UsefulVIP_HARD_LUCK"))
	Events.Add((EventName="UsefulVIP_INTENSE"))
	Events.Add((EventName="UsefulVIP_LAID_BACK"))
	Events.Add((EventName="UsefulVIP_TWITCHY"))
	
	// Additional attitudes for WOTC
	Events.Add((EventName="GenericVIP_ANGRY"))
	Events.Add((EventName="GenericVIP_COCKY"))
	Events.Add((EventName="GenericVIP_LETS_GO"))
	Events.Add((EventName="GenericVIP_SMUG"))
	Events.Add((EventName="GenericVIP_SUSPICIOUS"))
	
	Events.Add((EventName="HackWorkstation_ANGRY"))
	Events.Add((EventName="HackWorkstation_COCKY"))
	Events.Add((EventName="HackWorkstation_LETS_GO"))
	Events.Add((EventName="HackWorkstation_SMUG"))
	Events.Add((EventName="HackWorkstation_SUSPICIOUS"))
	
	Events.Add((EventName="HostileVIP_ANGRY"))
	Events.Add((EventName="HostileVIP_COCKY"))
	Events.Add((EventName="HostileVIP_LETS_GO"))
	Events.Add((EventName="HostileVIP_SMUG"))
	Events.Add((EventName="HostileVIP_SUSPICIOUS"))
	
	Events.Add((EventName="LootCaptured_ANGRY"))
	Events.Add((EventName="LootCaptured_COCKY"))
	Events.Add((EventName="LootCaptured_LETS_GO"))
	Events.Add((EventName="LootCaptured_SMUG"))
	Events.Add((EventName="LootCaptured_SUSPICIOUS"))
	
	Events.Add((EventName="LootSpotted_ANGRY"))
	Events.Add((EventName="LootSpotted_COCKY"))
	Events.Add((EventName="LootSpotted_LETS_GO"))
	Events.Add((EventName="LootSpotted_SMUG"))
	Events.Add((EventName="LootSpotted_SUSPICIOUS"))
	
	Events.Add((EventName="Moving_ANGRY"))
	Events.Add((EventName="Moving_COCKY"))
	Events.Add((EventName="Moving_LETS_GO"))
	Events.Add((EventName="Moving_SMUG"))
	Events.Add((EventName="Moving_SUSPICIOUS"))
	
	Events.Add((EventName="Panic_ANGRY"))
	Events.Add((EventName="Panic_COCKY"))
	Events.Add((EventName="Panic_LETS_GO"))
	Events.Add((EventName="Panic_SMUG"))
	Events.Add((EventName="Panic_SUSPICIOUS"))
	
	Events.Add((EventName="PickingUpBody_ANGRY"))
	Events.Add((EventName="PickingUpBody_COCKY"))
	Events.Add((EventName="PickingUpBody_LETS_GO"))
	Events.Add((EventName="PickingUpBody_SMUG"))
	Events.Add((EventName="PickingUpBody_SUSPICIOUS"))
	
	Events.Add((EventName="SoldierVIP_ANGRY"))
	Events.Add((EventName="SoldierVIP_COCKY"))
	Events.Add((EventName="SoldierVIP_LETS_GO"))
	Events.Add((EventName="SoldierVIP_SMUG"))
	Events.Add((EventName="SoldierVIP_SUSPICIOUS"))
	
	Events.Add((EventName="TargetEliminated_ANGRY"))
	Events.Add((EventName="TargetEliminated_COCKY"))
	Events.Add((EventName="TargetEliminated_LETS_GO"))
	Events.Add((EventName="TargetEliminated_SMUG"))
	Events.Add((EventName="TargetEliminated_SUSPICIOUS"))
	
	Events.Add((EventName="TargetKilled_ANGRY"))
	Events.Add((EventName="TargetKilled_COCKY"))
	Events.Add((EventName="TargetKilled_LETS_GO"))
	Events.Add((EventName="TargetKilled_SMUG"))
	Events.Add((EventName="TargetKilled_SUSPICIOUS"))
	
	Events.Add((EventName="UsefulVIP_ANGRY"))
	Events.Add((EventName="UsefulVIP_COCKY"))
	Events.Add((EventName="UsefulVIP_LETS_GO"))
	Events.Add((EventName="UsefulVIP_SMUG"))
	Events.Add((EventName="UsefulVIP_SUSPICIOUS"))

	// Unused cues
	Events.Add((EventName="ALERT"))
	Events.Add((EventName="AlienSighting"))
	Events.Add((EventName="ArcThrower"))
	Events.Add((EventName="AreaSuppressing"))
	Events.Add((EventName="BattleScanner"))
	Events.Add((EventName="BleedingOut"))
	Events.Add((EventName="CivilianScream"))
	Events.Add((EventName="CivilianSighted"))
	Events.Add((EventName="CollateralDamage"))
	Events.Add((EventName="CoupDeGrace"))
	Events.Add((EventName="CriticalFeedback"))
	Events.Add((EventName="DefensiveProtocol"))
	Events.Add((EventName="DisablingShot"))
	Events.Add((EventName="Dodge"))
	Events.Add((EventName="ElectroPulse"))
	Events.Add((EventName="EngagingHostiles"))
	Events.Add((EventName="EvacAllDead"))
	Events.Add((EventName="EvacAllOut"))
	Events.Add((EventName="EvacHeavyLosses"))
	Events.Add((EventName="EvacNoLosses"))
	Events.Add((EventName="EvacSomeLosses"))
	Events.Add((EventName="EvacSomeOut"))
	Events.Add((EventName="ExaltChatter"))
	Events.Add((EventName="FireRocket"))
	Events.Add((EventName="Flushing"))
	Events.Add((EventName="GenericVIP"))
	Events.Add((EventName="GhostModeActive"))
	Events.Add((EventName="GroundZero"))
	Events.Add((EventName="HackTurretSuccess"))
	Events.Add((EventName="HackUnitSuccess"))
	Events.Add((EventName="HackWorkstationSuccess"))
	Events.Add((EventName="Halt"))
	Events.Add((EventName="HiddenMovement"))
	Events.Add((EventName="HoldTheLine"))
	Events.Add((EventName="InDropPosition"))
	Events.Add((EventName="InitialFeedback"))
	Events.Add((EventName="JetBoots"))
	Events.Add((EventName="JetPackOff"))
	Events.Add((EventName="JetpackMove"))
	Events.Add((EventName="KineticStrike"))
	Events.Add((EventName="MovementSpotted"))
	Events.Add((EventName="ObjectOnFire"))
	Events.Add((EventName="ObjectSecured"))
	Events.Add((EventName="ObjectivePackageEVAC"))
	Events.Add((EventName="OneForAll"))
	Events.Add((EventName="OrderConfirm"))
	Events.Add((EventName="ProximityMine"))
	Events.Add((EventName="RepairSHIV"))
	Events.Add((EventName="RequestReinforcements"))
	Events.Add((EventName="RevivingAlly"))
	Events.Add((EventName="RocketScatter"))
	Events.Add((EventName="ShredderRocket"))
	Events.Add((EventName="SoldierVIP"))
	Events.Add((EventName="Strangled"))
	Events.Add((EventName="StunTarget"))
	Events.Add((EventName="TargetCaptured"))
	Events.Add((EventName="TargetEliminated"))
	Events.Add((EventName="TargetSighted"))
	Events.Add((EventName="TargetSpottedHidden"))
	Events.Add((EventName="TargetSpotted"))
	Events.Add((EventName="TeslaCannon"))
	Events.Add((EventName="ThroughTheWall"))
	Events.Add((EventName="UsefulVIP"))
	Events.Add((EventName="VIPRescueInProgress"))
	Events.Add((EventName="VIPknockout"))
	Events.Add((EventName="VolunteerPsiRift"))
*/

}