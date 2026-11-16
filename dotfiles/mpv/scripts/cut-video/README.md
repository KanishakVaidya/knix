mpv Period Marker

An mpv
 Lua script for marking time periods in a video that should be deleted.

Press a key once to mark the start of a period, then press it again to mark the end. You can mark any number of periods.

When mpv exits, the script:

Saves the marked periods to a .periods.txt file.
Merges overlapping periods.
Generates a shell script containing one FFmpeg command.
The FFmpeg command removes the marked periods and concatenates everything that remains into a new video.
Requirements
mpv
 with Lua scripting support
FFmpeg
A POSIX-compatible shell (sh)
Linux, macOS, or another Unix-like environment
Installation

Create the mpv scripts directory if it doesn't already exist:

mkdir -p ~/.config/mpv/scripts


Copy periods.lua into it:

~/.config/mpv/scripts/periods.lua


mpv automatically loads Lua scripts from this directory.

No input.conf configuration is required.

Usage

Open a video with mpv:

mpv input.mp4

Mark a period for deletion

Press:

Ctrl+P


The current playback position becomes the start of a deletion period.

mpv will display something like:

DELETE START: 00:01:23.450


Continue playing or seek to the end of the unwanted section.

Press Ctrl+P again.

For example:

DELETE 1: 00:01:23.450 - 00:01:31.200


The period is now recorded.

Mark more periods

Repeat the same process as many times as necessary:

Ctrl+P  → start
Ctrl+P  → end

Ctrl+P  → start
Ctrl+P  → end

Ctrl+P  → start
Ctrl+P  → end


There is no fixed limit on the number of periods.

Quit mpv

When you quit mpv, the script writes the period information and generates the FFmpeg script.

For:

input.mp4


you will get:

input.periods.txt
input.remove-periods.sh

Periods file

The .periods.txt file contains one deletion period per line:

00:01:23.450    00:01:31.200
00:04:12.100    00:04:18.750
00:07:55.300    00:08:03.900


The two columns are:

START    END


Times use:

HH:MM:SS.mmm


This makes the file easy to process from shell scripts and other tools.

Removing the periods

The generated script is executable:

./input.remove-periods.sh


It runs a single FFmpeg command that:

Keeps everything outside the marked periods.
Removes the marked periods.
Concatenates the remaining sections.
Processes both video and audio.
Produces one output video.

The output is:

input.cut.mp4


For example, if you marked:

00:01:23.450    00:01:31.200
00:04:12.100    00:04:18.750


the resulting video contains:

00:00:00 ─────── 00:01:23.450
                    DELETE
00:01:31.200 ─── 00:04:12.100
                    DELETE
00:04:18.750 ─── END


The remaining sections are joined together.

Overlapping periods

Overlapping periods are automatically merged.

For example, if you mark:

00:01:00.000    00:02:00.000
00:01:45.000    00:02:30.000


the script writes them as one period:

00:01:00.000    00:02:30.000


This prevents redundant FFmpeg segments.

Periods entered backwards

If you accidentally press Ctrl+P at 00:02:00 and then again at 00:01:30, the script automatically reverses the endpoints:

00:01:30.000    00:02:00.000


So you don't have to worry about which direction you seek.

Open period when quitting

If you press Ctrl+P to start a period but don't press it again before quitting mpv, the script closes the period at the current playback position.

For example:

Ctrl+P
...
quit mpv


will use the current playback position as the end of the period.

Output quality

The generated FFmpeg command currently uses:

-c:v libx264 -crf 18 -preset medium
-c:a aac -b:a 192k


This means the video is re-encoded.

The reason is that arbitrary sections of a video cannot generally be removed and concatenated into a new continuous stream using simple stream copying (-c copy).

CRF 18 provides high-quality H.264 output while keeping file sizes reasonable.

You can change these settings in periods.lua if desired.

For example, faster encoding:

-preset fast


or higher quality/larger files:

-crf 16

File naming

Given:

/path/to/My Video.mp4


the script creates:

/path/to/My Video.periods.txt
/path/to/My Video.remove-periods.sh
/path/to/My Video.cut.mp4


The original video is never modified.

Typical workflow

A complete workflow looks like this:

mpv input.mp4


While watching:

Ctrl+P  → unwanted section starts
Ctrl+P  → unwanted section ends

Ctrl+P  → another unwanted section starts
Ctrl+P  → another unwanted section ends


Quit mpv.

Then:

./input.remove-periods.sh


The final edited video is:

input.cut.mp4

Customizing the key

The default key is:

Ctrl+P


It is defined near the bottom of periods.lua:

mp.add_key_binding(
    "CTRL+p",
    "toggle-period",
    toggle_period
)


Change "CTRL+p" to another mpv key if desired.

For example:

mp.add_key_binding(
    "F8",
    "toggle-period",
    toggle_period
)


would use F8.

Notes

The script is intended for local video files.

The generated FFmpeg command re-encodes the output because the selected deletion points can occur at arbitrary timestamps.

The original input file is never overwritten.

The .periods.txt file records what to delete, not what to keep.
