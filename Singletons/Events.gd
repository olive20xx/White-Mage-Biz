extends Node


# TELEPORTATION
signal teleport_requested()
signal cast_teleport(destination)
signal cast_recall()

# PARTY MANAGEMENT
signal cmd_invite(target)
signal cmd_kick(target)

signal party_member_added(npc)
signal cmd_invite_processed
signal party_member_kicked(npc)
signal cmd_kick_processed
