	leftButton.Visible = true
	rightButton.Visible = true
	forwardButton.Visible = true
	backButton.Visible = true
	throwButton.Visible = true
	lockButton.Visible = true
	modeButton.Visible = true
end)

tool.Unequipped:Connect(function()
	upButton.Visible = false
	downButton.Visible = false
	leftButton.Visible = false
	rightButton.Visible = false
	forwardButton.Visible = false
	backButton.Visible = false
	throwButton.Visible = false
	lockButton.Visible = false
	modeButton.Visible = false

	if draggingLoop then draggingLoop:Disconnect() end
	directions = {Up = false, Down = false, Left = false, Right = false, Forward = false, Backward = false}

	clearHighlight() 
end)


LocalPlayer.CharacterAdded:Connect(function()
	selectedTarget = nil
	selectedTargets = {}
	isLocked = false
	if draggingLoop then draggingLoop:Disconnect() end
	clearHighlight()
	toolEquipped = false
end)
