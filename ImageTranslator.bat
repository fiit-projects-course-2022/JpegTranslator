@echo off

setlocal

if not "%~1"=="" (
    set "_arg1=%~f1"
) else (
    for %%i in (*.jpeg, *.jpeg) do (
        set _arg1=%%~nxdpi
        goto translate
    )
    echo No jpeg files in current directory
    goto :eof
)
pushd %~dp0

:translate
echo Translating %_arg1%

@REM python DefineHuffmanTables.py %_arg1%
dotnet run --project src/ImageTranslator/ImageTranslator %_arg1% %~dp0src

call tools\JackCompiler %~dp0src

move /Y src\*.vm vm\ > nul

call tools/VMEmulator.bat

popd