extends AppView
const CONTACT_LISTING = preload("uid://c2mphdfs7pemb")

func _ready() -> void:
	for contact in Contacts.contacts:
		var listing := CONTACT_LISTING.instantiate()
		listing.contact = contact
		%ContactsList.add_child(listing)
