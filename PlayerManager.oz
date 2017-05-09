functor
import
   Player043Kenzo
   Player043Justine
export
   playerGenerator:PlayerGenerator
define
   PlayerGenerator
in
   fun{PlayerGenerator Kind Color ID}
      case Kind
      of player043kenzo then {Player043Kenzo.portPlayer Color ID}
      [] player043justine then {Player043Justine.portPlayer Color ID}
      end
   end
end
