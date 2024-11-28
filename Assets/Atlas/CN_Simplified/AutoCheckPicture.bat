@echo off
set resourcePath=G:\Trunk2\Client\Atlas
set targetPath=G:\Trunk2\Client\Atlas\CN_Simplified
set picturesText=%targetPath%\ContainTextPicture.txt
set outDir=G:\Trunk2\Client/Assets/data/atlas/CN_Simplified
Dir %resourcePath% /AD /B>fileName.txt

echo ---------------遍历图片名字进行处理---------------

for /f %%a in (%targetPath%\fileName.txt) do (
    for /f %%b in (%picturesText%) do (
        if exist %resourcePath%\%%a\%%b.png (
            if not exist %targetPath%\%%a (
                md "%targetPath%\%%a"
            )
            echo %resourcePath%\%%a\%%b.png
            copy "%resourcePath%\%%a\%%b.png" "%targetPath%\%%a"
            del "%resourcePath%\%%a\%%b.png"
        )
    )
)

if not exist %outDir% (
    md "%outDir%"
)

echo ------------------生成特殊图集---------------------
for /f %%a in (%targetPath%\fileName.txt) do (
    if exist %targetPath%\%%a (
G:\Trunk2\Client\Atlas\TexturePacker/bin/TexturePacker %targetPath%\%%a --max-size 2048 --format unity-texture2d --disable-auto-alias --no-trim --size-constraints POT --shape-padding 2 --border-padding 2 --disable-rotation --algorithm MaxRects --opt RGBA8888 --dither-fs-alpha --scale 1 --sheet %outDir%/%%a_view_atlas.png --data %outDir%/%%a_view_atlas.tpsheet
    @echo %outDir%\%%a -- %%a
    @echo .
    @echo .
    )
)

echo ------------------生成原生图集---------------------
for /f %%a in (%targetPath%\fileName.txt) do (
    if exist %resourcePath%\%%a (
G:\Trunk2\Client\Atlas\TexturePacker/bin/TexturePacker %resourcePath%\%%a --max-size 2048 --format unity-texture2d --disable-auto-alias --no-trim --size-constraints POT --shape-padding 2 --border-padding 2 --disable-rotation --algorithm MaxRects --opt RGBA8888 --dither-fs-alpha --scale 1 --sheet G:\Trunk2\Client/Assets/data/atlas/%%a_view_atlas.png --data G:\Trunk2\Client/Assets/data/atlas/%%a_view_atlas.tpsheet
    @echo G:\Trunk2\Client/Assets/data/atlas\%%a -- %%a
    @echo .
    @echo .
    )
)

del %targetPath%\fileName.txt
pause