@echo https://www.cnblogs.com/sandal1980/articles/3904623.html
@echo off
set packPath=%~f1
set packName=%~n1%~x1
set dir=%cd%
cd /d ..
set outDir=%~dp0../Assets/data/atlas
%~dp0TexturePacker/bin/TexturePacker %packPath% --max-size 2048 --format unity-texture2d --disable-auto-alias --no-trim --size-constraints POT --shape-padding 2 --border-padding 2 --disable-rotation --algorithm MaxRects --opt RGBA8888 --dither-fs-alpha --scale 1 --sheet %outDir%/%packName%_view_atlas.png --data %outDir%/%packName%_view_atlas.tpsheet
@echo .
@echo .
@echo %outDir% -- %packName%
pause