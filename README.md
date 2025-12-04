Being fed up with AI-generated spam in youtube search results, I created this list. I'll update it every now and then. Feel free to use it.

You can add it to your Ublock filters by opening ublock's dashboard, going to filter lists, scrolling down to "Import", writing the address "https://raw.githubusercontent.com/cevvalkoala/CevvalYoutubeAIBlocklist/main/CevvalYoutubeAIblocklist.txt" (without quotes), and clicking "Apply Changes" at the top. Now it is one of your filters, and will update automatically along with your other filters.

YoutubeAIChannels.ahk is the Autohotkey v1 script I use to quickly build the list. It basically copies (when I double-press ctrl) the URL of the link I'm hovering on a youtube page. The link can be a video link or a channel root page link. The script then identifies the user name and the channel ID, and then creates 4 lines of ublock filter rules with those. Feel free to use it as well.

The script adds those 4 lines to a text file named "CevvalYoutubeAIblocklist.txt" in the same folder with the script. That's the file I use to update the list you see here. Obviously, the lines you created using the script aren't added to the list served here. To do that, you'll have to send them to me, and I'll add them to the list. I guess github has some other mechanism to update files as a community, but I'm pretty new in these stuff.

Your recommendations and ideas are most welcome: cevval@cevvalkoala.com
