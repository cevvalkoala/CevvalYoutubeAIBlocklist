Being fed up with **AI-generated spam** in [Youtube](https://www.youtube.com) search results, I created this list. I'll update it every now and then. Feel **free** (as in beer and speech both) to use it.

## How to add it to Ublock?
1. Open [Ublock's](https://github.com/gorhill/uBlock) dashboard (Click on the uBlock Origin Extension. In the bottom right, there is a cog-wheel symbol named the dashboard. Click it.)
2. To the top of the dashboard, click on the tab that says "Filter lists"
3. Scroll down to "Import"
4. Copy and paste this URL into the box:
   ```
   https://raw.githubusercontent.com/cevvalkoala/CevvalYoutubeAIBlocklist/main/CevvalYoutubeAIblocklist.txt
   ```
5. Click "Apply Changes" at the top.

Now it is one of your filters, and will update automatically along with your other filters.

## The script I used to create this list
CevvalYoutubeAIChannels.ahk is the [Autohotkey](https://www.autohotkey.com/) v1 script I use to quickly build the list. It basically copies (when I double-press ctrl) the URL of the link I'm hovering on a youtube page. The link can be a **video** link or a **channel root page** link. The script then identifies the *user name* and the *channel ID*, and then creates 4 lines of ublock filter rules with those. Feel free to use it as well.

The script adds those 4 lines to a text file named "CevvalYoutubeAIblocklist.txt" in the same folder with the script. That's the file I use to update the list you see here. Obviously, the lines you created using the script aren't added to the list served here. To do that, you'll have to send them to me, and I'll add them to the list. I guess github has some other mechanism to update files as a community, but I'm pretty new to these stuff.

## Contact
Your recommendations and ideas are most welcome: cevval@cevvalkoala.com
