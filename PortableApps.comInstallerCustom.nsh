Var strInstallerCustomVersionPreInstall

!macro CustomCodePreInstall
	ReadINIStr $strInstallerCustomVersionPreInstall "$INSTDIR\App\AppInfo\appinfo.ini" "Version" "PackageVersion"
	CreateDirectory "$INSTDIR\CustomPreserve"
	Rename "$INSTDIR\App\Firefox64\plugins" "$INSTDIR\CustomPreserve\plugins64"
	Rename "$INSTDIR\App\Firefox64\searchplugins" "$INSTDIR\CustomPreserve\searchplugins64"
	Rename "$INSTDIR\App\Firefox64\components" "$INSTDIR\CustomPreserve\components64"
	Rename "$INSTDIR\App\Firefox64\distribution" "$INSTDIR\CustomPreserve\distribution64"
	Rename "$INSTDIR\App\Firefox64\config.js" "$INSTDIR\CustomPreserve\config64.js"
	Rename "$INSTDIR\App\Firefox64\defaults\pref\config-prefs.js" "$INSTDIR\CustomPreserve\config-prefs64.js"	
!macroend

!macro CustomCodePostInstall
	Delete "$INSTDIR\App\setup.exe"
	Rename "$INSTDIR\App\Firefox64\distribution" "$INSTDIR\App\64files\core\distribution"
	RMDir /r "$INSTDIR\App\Firefox64"
	Rename "$INSTDIR\App\64files\core" "$INSTDIR\App\Firefox64"
	RMDir /r "$INSTDIR\App\64files"
	CopyFiles "$INSTDIR\CustomPreserve\plugins64\*.*" "$INSTDIR\App\Firefox64\plugins"
	CopyFiles "$INSTDIR\CustomPreserve\searchplugins64\*.*" "$INSTDIR\App\Firefox64\searchplugins"
	CopyFiles "$INSTDIR\CustomPreserve\components64\*.*" "$INSTDIR\App\Firefox64\components"
	CopyFiles "$INSTDIR\CustomPreserve\distribution64\*.*" "$INSTDIR\App\Firefox64\distribution"
	CopyFiles "$INSTDIR\CustomPreserve\config64.js" "$INSTDIR\App\Firefox64" 
	CopyFiles "$INSTDIR\CustomPreserve\config-prefs64.js" "$INSTDIR\App\Firefox64\defaults\pref"
	Rename "$INSTDIR\App\Firefox64\config64.js" "$INSTDIR\App\Firefox64\config.js"
	Rename "$INSTDIR\App\Firefox64\defaults\pref\config-prefs64.js" "$INSTDIR\App\Firefox64\defaults\pref\config-prefs.js"
	RMDir /r "$INSTDIR\CustomPreserve"
	
	${If} ${FileExists} "$INSTDIR\Data\profile\*.*"
		${VersionCompare} $strInstallerCustomVersionPreInstall "85.999.0.2" $R0
		${If} $R0 == 2
			Delete "$INSTDIR\Data\settings\update-config.json"
			CopyFiles /SILENT "$INSTDIR\App\DefaultData\settings\update-config.json" "$INSTDIR\Data\settings"
		${EndIf}
	${EndIf}
!macroend