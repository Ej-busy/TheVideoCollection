@echo off
echo Starting The Video Collection Server with Freenom Domain Support...
echo.
echo This will download ngrok (if needed) and start a server with a stable URL

:: Create a directory for ngrok if it doesn't exist
if not exist "ngrok" mkdir ngrok

:: Download ngrok if not present
if not exist "ngrok\ngrok.exe" (
    echo Downloading ngrok...
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip' -OutFile 'ngrok.zip'}"
    echo Extracting ngrok...
    powershell -Command "& {Expand-Archive -Path 'ngrok.zip' -DestinationPath 'ngrok' -Force; Remove-Item 'ngrok.zip'}"
    echo ngrok downloaded successfully.
)

:: Start the Node.js server in the background
echo.
echo Starting Node.js server on port 8080...
start /B node simple-server.js

:: Wait for the server to start
timeout /t 3 /nobreak > nul

:: Start ngrok with direct command
echo.
echo Starting ngrok...
echo.

:: Create a file to store the ngrok URL
if not exist "ngrok_url.txt" (
    echo Creating ngrok URL file...
    echo https://example.ngrok.io > ngrok_url.txt
)

:: Start ngrok and capture its output
cd ngrok
:: Clear any previous output file
if exist "ngrok_output.txt" del /f /q ngrok_output.txt
:: Start ngrok with output redirection
start /B cmd /c "ngrok.exe http 8080 --authtoken 2vxUczfR3r8FO8Mp5IPgiVwNRcO_5YBY25jMrJq5b7RGU4L5 > ngrok_output.txt 2>&1"

:: Wait for ngrok to start
timeout /t 5 /nobreak > nul

:: Wait a bit longer for ngrok to start completely
echo Waiting for ngrok to initialize...
timeout /t 10 /nobreak > nul

:: Try to get the URL using the ngrok API (more reliable method)
echo Trying to get ngrok URL via API...
cd ..
node get-ngrok-url.js
if %ERRORLEVEL% EQU 0 (
    echo Successfully got ngrok URL via API.
) else (
    echo API method failed, trying to extract URL from output file...
    cd ngrok
    
    :: Check if the file exists and has content before trying to extract the URL
    powershell -Command "& {if (Test-Path 'ngrok_output.txt' -PathType Leaf) { $content = Get-Content -Path 'ngrok_output.txt' -Raw -ErrorAction SilentlyContinue; if ($content) { $match = [regex]::Match($content, 'url=https://[^\\s]+'); if ($match.Success) { $url = $match.Value.Substring(4); Write-Output $url > '../ngrok_url.txt'; Write-Output $url } else { Write-Output 'https://example.ngrok.io' > '../ngrok_url.txt'; Write-Output 'Could not extract URL from ngrok output' } } else { Write-Output 'https://example.ngrok.io' > '../ngrok_url.txt'; Write-Output 'ngrok output file is empty' } } else { Write-Output 'https://example.ngrok.io' > '../ngrok_url.txt'; Write-Output 'ngrok output file not found' }}"
    cd ..
)

:: Display the URL
echo.
echo Your temporary ngrok URL is:
type ngrok_url.txt
echo.

:: Check if we have a valid URL before updating the redirect page
findstr /C:"https://" ngrok_url.txt > nul
if %ERRORLEVEL% EQU 0 (
    :: Update the Freenom redirect page
    echo Updating your Freenom redirect page to point to this URL...
    node update-freenom-redirect.js
    
    echo.
    echo Your redirect page has been updated.
    echo.
    echo Next steps:
    echo 1. Upload the updated freenom-redirect/index.html file to your GitHub repository
    echo 2. Your Freenom domain will now redirect to your current ngrok URL
    echo.
    echo For detailed instructions, see the FREENOM_DOMAIN_SETUP.md file.
) else (
    echo.
    echo WARNING: Could not detect a valid ngrok URL.
    echo The redirect page update has been skipped.
    echo Please check that ngrok is running correctly.
    echo You may need to restart the server or check the ngrok configuration.
    echo.
)

echo.
echo When you restart the server, a new temporary URL will be generated,
echo but your Freenom domain will always work after you update the redirect page.
echo.
echo Press Ctrl+C when you're done.
echo.

:: Create a simple HTML redirect page
echo Creating local redirect page...
echo ^<!DOCTYPE html^> > redirect.html
echo ^<html^> >> redirect.html
echo ^<head^> >> redirect.html
echo ^<meta charset="UTF-8"^> >> redirect.html
echo ^<title^>Redirecting to The Video Collection^</title^> >> redirect.html
echo ^<meta http-equiv="refresh" content="0; URL='^<script^>document.write(localStorage.getItem('ngrokUrl') || 'https://example.ngrok.io')^</script^>'"^> >> redirect.html
echo ^<script^> >> redirect.html
echo fetch('ngrok_url.txt') >> redirect.html
echo .then(response =^> response.text()) >> redirect.html
echo .then(url =^> { >> redirect.html
echo localStorage.setItem('ngrokUrl', url.trim()); >> redirect.html
echo window.location.href = url.trim(); >> redirect.html
echo }) >> redirect.html
echo .catch(error =^> console.error('Error fetching URL:', error)); >> redirect.html
echo ^</script^> >> redirect.html
echo ^</head^> >> redirect.html
echo ^<body^> >> redirect.html
echo ^<p^>Redirecting to The Video Collection...^</p^> >> redirect.html
echo ^<p^>If you are not redirected, ^<a href="#" onclick="window.location.href=localStorage.getItem('ngrokUrl') || 'https://example.ngrok.io'; return false;"^>click here^</a^>.^</p^> >> redirect.html
echo ^</body^> >> redirect.html
echo ^</html^> >> redirect.html

echo.
echo A local redirect page has been created at redirect.html
echo This file can also be used to access your current server.
echo.

:: Keep the window open
pause
