functor
import
GUI at 'GUI.ozf'
Input
PlayerManager
define
   StreamGUI
   PortGUI
   StreamP1
   PortP1
   StreamP2
   PortP2
   Turn
   Dive
in
    GUI.portWindow = {NewPort StreamGUI}
   {Send GUI.portWindow buildWindow}
   {NewPort StreamP1 PortP1}
   {NewPort StreamP2 PortP2}
  
end
