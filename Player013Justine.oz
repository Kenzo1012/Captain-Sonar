functor
import
   OS
   Input
export
   portPlayer:StartPlayer
define
   MyPosition
   CurrentPos
   StartPlayer
   TreatStream
   NewPosition
   InitPosition
   InitId
   IsSurface
   MoveP
   LoadItem
   FireItem
   Fire
   Path
   Surface
in
   fun{InitId ID}
      Id
   in
      id(id:Id color:blue name:"player013justine") = ID
      ID
   end
   fun{MoveP Actual Direction}
      X Y Position
   in 
      pt(x:X y:Y) = Actual
      case Direction of east then Position = pt(x:X y:Y+1)
      [] west then Position = pt(x:X y:Y-1)
      [] north then Position = pt(x:X-1 y:Y)
      [] south then Position = pt(x:X+1 y:Y)
      end
      Position
   end
   fun{LoadItem Item KindItem}
      Mine Missile Drone NewItem
   in
      [Mine Missile Drone] = Item
      case KindItem of mine then NewItem = [Mine+1 Missile Drone]
      []missile then NewItem = [Mine Missile+1 Drone]
      []drone then NewItem = [Mine Missile Drone+1]
      end
      if NewItem.1 == Input.mine then skip
      else if NewItem.2.1 == Input.missile then skip
	   else if NewItem.2.2.1 == Input.drone then skip
		end
	   end
      end
      NewItem
   end
   fun{Fire Item KindFire}
      Mine Missile Drone NewItem
   in
      [Mine Missile Drone] = Item
      case KindFire of mine(x:X y:Y) then
	 if Item.1 == 3 then NewItem = [Mine-3 Missile Drone]
	 else skip
	 end
      []missile then
	 if Item.2.1 == 3 then NewItem = [Mine Missile-3 Drone]
	 else skip
	 end
      []drone then
	 if Item.2.2.1 == 3 then NewItem = [Mine Missile Drone -3]
	 else skip
	 end
      end
      NewItem
   end
   fun{IsSurface Surf}
      local Surface in
	 if Surf == true then Surface = true
	 else Surface = false
	 end
	 Surface
      end
   end
	 fun{StartPlayer Color ID}
	    Stream
	    Port
	    ID Stream Position Dive Item FireItem
	 in
	    {NewPort Stream Port}
	    thread {TreatStream Stream Path Item true} end
	    Port
	 end
	 proc{TreatStream Stream Path Item Surface}% has as many parameters as you want ...
	    X Y Color Id
	 in 
	    case Stream of initPosition(ID Position)|T then ID =id(id:ID color:green name:player013justine) Position = pt(x:8 y:9) {TreatStream T Position|Path Item Surface}
	    []move(ID Position Direction)|T then Position = {MoveP Path.1 Direction} {TreatStream T Position|Path Item Surface}
	    []dive|T then {TreatStream T Path Item Surface}
	    []chargeItem(ID KindItem)|T then {TreatStream T Path {LoadItem Item KindItem} Surface}
	    []fireItem(ID KindFire)|T then {TreatStream T Path {Fire Item KindFire} Surface}
	    []isSurface(ID Answer)|T then ID =id(id:ID color:green name:player013justine) Answer = {IsSurface Surface}  {TreatStream T Path Item Surface}
	    end
	 end
      end




