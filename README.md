<p align="center">
    MeloNX enables Nintendo Switch game emulation on iOS using the Ryujinx iOS code base.

<h1 align="center">
  <br>
  <a href="https://melonx-emu.github.io/"><img src="[https://i.imgur.com/WcCj6Rt.png](https://cdn.discordapp.com/attachments/1292940840351830036/1300130114675146882/DALLE_2024-10-13_07.20.07_-_A_minimalistic_logo_for_a_Nintendo_Switch_emulator_meloNX_incorporating_a_melon_instead_of_Joy-Con_controllers._The_logo_features_a_thin_rectangula_copy.jpg?ex=672060c6&is=671f0f46&hm=95abc7075ab79cfab8236e774187aa1f49d4bca2913ee93d77aae435727ae686&)" alt="MeloNX" width="150"></a>
  <br>
  <b>MeloNX</b>
  <br>
</h1>

<p align="center">
       MeloNX is an iOS Nintendo Switch emulator based on Ryujinx, written primarily in C#. Designed to bring accurate performance and a user-friendly interface to iOS, MeloNX makes Switch games accessible on Apple devices.
       Developed from the ground up, MeloNX is open-source and available on Github under the <a href="https://github.com/MeloNX/MeloNX/blob/master/LICENSE.txt" target="_blank">MIT license</a>. <br />
</p>

<p align="center">
    <a href="https://github.com/MeloNX-Emu/MeloNX/actions/workflows/release.yml">
        <img src="https://github.com/MeloNX-Emu/MeloNX/actions/workflows/release.yml/badge.svg" alt="">
    </a>
    <a href="https://discord.com/invite/MeloNX">
        <img src="https://img.shields.io/discord/410208534861447168?color=5865F2&label=MeloNX&logo=discord&logoColor=white" alt="Discord">
    </a>
    <br>
    <br>
    <img src="https://i.imgur.com/WcCj6Rt.png" alt="MeloNX Screenshot">
</p>

## Compatibility

As of October 2023, MeloNX can only play the audio of games.

## Usage

To run MeloNX on your iOS device, at least 8GB of RAM is recommended to ensure stability. For full instructions, refer to our [Setup Guide](https://github.com/MeloNX/MeloNX/wiki/Setup-Guide).

## Features

 - **Audio**  
   MeloNX fully supports audio output. Audio input is not yet supported.

 - **CPU Emulation**  
   The ARMeilleure CPU emulator emulates an ARMv8 CPU, handling most ARMv8 and some ARMv7 instructions. It converts ARM code to x86 for improved performance on iOS devices.

 - **Graphics**  
   MeloNX supports both OpenGL and Vulkan rendering for flexible GPU emulation. Graphics enhancements include resolution scaling, anti-aliasing, and disk shader caching.

 - **Input**  
   Support includes touch, JoyCon, and various controllers compatible with iOS. Dual-JoyCon input support requires additional software like DS4Windows.

 - **DLC & Mods**  
   The emulator supports add-on content and mods through its GUI, allowing users to enhance their gaming experience.
   
