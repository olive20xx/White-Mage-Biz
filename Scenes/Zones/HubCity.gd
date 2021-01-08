extends Node2D

#var is_market := true
export(int) var base_payment = 500 setget ,base_payment_get

export(int) var max_NPCs = 20
export(int) var max_customers = 5
export(int) var min_name_length = 2
export(int) var max_name_length = 15

func base_payment_get():
	return base_payment
