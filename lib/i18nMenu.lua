i18nMenu = setmetatable({}, i18nMenu)
i18nMenu.__index = i18nMenu

AddEventHandler("i18n:setLocale", function(modName,lang)
	if modName == Setup.friendlyResourceName then
		Translator.setLang(lang)
	end
end)

AddEventHandler("i18n:getLocales", function(lang)
	TriggerEvent("i18n:iSupport",Setup.friendlyResourceName,Setup.lang,avalLangs)
end)

function i18nMenu.setup(lang)
	Translator.setLang(lang)
	TriggerEvent("i18n:iSupport",Setup.friendlyResourceName,Setup.lang,avalLangs)
end



