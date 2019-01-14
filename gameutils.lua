gameutils = {}

--DEPENDANCIES AND VARS

ioutils=require( "ioutils" )
mutils=require( "miscutils" )
guesses=3
tries=10
attempts=5
-- LOCAL FUNCS
function ifguess()
    if tonumber(guess)==numb then
        print("correct! You got $10")
        money=money+10
        guesses=3
    else
        guesses=guesses-1
        if tonumber(guess) > numb then
            print("Guess lower")
        else
            print("Guess higher")
        end
        if guesses>=1 then
            guessgame()
        else
            guesses=3
            gameutils.ask()
        end
    end
end

function ifdice()
    if tonumber(bet1)==result or tonumber(bet2)==result then
        print("Correct! You get $30")
        money=money+30
    else
        print("Sorry :(")
    end
    print("Number was "..result)
end

function guessgame()
    print("Guess a number 1-10, you have "..guesses.." tries")
    guess=io.read()
    ifguess()
end

function dicegame()
    result = math.random(1, 6)
    print("Enter your first bet:")
    bet1 = io.read()
    if result<tonumber(bet1) then
        print("Guess lower!")
    else
        print("Guess higher!")
    end
    print("Enter your second bet:")
    bet2 = io.read()
    ifdice()
end

function alphaguess()
 alphabet = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
    result = alphabet[math.random(1,#alphabet)]
    repeat
        print("Guess a letter from the alphabet, you have "..tries.." tries!")
        guess=io.read()
        if guess==result then
            print("You got it correct")
            tries=10
            break
        else
            print("Not quite!")
            print("Sorry kiddo, maybe next time")
            tries=tries-1
        end
    until tries<=0
    if tries<=0 then
        tries=10
        playerhp=playerhp-30
    end
end

function minihang()
    print("BOSS HP "..bosshp.."\nPLAYER HP "..playerhp.."\n")
    words = {"youthful", "pillow", "cloud", "welcome", "fatal", "people", "background", "snake", "guess", "foolish", "jupiter", "ground", "random", "function", "integer", "mark", "destroy", "maniacal", "thorough", "death", "baritone", "bass", "rhino", "game", "utility", "complete", "warrior", "solar", "truck", "backpack", "person", "seat", "bumper", "telemetry", "hint", "repeat", "eight", "temple", "forest", "table", "array"}
    word = words[math.random(#words)]
    hint=""
    i=0
    repeat
    print('\n')
    i=i+1
    hint=hint..string.sub(word, i, i)
    print("Your word is "..#word.." letters long and starts with "..hint)
    print("Guess your word, you have "..attempts.." tries")
    answer=io.read()
    if answer==word then
        print("You got it right!")
        money=money+100
        attempts=5
        break
    else
        print("Not quite!")
    end
    attempts=attempts-1
    until attempts<=0
    attempts=5
end

function attack()
    print("You are ATTACKING")
    att=math.random(weapon-2,weapon)
    if att<=0 then
        att=0
    end
    bosshp = bosshp-att
    print(string.upper(name).." deals "..att.." damage to "..string.upper(boss))
end

function defend()
    print("You are DEFENDING")
    def=math.random(0,3)
    print(string.upper(name).." gets "..def.." defense!")
    att=math.random(weapon-4,weapon-2)
    bosshp=bosshp - att
end

function vikingChiefAsmund()
    move = ioutils.questionv("Make your move:", {"attack", "defend"})
    if move=="attack" then 
        attack()
    elseif move=="defend" then
        defend()
    end
    print('\n')
    dmg_max=weapon
    dmg_min=weapon-3
    if dmg_max<=0 then
        dmg_max=0
    end
    if dmg_min<=0 then
        dmg_min=0
    end
    dmg = math.random(dmg_min,dmg_max) - def
    if dmg < 0 then
        dmg=0
    end
    print("VIKING CHIEF ASMUND deals "..dmg.." damage to "..string.upper(name))
    playerhp=playerhp-dmg
    print("PLAYER HP", playerhp)
    print("BOSS HP", bosshp)
    print('\n')
end

function antron()
    move = ioutils.questionv("Make your move: ", {"attack", "defend"})
    if move=="attack" then
        attack()
    else
        defend()
    end
    print('\n')
    print("You have a chance to save yourself!!!")
    alphaguess()
end

function hangman()
    move = ioutils.questionv("Make your move", {"attack", "defend"})
    if move=="attack" then
        attack()
    else
        defend()
    end
    print('\n')
    minihang()
    dmg=math.random(1,3)
    damage=dmg-def
    playerhp=playerhp-damage
end

-- UTIL FUNCS
function gameutils.calculateclass(numb)
    if numb=="1" then
        class="wizard"
        weapon=1
        health=7
    elseif numb=="2" then
        class="warrior"
        weapon=3
    elseif numb=="3" then
        class="assassin"
        money=30
    else
        print("Invalid command "..numb)
        os.exit()
    end
end

function gameutils.ask()
    print("What would you like to do? \n 1: visit shop \n 2: check inventory \n 3: compete in a challenge \n 4: fight boss")
    text=io.read()
    if text=="1" then
        print("Select purchase. If you do not wish to buy anything, type 'q' \n 1: upgraded weapon ($50) \n 2: upgraded health ($50)")
        t=io.read()
        if t=="1" then
            if money >= 50 then
               weapon=weapon+1
               money=money-50
               print("You bought an UPGRADED WEAPON for $50")
               gameutils.ask()
            else 
               print("Not enough money :/")
                gameutils.ask()
            end
        elseif t=="2" then
            if money>=50 then
              health=health+5
              money=money-50
              print("Bought one LIFE UPGRADE for $50")
              gameutils.ask()
            else 
                print("Not enough money :/")
                gameutils.ask()
            end
         elseif t==string.upper("Q") then
              print("Redirecting")
              gameutils.ask()
         end
         
            
    elseif text=="2" then
        print(" NAME: "..name.."\n CLASS: "..class.."\n MONEY: "..money.."\n WEAPON DMG: "..weapon.."\n HEALTH: "..health.."\n")
        gameutils.ask()
    elseif text=="3" then
        games = {"guess", "dice"}
        game = games[math.random(1,#games)]
        print("GAME IS "..string.upper(game))
        if game=="guess" then
            numb=math.random(1,10)
            guessgame()
            gameutils.ask()
        elseif game=="dice" then
            dicegame()
            gameutils.ask()
        else
            print("ERR LOADING GAME FUNC, RESTARTING ASK()")
            gameutils.ask()
        end
    
    elseif text=="4" then
        print(" STATS ARE: \n NAME: "..name.."\n CLASS: "..class.."\n MONEY: "..money.."\n WEAPON DMG: "..weapon.."\n HEALTH: "..health)
        boss = bosses[math.random(1,#bosses)]
        if boss=="Viking Chief Asmund" then
            bosshp = 20
            playerhp=health
            print("You are fighting "..string.upper(boss))
            repeat
            vikingChiefAsmund()
            until bosshp<=0 or playerhp<=0
            if playerhp<=0 then
                print("YOU DIED \n")
            else
                print("YOU WON!")
                money=money+100
            end
            gameutils.ask()
            
        elseif boss=="Antron" then
            bosshp=10
            playerhp=health
            print("You are fighting "..string.upper(boss))
            repeat
                antron()
            until bosshp<=0 or playerhp<=0
            if playerhp<=0 then
                print("YOU DIED \n")
            else
                print("YOU WON!")
                money=money+100
            end
            gameutils.ask()
        elseif boss=="Hangman" then
            bosshp=20
            playerhp=health
            print("You are fighting "..string.upper(boss).."!")
            repeat
                hangman()
            until playerhp<=0 or bosshp<=0
            if playerhp<=0 then
                print("YOU DIED\n")
            else
                print("YOU WIN!\n")
            end
        end
    elseif text=="69" then
        print("\n nice \n")
        gameutils.ask()
    elseif text=="420" then
        print("\n blaze it \n")
        gameutils.ask()
    else
        print("Invalid command "..text)
        gameutils.ask()
    end
        
end
return gameutils