class_name NpcData
extends Resource

enum customer_status {NO_TP, CUSTOMER, STOLEN, IN_PARTY}
enum types {ADVENTURER, TRAVELER, TRADER}

export(String) var username = 'Placeholder Lad'
export (customer_status) var status = 0
export(types) var type = 0
