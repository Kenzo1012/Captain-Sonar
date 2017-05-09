all: compile exe

compile: 
	/Applications/Mozart2.app/Contents/Resources/bin/ozc -c GUI.oz Input.oz Main.oz Player043Kenzo.oz Player043Justine.oz PlayerManager.oz

exe:
	/Applications/Mozart2.app/Contents/Resources/bin/ozengine Main.ozf

clean:
	rm *.ozf
