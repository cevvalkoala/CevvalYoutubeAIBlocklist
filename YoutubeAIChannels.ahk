If (TaskSwitch = "q")  ; Add the AI music channels on Youtube to a blocking list for ublock
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

RegExMatch(downloadyoutubepage, """canonicalBaseUrl"":""/(?:@|c/)([^/\""]+)""", youtubeAIusername)
  ; Get the user name from page source

; Write the block rules
youtubeAIblockrulec1 := "youtube.com##ytd-video-renderer:has(a[href*=""" . youtubeAIchannelid1 . """])"
youtubeAIblockrulec2 := "youtube.com##ytd-grid-video-renderer:has(a[href*=""" . youtubeAIchannelid1 . """])"
youtubeAIblockruleu1 := "youtube.com##ytd-video-renderer:has(a[href*=""" . youtubeAIusername1 . """])"
youtubeAIblockruleu2 := "youtube.com##ytd-grid-video-renderer:has(a[href*=""" . youtubeAIusername1 . """])"

Clipboard := youtubeAIblockrulec1 "`n" youtubeAIblockrulec2 "`n" youtubeAIblockruleu1 "`n" youtubeAIblockruleu2  ; Put the block rules into clipboard

; Read the existing rules we have built so far, and then check for duplicates
youtubeblocklogfile := A_ScriptDir . "\CevvalYoutubeAIblocklist.txt"
FileRead, existingyoutubeblockrules, %youtubeblocklogfile%

If !InStr(existingyoutubeblockrules, youtubeAIchannelid1)  ; If there are no duplicates, append these new rules into the file
    FileAppend, %Clipboard%`n, %youtubeblocklogfile%
}


; Subroutine to download the page
UrlDownloadToVar(youtubeurl) {
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", youtubeurl, false)
whr.Send()
Return whr.ResponseText
}
