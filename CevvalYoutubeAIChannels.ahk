Ctrl::
If (A_ThisHotkey == A_PriorHotkey && 51 < A_TimeSincePriorHotkey && A_TimeSincePriorHotkey <= 500)  ; Check if ctrl was hit twice in short sequence.
{
Clipboard :=
WinActivate, Firefox
WinWaitActive, Firefox
Click, Right
Sleep, 60
Send, l
ClipWait, 1
youtubeurl := Trim(Clipboard)  ; get Youtube url from clipboard

; Validate YouTube
If !(InStr(youtubeurl, "youtube.com") || InStr(youtubeurl, "youtu.be"))  ; Exit if we're not on a youtube page
    Return

downloadyoutubepage := UrlDownloadToVar(youtubeurl)  ; Call the subroutine to download the current page. We'll search the source later

youtubeAIusername := ""
youtubeAIchannelid := ""

; Now we'll try a few regexs to get the channel ID. Not all of them works on every youtube page
RegExMatch(downloadyoutubepage, "i)""channelId"":\s*""(UC[\w-]+)""", youtubeAIchannelid)
        If (youtubeAIchannelid1 = "")
RegExMatch(downloadyoutubepage, "i)<meta[^>]*\bitemprop\s*=\s*[""']channelId[""'][^>]*\bcontent\s*=\s*[""'](UC[\w-]+)[""'][^>]*>", youtubeAIchannelid)
        If (youtubeAIchannelid1 = "")
RegExMatch(downloadyoutubepage, "i)<link[^>]*\brel\s*=\s*[""']canonical[""'][^>]*\bhref\s*=\s*[""'][^""']*/channel/(UC[\w-]+)[^""']*[""'][^>]*>", youtubeAIchannelid)
        If (youtubeAIchannelid1 = "")
RegExMatch(downloadyoutubepage, """channelId"":""(UC[A-Za-z0-9_\-]+)""", youtubeAIchannelid)

RegExMatch(downloadyoutubepage, """canonicalBaseUrl"":""/(@[^/\""]+)""", youtubeAIusername)  ; Get the user name from page source

; Write the block rules
youtubeAIblockrulec := "youtube.com##ytd-video-renderer:has(a[href*=""" . youtubeAIchannelid1 . """]), ytd-grid-video-renderer:has(a[href*=""" . youtubeAIchannelid1 . """])"
youtubeAIblockruleu := "youtube.com##ytd-video-renderer:has(a[href*=""" . youtubeAIusername1 . """]), ytd-grid-video-renderer:has(a[href*=""" . youtubeAIusername1 . """])"

Clipboard := youtubeAIblockrulec "`n" youtubeAIblockruleu  ; Put the block rules into clipboard

; Read the existing rules we have built so far, and then check for duplicates
youtubeblocklogfile := A_ScriptDir . "\CevvalYoutubeAIblocklist.txt"
FileRead, existingyoutubeblockrules, %youtubeblocklogfile%

If !InStr(existingyoutubeblockrules, youtubeAIchannelid1)  ; If there are no duplicates, append these new rules into the file
    FileAppend, %Clipboard%`n, %youtubeblocklogfile%
    
If !UpdateLastUpdatedInPlace(youtubeblocklogfile)
    MsgBox, 16, Error, Could not find/update "! Last updated:" line.
}


; Subroutine to download the page
UrlDownloadToVar(youtubeurl) {
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", youtubeurl, false)
whr.Send()
Return whr.ResponseText
}


; Subroutine to update the last update date
UpdateLastUpdatedInPlace(YTBlockListPath) {
    FormatTime, YTBlockListUpdateToday,, yyyy-MM-dd  ; always 10 chars
    YTBlockListUpdatePrefix := "! Last updated: "     ; 16 chars (ASCII)
    YTBlockListFile := FileOpen(YTBlockListPath, "rw", "UTF-8-RAW")
    If !IsObject(YTBlockListFile)
        Return False
    While !YTBlockListFile.AtEOF {
        lineStart := YTBlockListFile.Pos
        line := YTBlockListFile.ReadLine()  ; reads one line, no CRLF in returned text
        If (SubStr(line, 1, StrLen(YTBlockListUpdatePrefix)) = YTBlockListUpdatePrefix) {
            ; Seek to first date character and overwrite only 10 chars
            YTBlockListFile.Pos := lineStart + StrLen(YTBlockListUpdatePrefix)
            YTBlockListFile.Write(YTBlockListUpdateToday)
            YTBlockListFile.Close()
            Return True
        }
    }
    YTBlockListFile.Close()
    Return False
}
