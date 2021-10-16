using System;
using System.Diagnostics;

namespace Wrapper{
    class Program{
        static void Main(){
            Process proc = new Process();
	    ProcessStartInfo procInfo = new ProcessStartInfo("powershell.exe" , "YOUR-COMMAND");
	    procInfo.CreateNoWindow = true;
	    proc.StartInfo = procInfo;
            proc.Start();
        }
    }
}


