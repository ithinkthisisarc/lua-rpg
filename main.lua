-- DEPENDANCIES
gameutils=require( "gameutils" )

-- VAR DECLARATION
class="NULL"
money=0
weapon=2
health=5
def=0
bosses = {
    "Viking Chief Asmund",
    "Antron",
    "Hangman"
}

-- GAME CHUNK
print("Hello, what shall you be called?")
name = io.read()
print("Choose your class: \n 1: wizard \n 2: warrior \n 3: assassin")
classnumb=io.read()
gameutils.calculateclass(classnumb)
print("You have selected "..class)
gameutils.ask()