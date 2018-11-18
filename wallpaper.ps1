#
# Author: Patrick Schmidt <patrick@ealp-net.at>
# License: Apache License, Version 2.0
#

# Extract the wallpaper URL from the bing.at website
$url = "https://www.bing.com/?cc=at"
$result = Invoke-WebRequest $url

$wallpaperURL = $result.AllElements | Where tagName -eq "img" | Select -Last 1 -ExpandProperty src
$wallpaperURL = 'https://www.bing.com' + $wallpaperURL
echo "URL: $wallpaperURL"

$wallpaperFile = "$env:TEMP\wallpaper.jpg"
echo "File: $wallpaperFile"

# Download the wallpaper image and set it as the desktop background
$start_time = Get-Date
Invoke-WebRequest -Uri $wallpaperURL -OutFile $wallpaperFile
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $wallpaperFile
rundll32.exe user32.dll, UpdatePerUserSystemParameters
