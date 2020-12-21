extends Node


# TELEPORTATION
signal teleport_requested()
signal cast_teleport(destination)
signal cast_recall()
signal fadeout_finished()
signal fadein_finished()
signal zone_change_completed(new_zone_name)


# PARTY MANAGEMENT
signal cmd_invite(target)
signal cmd_kick(target)

signal invite_accepted(npc)
signal party_member_added(npc)
signal cmd_invite_processed()
signal party_member_kicked(npc)
signal cmd_kick_processed()

signal party_member_left_arrival(npc)
signal party_member_left_impatience(npc)
