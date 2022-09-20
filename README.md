# USBIP Linux to Windows input sharing

## Description

This repo contains scripts that I use to share a mouse and a keyboard from a Linux host to a Windows client via USB/IP.

There is also a custom [polybar](https://github.com/polybar/polybar) module that can toggle the sharing when clicked and display the current status (devices shared or not).

_The script uses font-awesome 4 to display these icons_

![polybar module screenshot](./screenshots/polybar.png)

## Usage

If you want to use this, copy the files from _windows_ directory to your Windows machine (I use C:\usbip. this path is important, it is used in windows-side scripts), and configure the busId's in the **usbipExportConfig.sh** and **usbipImportConfig.bat**.

You also might want to setup OpenSSH server on the Windows client to communicate with it (to call **attach.bat** when exporting the devices).

Otherwise, you will need a way to trigger these scripts without using the previously exported devices (for example, I have a touchpad on the Linux host and I can use that to click the polybar module, but the script can be fully automated with ssh servers and key-based automatic authentication on both sides).

I see 2 major options of configuring and using this solution:
```

    1. Ssh servers with key-based authentication on both sides;
    
        SSH_ENABLE_ON_BIND=1
        SSH_ENABLE_ON_UNBIND=0
        SSH_ENABLE_ON_ATTACH=0
        SSH_ENABLE_ON_DETACH=1
        
        This way, you can use a single set of peripherals to toggle between devices. On Windows, you can create shortcut files for click-to-toggle.
    
    2. No ssh, some way to trigger the scripts manually on both sides.
        
        **Example:**
     
        export the devices on linux host
        on the windows side, use an external mouse or a keyboard to trigger attach.bat
        when done, run detach.bat
        on the linux side, unbind the devices from usbip by using an external input device again
        
    3. There might be other variants, you are welcome to use it however you like. (perhaps, using some hotkeys on either side would be a good idea)
```
