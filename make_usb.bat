@echo off
setlocal enabledelayedexpansion

set "TARGET_LABEL=WII"
set "SOURCE_DIR=driveroot"
set "BOOT_DOL=main\boot.dol"
set "FOUND_DRIVE="

echo --- RECHERCHE DU LECTEUR '%TARGET_LABEL%' ---

:: Methode alternative : On scanne toutes les lettres de A a Z
for /f "tokens=1,2" %%a in ('wmic logicaldisk get deviceid^,volumename ^| findstr /i "%TARGET_LABEL%"') do (
    set "FOUND_DRIVE=%%a"
)

if "%FOUND_DRIVE%"=="" (
    echo [ERREUR] Impossible de trouver un lecteur nomme '%TARGET_LABEL%'.
    echo Verifiez dans l'explorateur que le nom est EXACTEMENT 'WII'.
    echo.
    echo Lecteurs detectes actuellement :
    wmic logicaldisk get deviceid,volumename
    pause
    exit /b
)

echo [OK] Cle trouvee sur le lecteur !FOUND_DRIVE!
echo [INFO] Copie des fichiers de '%SOURCE_DIR%'...

:: /d copie uniquement les fichiers modifies (gain de temps enorme)
xcopy "!SOURCE_DIR!\*" "!FOUND_DRIVE!\" /s /e /y /d /i

echo [INFO] Mise a jour du boot.dol...
if not exist "!FOUND_DRIVE!\apps\RVLoader" mkdir "!FOUND_DRIVE!\apps\RVLoader"
copy /y "%BOOT_DOL%" "!FOUND_DRIVE!\apps\RVLoader\boot.dol"

powershell -Command "$drive = '!FOUND_DRIVE!'; $storage = New-Object -ComObject Shell.Application; $storage.Namespace(17).ParseName($drive).InvokeVerb('Eject')"

if %errorlevel% equ 0 (
    echo [OK] Vous pouvez retirer la cle en toute securite.
) else (
    echo [ATTENTION] L'ejection a echoue (Fichier peut-etre en cours d'utilisation).
)



echo.
echo --- TERMINE AVEC SUCCES ---
echo Appuyez sur une touche pour quitter.
pause