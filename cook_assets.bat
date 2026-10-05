SET "ddp=%~dp0"
SET "ddp=%ddp:~0,-1%"

SET /p editorPath= < Tools\user_settings\editor_directory.txt

del /S Dungeons\*.uasset
del /S Dungeons\*.ubulk
del /S Dungeons\*.uexp
del /S Dungeons\*.umap
del /S Dungeons\*.ufont

"%editorPath%\UE4Editor-Cmd.exe" "%ddp%\UE4Project\Dungeons.uproject" -run=cook -targetplatform=WindowsNoEditor

robocopy /job:Tools\configs\copy_cooked_assets

robocopy /S Precooked Dungeons

del /S /Q "Dungeons\Content\UI\Menu\SettingsMenu\UMG_KeyBindings.*"
if exist "Dungeons\Content\UI\Menu\SettingsMenu\UMG_KeyBindings.uasset" (
  echo ERROR: stand-in widget is still present. Do not package this build.
  pause
)