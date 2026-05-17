# Setup-Ventoy-USB

In my opinion, Ventoy is the best software to make bootable USB drives with. It easily allows multiple ISOs on the same drive without needing to format the drive just to flash another ISO onto it. test

Wanna boot Windows? Put a Windows ISO on there! Wanna boot Fedora as well? Put the Fedora ISO directly next to the the Windows ISO. Oh, you have an autounattend file to do the all that configuration of the Windows install? [Ventoy has you covered!](#ventoy-autoinstall)

## Installing and Setting up Ventoy <a id="ventoy-setup"></a>

On Windows, the easiest and fastest way to install and start using Ventoy is using PowerShell.

1. Open PowerShell and enter `winget install --id Ventoy.Ventoy -e` (Utilising Windows inbuilt package manager is efficient and secure)
2. Once installed, a command line alias will be added to run Ventoy. Enter `Ventoy2Disk` into PowerShell now (Note, you might need to close and reopen PowerShell for this to work)
3. Ventoy will now be open.
4. Find your device in the **Device** drop down (if more than 1 inserted into PC).
5. Click **Install**
6. You have a working Ventoy USB! All you need to do now is put any operating system ISO files into the root of the *Ventoy* USB that appears in Windows. The *VTOYEFI* one is the wrong location for the ISO files.

### Using an autounattend.xml file with Ventoy's Auto Install Plugin <a id="ventoy-autoinstall"></a>

<details>
  <summary>Click to Show Instructions</summary>

1. Download the  `autounattend.xml` file and save it on your computer.
2. Download the [Windows 11](https://www.microsoft.com/en-us/software-download/windows11#:~:text=Download%20Windows%2011%20Disk%20Image%20\(ISO\)%20for%20x64%20devices) ISO file, depending on the version you want.
3. Download and install Ventoy to your desired USB flash drive using the instructions at the [top of this guide](#ventoy-setup)
4. Prepare the folder structure:
   * In your newly created Ventoy USB disk, create the following folders: `ISO` and `Templates`.
     * *They should be at the root of the drive.*
   * Inside of the `ISO` folder, create a new folder called `Windows`.
   * Copy your Windows ISO files in the `ISO\Windows` folder.
   * Copy your `autounattend.xml` into the `Templates` folder.
5. Start VentoyPlugson. Depending on your OS, the steps might differ.
   * On Windows, run the `VentoyPlugson.exe` file (if you followed the steps at the top of this guide, you can enter `VentoyPlugson` into PowerShell to open it")
   * A new browser window should open up with a Ventoy web interface ready to go.
   * Select the `Auto Install Plugin` menu from the list.
   * Click on the `Add` button.
   * Select [parent] to make the whole Windows ISO folder benefit from the plugin.
   * In the Directory Path, paste in the absolute path to your `Windows` folder.
     * example: `F:\ISO\Windows` (Replace `F` with your drive letter.)
   * In the Template Path, paste in the absolute path to your `autounattend.xml` file.
     * example: `F:\Templates\autounattend.xml` (Replace `F` with your drive letter.)
   * Click on `OK` and you should see a message saying that the configuration has been saved successfully.
   * Close the VentoyPlugson browser window and stop the VentoyPlugson application.
6. Boot from the Ventoy USB drive in the computer where you want to install windows.
   * After selecting a Windows ISO to boot from, you will be prompted to boot with the `/Templates/autounattend.xml` file.
   * Select that option and the `autounattend.xml` will be automatically executed during installation.

</details>
