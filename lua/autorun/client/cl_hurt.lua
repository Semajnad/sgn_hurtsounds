//Quick variable created here to be used in net.Receive.
local soundIsPlaying = false

//Receives the soundCheck networked message sent by the server.
net.Receive( "soundCheck", function()

	//Quick check to see if the sound has been played in the last second.
	if soundIsPlaying == false then

		//Play the sound built into Half Life 2. Players will need Half Life 2 installed to be able to hear this sound, otherwise they will just hear nothing.
		LocalPlayer():EmitSound( "vo/npc/male01/imhurt01.wav", 100, 100 )

		//To stop the sound repeating too often, we create a soundIsPlaying variable that is set to true once the sound plays...
		soundIsPlaying = true

		//...then after 1 second we set it back to false. This makes sure it doesn't happen less then once a second.
		timer.Simple( 1, function() soundIsPlaying = false end )

	//Ends the if statement.
	end

//Ends the net.Receive.
end )