# Soundissue

```bash
/usr/share/pulseaudio/alsa-mixer/paths/analog-output-speaker.conf
```

[youtube](https://www.youtube.com/watch?v=Rqwdlkld9Ck)

1. check the sound cards and their kernel driver details

   `lspci -nnk | grep -A2 Audio`

[fuckH-uawei](https://consumer.huawei.com/en/community/details/Matebook-14-2021-Ubuntu-Linux-No-Sound/topicId_169472/)

`alsamixer`

```bash
cat /proc/asound/cards
 0 [sofhdadsp      ]: sof-hda-dsp - sof-hda-dsp
                      HUAWEI-KLVF_XX-M1010-KLVF_XX_PCB
```

got one sound card

maybe the drivers ? 

```bash
lspci -v | grep -A7 -i "audio"
00:1f.3 Multimedia audio controller: Intel Corporation Device 51c8 (rev 01)
	Subsystem: Huawei Technologies Co., Ltd. Device 3e5d
	Flags: bus master, fast devsel, latency 32, IRQ 163
	Memory at 6001138000 (64-bit, non-prefetchable) [size=16K]
	Memory at 6001000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: <access denied>
	Kernel driver in use: sof-audio-pci-intel-tgl
	Kernel modules: snd_hda_intel, snd_sof_pci_intel_tgl

00:1f.4 SMBus: Intel Corporation Device 51a3 (rev 01)
	Subsystem: Huawei Technologies Co., Ltd. Device 3e5d
	Flags: medium devsel, IRQ 16
	Memory at 6001144000 (64-bit, non-prefetchable) [size=256]
	I/O ports at efa0 [size=32]
```

driivers had been installed and in use



bluetooth :zorin

```bash
sudo apt-get install bluez
sudo systemctl restart bluetooth
bluetoothctl
```



[linuxprising.com](https://www.linuxuprising.com/2018/06/fix-no-sound-dummy-output-issue-in.html)

add `options snd-hda-intel model=generic` in /etc/modprobe.d/alsa-base.conf

```bahs
sudo aplay -l         
[sudo] password for jiahao:       
**** List of PLAYBACK Hardware Devices ****
card 0: sofhdadsp [sof-hda-dsp], device 1: HDMI1 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: sofhdadsp [sof-hda-dsp], device 2: HDMI2 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: sofhdadsp [sof-hda-dsp], device 3: HDMI3 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

```bash
sudo modprobe -r snd_soc_skl                                     
╭─jiahao@wuszorin ~ 
╰─$ sudo modprobe snd_soc_skl   
╭─jiahao@wuszorin ~ 
╰─$ 
```



uncomment

/etc/modprode.d/alsa-base.conf

`options snd-usb-audio index=2`
