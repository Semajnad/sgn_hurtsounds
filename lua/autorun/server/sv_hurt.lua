//Is this addon activated? true = yes, false = no
local addonActivated = true

//At what % of health do you want the "I'm hurt" sound to play?
local activationHealthPercent = 30

// DO NOT TOUCH ANYTHING PAST THIS LINE //

//This prepares soundCheck network message to be sent below.
util.AddNetworkString( "soundCheck" )

//Creates a function that will be ran when the hook at the bottom is called.
local function playerHurtSound( ent, dmginfo )

	//Create a variable that will hold the damage that was done, passed through the EntityTakeDamage hook.
	local damage = dmginfo:GetDamage()

	//Create a variable that will get the entities(players) health when hit.
	local health = ent:Health() - damage
	
	print(tostring(health))
	//Checked if the addonActivated variable above is true, if so also check if self:Health() (players health) is less then or equal to (<=) the health set in the
	//variable above to see if sound needs to be played.
	if addonActivated == true and health <= activationHealthPercent then

		print("This happened.")

		//The net library will send information from server-client or client-server
		//net.Start starts the message that is going to be sent, and we are simply sending an empty message that when received clientside will run the sound.
		net.Start( "soundCheck" )

		//net message is sent to ent, which is an argument passsed by the EntityTakeDamage hook to find the entitity that got hit, in this case the player.
		net.Send( ent )

	//Ends the if statement.
	end

//Ends the function.
end

//Creates the hook to do playerHurtSound() when the player takes damage.
hook.Add("EntityTakeDamage", "EntityTakeDamage",  playerHurtSound )