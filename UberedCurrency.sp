#pragma semicolon 1
#include <sourcemod>
#include <tf2>
#include <tf2_stocks>

#define PLUGIN_VERSION "1.0.0"

new Handle:uc_version = INVALID_HANDLE;
new Handle:uc_uberduration = INVALID_HANDLE;
new Handle:uc_rewardnum = INVALID_HANDLE;

public Plugin:myinfo =
{
	name = "UberedCurrency",
	author = "Gentlemann Of Hats",
	description = "Gives Uber on Currency Pickup",
	version = PLUGIN_VERSION,
	url = "www.null.com"
}
public OnPluginStart()
{
	uc_version = CreateConVar("sm_uc_version", PLUGIN_VERSION, "Crits On spawn version", FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY|FCVAR_DONTRECORD);
	uc_uberduration = CreateConVar("sm_uc_uberduration", "5.0", "Sets how much uber is given when currency is picked up", _, true, 1.0, false, 99.0);
	uc_rewardnum = CreateConVar("sm_uc_rewardnum", "2.0", "Sets what reward is given for collecting currency 1=Crits 2=Uber", _, true, 1.0, true, 2.0);
	AutoExecConfig(true, "plugin.UberedCurrency");
	HookEventEx("mvm_pickup_currency", HookCurrencyPickup, EventHookMode_Post);
}
public Action:HookCurrencyPickup(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetEventInt(event, "player");
	new Float:i_Invuldur = GetConVarFloat(uc_uberduration);
	new Float:i_rewardnum = GetConVarFloat(uc_rewardnum);
	if (i_rewardnum == 2.0)
	{
		TF2_AddCondition(client, TFCond_UberchargedCanteen, i_Invuldur, 0);
	}
	if (i_rewardnum == 1.0)
	{
		TF2_AddCondition(client, TFCond_CritCanteen, i_Invuldur, 0);
	}
}