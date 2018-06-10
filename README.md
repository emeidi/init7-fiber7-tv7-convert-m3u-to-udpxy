# init7-fiber7-tv7-convert-m3u-to-udpxy
Downloads the current Init7 Fiber7 TV7 multicast IPTV channel list in m3u format and converts it for using it with a udpxy enabled unicast server in the LAN

By using a unicast "proxy" you can stream IPTV to devices connected to your WLAN (e.g. iPhone, iPad).

# Requirements
* Linux server in LAN
* wget installed on Linux server
* HTTP server installed and running on Linux server
* wwwroot at `/var/www/html` (user configurable in script)
* updxy (Multicast to Unicast converter) compiled, installed and runnning on Linux server
  * http://www.udpxy.com
* Subscriber of Fiber7 Switzerland (this script might work with other IPTV providers if they publicly publish their M3U channel list)
* Fiber7 `api.init7.net` server online and serving https://api.init7.net/tvchannels.m3u
* Router configured with IGMP proxy and multicast forwarding for multicast TV streams arriving in LAN

# Installation
* Download `convert-m3u.sh` to your Linux server which both runs udpxy as well as a web server (Apache, nginx, lighthttpd ...)
* Create folder `/var/www/html/tv` if it does not yet exist
* Run `convert-m3u.sh`
* Point your IPTV app (e.g. iPlayTV, rIPTV) to http://%IP%/tv/Fiber7.TV.emeidi.local.m3u to retrieve the M3U8 channel list
* Select a channel in your IPTV app
* Wait for the multicast stream to buffer and start
* Watch TV stream

# TODO
* Rename M3U channel names provided by Init7 so IPTV apps display the appropriate channel logo (if available — works only for half the channels out of the box)
