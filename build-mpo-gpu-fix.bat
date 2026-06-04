@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

where dotnet >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    if exist "%ProgramFiles%\dotnet\dotnet.exe" (
        set "DOTNET=%ProgramFiles%\dotnet\dotnet.exe"
    ) else if exist "%ProgramFiles(x86)%\dotnet\dotnet.exe" (
        set "DOTNET=%ProgramFiles(x86)%\dotnet\dotnet.exe"
    ) else (
        echo dotnet SDK not found. Install from https://dotnet.microsoft.com/download
        pause
        exit /b 1
    )
) else (
    for /f "delims=" %%I in ('where dotnet') do set "DOTNET=%%I"
)

set "CURRENT=%SCRIPT_DIR%"
:search_project
if exist "%CURRENT%\AMDGPUFIX\AMDGPUFIX\AMDGPUFIX.csproj" (
    set "PROJECT=%CURRENT%\AMDGPUFIX\AMDGPUFIX\AMDGPUFIX.csproj"
    goto found
)
set "PARENT=%CURRENT%"
for %%I in ("%CURRENT%\..") do set "CURRENT=%%~fI"
if /I "%CURRENT%"=="%PARENT%" (
    echo Could not find AMDGPUFIX.csproj. Make sure the script is inside the repo.
    pause
    exit /b 1
)
goto search_project
:found

set "DESKTOP=%USERPROFILE%\Desktop"

echo Building MPOGPUFIX...
"%DOTNET%" publish "%PROJECT%" -c Release -p:DebugType=none -p:IncludeNativeLibrariesForSelfExtract=true --output "%DESKTOP%" >nul 2>&1

if exist "%DESKTOP%\MPOGPUFIX.dll.config" del "%DESKTOP%\MPOGPUFIX.dll.config"

if exist "%DESKTOP%\MPOGPUFIX.exe" (
    echo Copied MPOGPUFIX.exe to desktop
) else (
    echo Build failed
)

pause
