extends Button

func _pressed() -> void:
	Loc.current_lang = Enums.Lang.ru \
		if Loc.current_lang == Enums.Lang.en \
		else Enums.Lang.en
	
	G.lang_changed.emit()
