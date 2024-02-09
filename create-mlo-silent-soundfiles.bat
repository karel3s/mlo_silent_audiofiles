@echo off
set "outputFolder=output"
set "mp3SilenceFile=silence.mp3"
set "mp3ListFile=soundfiles-mp3.txt"
mkdir "%outputFolder%" 2>nul

echo Copying 1 second of silence to MP3 files listed in '%mp3ListFile%'...

for /f "delims=" %%F in (%mp3ListFile%) do (
    ffmpeg -i "%mp3SilenceFile%" -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -t 1 -q:a 0 -acodec mp3 -ar 44100 -y "%outputFolder%\%%F"
)

echo Silence copied to MP3 files in the '%outputFolder%' subfolder successfully.

echo Copying 1 second of silence to mloReminder.wav...


set "wavSilenceFile=silence.wav"
set "outputFile=%outputFolder%\mloReminder.wav"

ffmpeg -i "%wavSilenceFile%" -filter_complex "[0]adelay=1s|1s[a];[1]adelay=1s|1s[b];[a][b]amix=duration=shortest" -y "%outputFile%"

echo Silence copied to mloReminder.wav in the '%outputFolder%' subfolder successfully.
