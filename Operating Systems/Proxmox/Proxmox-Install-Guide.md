# Proxmox Install Guide

This guide is for installing and setting up Proxmox VE for use as a home server. This is probably like 1% of what Proxmox VE is capable of but it should be a decent starting point to get you started.

## Requirements for this guide

### Mandatory

1. USB Drive (with bootable Proxmox ISO on it, [Proxmox ISO found here](https://www.proxmox.com/en/downloads/proxmox-virtual-environment))
   1. My suggestion, using Ventoy is amazing for making bootable USB drives. This is easy to do and you can follow [this guide](../Setup-Ventoy-USB.md) to do that.
1. A PC of some sort. This could be laptop, desktop, whatever! Hardware is so capable from the last 5-6 years, if you have a PC from 2020 or newer, it should be viable. My first home server was a laptop with an Intel i5 8th gen processor with a 512GB SSD.
1. Keyboard
1. Wired network connection.
   1. Wi-Fi is fine for testing out the process of installing Proxmox but is compatible with use for a permanent home server.
1. Willingness to learn some new stuff, ask questions and do your own research afterwards.

### Beneficial

1. Mouse

## Installing Proxmox VE

**BE AWARE THAT INSTALLING PROXMOX WILL FORMAT (ie delete everything on) YOUR CURRENT DRIVE. DO NOT PROCEED IF YOU ARE NOT WILLING TO LOSE YOUR FILES ON YOUR CURRENT DRIVE.**

1. Insert bootable USB into PC, turn PC on and go into BIOS (BIOS key is usually one of ESC, F10, F12) and select it as your boot device.
1. In Ventoy, select the Proxmox ISO, then select 'Boot in normal mode'.
1. In the Proxmox welcome screen, press enter on 'Install Proxmox VE (Graphical)'

### Proxmox VE Installation

These steps should apply to 99.9% of basic installs. However if you are going to run any more advanced configs you might need to change things up.

<details>
  <summary>My Advice and Warning for Using LLMs with Setting up Home Server</summary>

While LLMs can prove helpful with specific questions, absolutely do not rely on what they say as truth. The default installer options are the way they are for a reason set by the developers, they are the best general options for most use cases. LLMs will tell you to do all sorts of random things like using different filesystems instead of the default ext4, or set weird partition schemes. It'll tell you to run bash commands in Proxmox that might have unintended consequences. Use it if you need to but use it as a guide only.

</details>

#### Proxmox VE Installer Screens

As of 9.1 ISO Installer the following screens will appear in this order:

1. End User License Agreement
   1. Press 'I agree' to proceed
2. Proxmox Virtual Environment (PVE)
   1. Ensure the correct disk is select to install Proxmox on
   2. Press 'Next'
3. Location and Time Zone Selection
   1. Set the Country and Time zone
4. Administration Password and Email Address
   1. Set and confirm the password for the 'root' account (The 'root' account in most Linux distros is the main admin account that has complete permissions)
   2. If wanting to setup email notifications from Proxmox directly, you can enter your real email. It isn't for marketing, its solely for notifications that YOU can setup. If you don't want it, enter whatever you want ie <fake@fake.fake>
5. Management Network Configuration (this is the most technical screen in the setup and will likely need you to look up these values on your own home network)
   1. Management Interface (The primary network interface Proxmox will use). Depending on your hardware, will likely have an ethernet interface and maybe a wifi interface.
   2. Hostname (FQDN) - This is the name of your server but it must be presented as a 'Fully Qualified Domain Name' (FQDN), this means it needs atleast a name and a domain, ie server.local. This can be used for more than just the name but simply just do WhateverYouWant.local and it at that (.local is a commonly user 'domain' for home servers)
   3. IP Address (CIDR) - This is the IP address you assign to your network interface AND its subnet mask. You will need to find your own IP address range of your home network and find a suitable IP address to assign. You will also need to find your subnet mask, thats the part after the slash. If you do not know what it is, the easiest way to find this is find a windows device already on your network, open PowerShell, type `ipconfig` find the Subnet Mask value (will look like 255.255.255.0). Then find a subnet mask cheat sheet online like [this one](https://www.freecodecamp.org/news/subnet-cheat-sheet-24-subnet-mask-30-26-27-29-and-other-ip-address-cidr-network-references/) and find the CIDR value associated with it.
      1. Ideally you set this address in your router as a static IP so your router doesn't assign it to another device on the network.
   4. Gateway - Very likely your router's IP address. It is also in the output of `ipconfig` as mentioned above.
   5. DNS Server - Do one of the following:
      1. Either set it as your router (this will likely use your ISP's DNS server)
      2. Set it as 1.1.1.1 (Cloudflare's DNS Server)
      3. Taking it further, set your DNS server on your router to 1.1.1.1 (Cloudflare) and alternate DNS server as 9.9.9.9 (Quad9) and set the Proxmox's DNS server as the router as it will then go to 1.1.1.1 and 9.9.9.9 (You can use 8.8.8.8 but meh, I don't much care for Google)
6. Summary **(Remember that proceeding with the install will format your drive!)**
7. Installing Screen
