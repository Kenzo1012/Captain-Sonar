functor
import
   GUI
   Input
   PlayerManager
define
   StreamGUI
   PortGUI
   SetPorts
   InitPlayers
   MovePlayer
   Tup
   Turn
   L
   LoadGame
   Dive
   Direction
   NewPosition
   PlayerLoad
   PlayerFire
   Tu
   TurnByTurn
in
   {Tuple.make 'ports'  Input.nbPlayer Tu}
   proc{SetPorts ID Players Colors}
      if ID < Input.nbPlayer+1 then
	 case Players of nil then skip
	 []A|B then case Colors of nil then skip
		    []C|D then Tu.ID =  {PlayerManager.playerGenerator A C ID}
		       {SetPorts ID+1 B D}
		    end
	 end
      else skip
      end
   end
   proc{InitPlayers ID Colors Players}
      local Position in
	 if ID < Input.nbPlayer+1 then
	    case Colors of nil then skip
	    []H|T then case Players of nil then skip
			  []U|V then
	       {Send Tu.ID initPosition(id(id:ID color:H name:U) Position)}
	       {Send PortGUI initPlayer(id(id:ID color:H name:U) Position)}
	       {InitPlayers ID+1 T V}
		       end
	    end   
	 else skip
	 end
      end
   end 
   proc{MovePlayer ID Player Color Direction}
      local Position in
	 if ID > 0 then
	    case Player of nil then skip
	    []H then case Color of nil then skip
		     []U then {Send Tu.ID move(id(id:ID color:Color name:Player) Position Direction)} {Send PortGUI movePlayer(id(id:ID color:Color name:Player) Position)}
		     end
	    end
	    else skip
	 end
      end
   end
   proc{PlayerLoad ID Player Color Item}
      if ID > 0 then
	 case Player of nil then skip
	 []H then case Color of nil then skip
		  []U then {Send Tu.ID chargeItem(id(id:ID color:Color name:Player) Item)}
		  end
	 end
      else skip
      end
   end
   proc{PlayerFire ID Player Color KindFire}
      local Position X Y in
	 if ID > 0 then
	    case Player of nil then skip
	    []H then case Color of nil then skip
		     []U then {Send Tu.ID fireItem(id(id:ID color:Color name:Player) KindFire)}
			case KindFire of mine(x:X y:Y) then {Send PortGUI putMine(ID pt(x:X y:Y))}
			[]missile(x:X y:Y) then skip
			[]drone then skip
			end
		     end
	    end
	 else skip
	 end
      end
   end
   proc{LoadGame ID Round} %% Fonction principale du tour par tour
     local Answer Position Direction P in
      if ID > 0 andthen ID =<Input.nbPlayer then {Send Tu.ID isSurface(ID Answer)}
	 if Answer == true then {LoadGame ID+1 Round+1}
	 else
	    if Round == 0 %first move of the game or first move after having surfaced
	    then
	       {Send Tu.ID dive}
	    else
	       {Send Tu.ID move(Position Direction)}
	       if Direction == surface then
		  {Send ports saySurface(Tu.ID)}
		  {Send PortGUI surface(Tu.ID)}
		  
	       else
		  {Send ports sayMove(ID Position east)}
		  
		  {Send PortGUI MovePlayer(ID Position)}
	       end
	       
	    end
	    
	 end
      end
     end
   end
   
   
    
   {SetPorts 1 Input.players Input.colors} 
   PortGUI = {GUI.portWindow}
   {Send PortGUI buildWindow}
   {InitPlayers 1 Input.colors Input.players}
   
      case Input.isTurnByTurn of true then
	 {LoadGame 1 0}
      [] false then
	 skip
      end
   end