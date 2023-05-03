# RFkill_and_wireless_interface_issue

RFkill is a Linux kernel feature that provides a unified interface for disabling wireless devices, such as Wi-Fi, Bluetooth

```bash
iwconfig (check if the wireless interface is powered off)
ip link set wlan0 up (turn the interface on)
```

```bash
operation not possible due to RF-kill" means that your wireless device is soft-blocked or hard-blocked by a hardware or software switch. 
```

```bash
rfkill list (check if your device is blocked)
sudo rfkill unblock wifi (unblock the wireless device and allow you to bring it up with the ip link set wlan0 up command.)
```

**software-blocked** device been turned off or disabled using software command

**hardware-blocked** device been turn off using a **physical switch or button**

