extends Node

# Declare all the variables.
export (Array) var gridSize
var enableTestLevel	
var m
var wallNum
var floorNum

var templateOne 		
					
var templateTwo 		
					
var templateThree  		
						
var templateFour 		
						
var templateFive 		
						
var templateSix 		
						
var templateSeven 		
						
var templateEight 		

var templateNine 		
						
var templateTen 		
						
var templateEleven 		
						
var templateTwelve 		
						
var templateThirteen	
							
var templateFourteen 	
						
						
var templateFifteen 	
							
var templateSixteen 	
							
var templateSeventeen 	
							
# Other variables.
							
var templateList 		
var baseMatrix 						
var startingPlacementCoords 		
var levelMatrix 					
var trueLevelMatrix
var quitGame 						
var tilesCoveredFourWayTopLeft 		
var tilesCoveredEightWayTopLeft		
var tilesCoveredFourWayBottomRight	
var tilesCoveredEightWayBottomRight	
var finalLevelMatrix
var timesUp 
var floodLevelMatrix

# This is for when we generate a bad level.
func badEgg():
	if global.debug == true:
		print("Generating a new level.")
	get_tree().change_scene(get_tree().current_scene.filename)
	return

# http://ianparberry.com/techreports/LARC-2011-01.pdf (Kinda funny how the guy with a CS Masters/Doctorate can't even set up basic security certificate.)
# Here we initalise stuff.
func initialisation():
	# Initalise all the global variables
	gridSize = [2,3]
	enableTestLevel 		= false
#	debug 					= false

	templateOne 		=   	[[1,1,1],
								[1,1,1],
								[1,1,1]]
						
	templateTwo 		=   	[[2,1,1],
								[1,1,1],
								[1,1,1]]
						
	templateThree  		=   	[[2,2,1],
								[1,1,1],
								[1,1,1]]
							
	templateFour 		=   	[[2,2,2],
								[1,1,1],
								[1,1,1]]
							
	templateFive 		=   	[[2,2,2],
								[2,1,1],
								[2,1,1]]
							
	templateSix 		=   	[[2,1,1],
								[1,1,1],
								[1,1,2]]
							
	templateSeven 		=   	[[2,1,1],
								[1,1,1],
								[2,1,1]]
							
	templateEight 		=   	[[2,1,1],
								[1,1,1],
								[2,1,2]]

	templateNine 		=   	[[2,1,2],
								[1,1,1],
								[2,1,2]]
							
	templateTen 		=   	[[2,1,2],
								[2,3,1],
								[2,2,2]]
							
	templateEleven 		=   	[[2,2,2],
								[1,1,1],
								[2,2,2]]
							
	templateTwelve 		=   	[[1,1,1],
								[1,2,1],
								[1,1,1]]
							
	templateThirteen	=		[[2,2,2],
								[2,2,2],
								[2,2,2]]
								
	templateFourteen 	=		[[2,2,2],
								[2,1,1],
								[1,1,1]]
							
							
	templateFifteen 	= 		[[1,1,1],
								[2,1,2],
								[1,1,1]]
								
	templateSixteen 	= 		[[2,2,2],
								[2,2,2],
								[1,1,1]]
								
	templateSeventeen 	=		[[2,2,2],
								[1,2,1],
								[1,1,1]]
								
	# Other variables.
								
	templateList 					= [templateOne, templateTwo, templateThree, templateFour, templateFive, templateSix, templateSeven, templateEight, templateNine, templateTen, templateEleven, templateTwelve, 
									  templateThirteen, templateFourteen, templateFifteen, templateSixteen, templateSeventeen]
	baseMatrix 						= []
	startingPlacementCoords 		= [[3,0],[3,3],[6,0],[6,3],[9,0],[9,3]]
	levelMatrix 					= []
	finalLevelMatrix 				= []
	quitGame 						= false
	tilesCoveredFourWayTopLeft 		= 0
	tilesCoveredEightWayTopLeft		= 0
	tilesCoveredFourWayBottomRight	= 0
	tilesCoveredEightWayBottomRight	= 0
	timesUp 						= false
	# Initalise the level matrix.
	for y in range(gridSize[1] * 3):
		baseMatrix.append([])
		baseMatrix[y] = []
		for x in range(gridSize[0] * 3):
			baseMatrix[y].append([])
			baseMatrix[y][x] = 0
	# Debugging stuff
	if global.debug == true:
		for x in range(baseMatrix.size()):
			print(baseMatrix[x])
		for x in range(startingPlacementCoords.size()):
			print(startingPlacementCoords[x])
		for x in range(templateList.size()):
			print(templateList[x])
	else:
		pass


# Just a test level.
#func contiguousFloorTestLevel():
#	var layerOne 	= [2,2,1,1,1,1]
#	var layerTwo 	= [1,1,2,1,1,1]
#	var layerThree 	= [1,1,2,1,1,1]
#	var layerFour 	= [2,2,1,1,1,1]
#	var layerFive 	= [1,1,1,1,1,1]
#	var layerSix 	= [1,1,1,1,1,1]
#	var layerSeven 	= [1,1,1,1,2,2]
#	var layerEight 	= [1,1,1,1,1,1]
#	var layerNine 	= [1,1,1,2,1,1]
#	levelMatrix = [layerOne, layerTwo, layerThree, layerFour, layerFive, layerSix, layerSeven, layerEight, layerNine]
#	pass

func generationStageOne():
	if global.debug == true:
		print("----------")
		print("STAGE ONE|")
		print("----------")
		print("Generating level matrix from templates.")
	# Pick the six templates.
	#templateList.shuffle()
	var chosenTemplateOne = templateList[randi() % templateList.size()]
	#templateList.shuffle()
	var chosenTemplateTwo = templateList[randi() % templateList.size()]
	#templateList.shuffle()
	var chosenTemplateThree = templateList[randi() % templateList.size()]
	#templateList.shuffle()
	var chosenTemplateFour = templateList[randi() % templateList.size()]
	#templateList.shuffle()
	var chosenTemplateFive = templateList[randi() % templateList.size()]
	#templateList.shuffle()
	var chosenTemplateSix = templateList[randi() % templateList.size()]
	# Create the new level matrix.
	var layerOne 	= [chosenTemplateOne[0][0], chosenTemplateOne[0][1], chosenTemplateOne[0][2], 
					   chosenTemplateTwo[0][0], chosenTemplateTwo[0][1], chosenTemplateTwo[0][2]]
	var layerTwo 	= [chosenTemplateOne[1][0], chosenTemplateOne[1][1], chosenTemplateOne[1][2],
					   chosenTemplateTwo[1][0], chosenTemplateTwo[1][1], chosenTemplateTwo[1][2]]
	var layerThree 	= [chosenTemplateOne[2][0], chosenTemplateOne[2][1], chosenTemplateOne[2][2],
					   chosenTemplateTwo[2][0], chosenTemplateTwo[2][1], chosenTemplateTwo[2][2]]
	var layerFour	= [chosenTemplateThree[0][0], chosenTemplateThree[0][1], chosenTemplateThree[0][2],
					   chosenTemplateFour[0][0], chosenTemplateFour[0][1], chosenTemplateFour[0][2]]
	var layerFive 	= [chosenTemplateThree[1][0], chosenTemplateThree[1][1], chosenTemplateThree[1][2],
					   chosenTemplateFour[1][0], chosenTemplateFour[1][1], chosenTemplateFour[1][2]]
	var layerSix	= [chosenTemplateThree[2][0], chosenTemplateThree[2][1], chosenTemplateThree[2][2],
					   chosenTemplateFour[2][0], chosenTemplateFour[2][1], chosenTemplateFour[2][2]]
	var layerSeven	= [chosenTemplateFive[0][0], chosenTemplateFive[0][1], chosenTemplateFive[0][2],
					   chosenTemplateSix[0][0], chosenTemplateSix[0][1], chosenTemplateSix[0][2]]
	var layerEight	= [chosenTemplateFive[1][0], chosenTemplateFive[1][1], chosenTemplateFive[1][2],
					   chosenTemplateSix[1][0], chosenTemplateSix[1][1], chosenTemplateSix[1][2]]
	var layerNine	= [chosenTemplateFive[2][0], chosenTemplateFive[2][1], chosenTemplateFive[2][2],
					   chosenTemplateSix[2][0], chosenTemplateSix[2][2], chosenTemplateSix[2][2]]
	levelMatrix = [layerOne, layerTwo, layerThree, layerFour, layerFive, layerSix, layerSeven, layerEight,
						  layerNine]
	levelMatrix[3][2] = 1
	levelMatrix[3][3] = 1
	levelMatrix[4][2] = 1
	levelMatrix[4][3] = 1
	# Debugging stuff.
	if global.debug == true:
		for x in range(levelMatrix.size()):
			print(levelMatrix[x])			
		print("Level matrix generated.")
	
# Gets the first tile starting from the top left that is floor.
func getTopLeftStartTile():
	var x
	for subArray in range(levelMatrix.size()):
		for element in range(levelMatrix[subArray].size()):
			if levelMatrix[subArray][element] == 1:
				x = [subArray, element]
				return x

# Gets the first tile starting from the bottom right that is floor.
func getBottomRightStartTile():
	var x
	for subArray in range(levelMatrix.size()-1, -1, -1):
		for element in range(levelMatrix[subArray].size()-1, -1, -1):
			if levelMatrix[subArray][element] == 1:
				x = [subArray, element]
				return x
	
# Check if there is a contiguous floor i.e 	you can access all of the floor with no walls blocking,
# if there isn't, scrap the level and remake it until you do.
func generationStageTwo():
	if global.debug == true:
		print("----------")
		print("STAGE TWO|")
		print("----------")
	# Get the starting tile
	var startTile = getTopLeftStartTile()
						
	if global.debug == true:
		print("The top left starting position is ", startTile)
				
	# Check if there are any full line walls.
	
	# Do the flood fill search from both opposite corners of the level.
	floodFillTestFourWay(startTile[0], startTile[1], 1, true)
	if global.debug == true:
		print("The amount of tiles covered by the flood filler in four directions, with the starting position from the top left was: ", tilesCoveredFourWayTopLeft)
	placesVisited.clear()
	floodFillTestEightWay(startTile[0], startTile[1], 1, true)
	if global.debug == true:
		print("The amount of tiles covered by the flood filler in eight direction, with the starting position from the top left was: ", tilesCoveredEightWayTopLeft)
	placesVisited.clear()
					
	startTile = getBottomRightStartTile()
					
	if global.debug == true:
		print("The bottom right starting position is ", startTile)
	
	floodFillTestFourWay(startTile[0], startTile[1], 1, false)
	if global.debug == true:
		print("The amount of tiles covered by the flood filler in four directions, with the starting position from the bottom right was: ", tilesCoveredFourWayBottomRight)
	placesVisited.clear()
	floodFillTestEightWay(startTile[0], startTile[1], 1, false)
	if global.debug == true:
		print("The amount of tiles covered by the flood filler in eight direction, with the starting position from the bottom right was: ", tilesCoveredEightWayBottomRight)
	
	# Evaluate the level and then print it out for debugging purposes.
	floodFillTestEvaluate()
	#return

var placesVisited = []

# https://www.geeksforgeeks.org/flood-fill-algorithm-implement-fill-paint/
func floodFillTestFourWay(var subArray, var element, var targetNumber, var counter):
	var trueLevelMatrix = levelMatrix.duplicate(true)
	if (element < 0 or element >= trueLevelMatrix[0].size() or subArray < 0 or subArray >= trueLevelMatrix.size() or trueLevelMatrix[subArray][element] != targetNumber):
		return
	elif placesVisited.has([subArray, element]):
		return
	else:
		if counter == true:
			tilesCoveredFourWayTopLeft += 1
		else:
			tilesCoveredFourWayBottomRight += 1


		placesVisited.append([subArray, element])
		
		# North, East, South, West
		floodFillTestFourWay(subArray - 1, element, targetNumber, counter)
		floodFillTestFourWay(subArray, element + 1, targetNumber, counter)
		floodFillTestFourWay(subArray + 1, element, targetNumber, counter)
		floodFillTestFourWay(subArray, element - 1, targetNumber, counter)

# https://www.geeksforgeeks.org/flood-fill-algorithm-implement-fill-paint/
func floodFillTestEightWay(var subArray, var element, var targetNumber, var counter):
	var trueLevelMatrix = levelMatrix.duplicate(true)
	if (element < 0 or element >= trueLevelMatrix[0].size() or subArray < 0 or subArray >= trueLevelMatrix.size() or trueLevelMatrix[subArray][element] != targetNumber or trueLevelMatrix[subArray][element] != 3):
		return
	elif placesVisited.has([subArray, element]):
		return
	else:
		if counter == true:
			tilesCoveredEightWayTopLeft += 1
		else:
			tilesCoveredEightWayBottomRight += 1
		placesVisited.append([subArray, element])
		
		#North, North-east, East, South-east, South, South-west, West, North-west.
		floodFillTestEightWay(subArray - 1, element, targetNumber, counter)
		floodFillTestEightWay(subArray - 1, element + 1, targetNumber, counter)
		floodFillTestEightWay(subArray, element + 1, targetNumber, counter)
		floodFillTestEightWay(subArray + 1, element + 1, targetNumber, counter)
		floodFillTestEightWay(subArray + 1, element, targetNumber, counter)
		floodFillTestEightWay(subArray + 1, element - 1, targetNumber, counter)
		floodFillTestEightWay(subArray, element - 1, targetNumber, counter)
		floodFillTestEightWay(subArray - 1, element - 1, targetNumber, counter)


# Checks if the level passed any of the red flags, if it did, try again.
func floodFillTestEvaluate():
	if global.debug == true:
		for x in range(levelMatrix.size()):
			print(levelMatrix[x])
	
	for subArray in range(levelMatrix.size()):
		if levelMatrix[subArray] == [2,2,2,2,2,2]:
			if global.debug == true:
				print("This level is bad.")
				print("long wall")
			badEgg()
			return

	if tilesCoveredEightWayTopLeft > tilesCoveredFourWayTopLeft or tilesCoveredFourWayBottomRight != tilesCoveredFourWayTopLeft or tilesCoveredEightWayBottomRight != tilesCoveredEightWayTopLeft:
		if global.debug == true:
			print("This level is bad.")
			print("bad tile cover")
		badEgg()
		return
	else:
		if global.debug == true:
			print("This level is good.")
		generationStageThree()
		return

# Checks if the level is solvable, and if it is, designates the areas where the player and box(es) will be placed.
func generationStageThree():
	if global.debug == true:
		print("------------")
		print("STAGE THREE|")
		print("------------")
	# Declare variables and objects.
	finalLevelMatrix = levelMatrix.duplicate(true)
	var potentialBoxPositionsCollection 	= []
	var potentialGoalPositionsCollection	= []
	var boxDistanceCollection				= []
	var goalDistanceCollection				= []
	var goalDistancePositions 				= []
	var levelCollection						= []
	
	# Change the elements in the finalLevelMatrix to fit the algoirithim to be used.
	for subArray in range(finalLevelMatrix.size()):
		for element in range(finalLevelMatrix[subArray].size()):
			if finalLevelMatrix[subArray][element] == 1 or finalLevelMatrix[subArray][element] == 3:
				finalLevelMatrix[subArray][element] = 0
			elif finalLevelMatrix[subArray][element] == 2:
				finalLevelMatrix[subArray][element] = 'x'
	
	if global.debug == true:
		print("levelMatrix for box placement:")
		for subArray in range(finalLevelMatrix.size()):
			print(finalLevelMatrix[subArray])
		
	if global.debug == true:
		print("------------")
			
	# Set up the timer.
	var time = 1

	# Brute force the placement of the boxes until the timer is up, and then pick the one with the longest distance between the two boxes.
	while time > 0:
		randomize()
		time -= 1
#		print(time)
		var TwoTwo 	= []
		var Two 	= []
		var PooPoo	= []
		var Poo		= []
		for x in range(2):
			Two.append(randi()%((gridSize[0]*3)-1)+1)
			Two.append(randi()%((gridSize[1]*3)-1)+1)
			Poo.append(randi()%((gridSize[0]*3)-1)+1)
			Poo.append(randi()%((gridSize[1]*3)-1)+1)
			TwoTwo.append(Two)
			PooPoo.append(Poo)
			Two = []
			Poo	= []

		var tempLevelMatrix = finalLevelMatrix.duplicate(true)
		var joeNuts = 0
		for x in range(2):
			var tempX 	= TwoTwo[joeNuts][0]
			var tempY 	= TwoTwo[joeNuts][1]
			tempLevelMatrix[tempY][tempX] 	= 'b'
			tempX		= PooPoo[joeNuts][0]
			tempY		= PooPoo[joeNuts][1]
			tempLevelMatrix[tempY][tempX]	= 'g'
			joeNuts += 1

		if potentialBoxPositionsCollection.has(TwoTwo) or potentialBoxPositionsCollection.has(PooPoo):
			pass
		else:
			potentialBoxPositionsCollection.append(TwoTwo)
			potentialGoalPositionsCollection.append(PooPoo)
			if global.debug == true:
				print(potentialBoxPositionsCollection[-1])
				print("levelMatrix after boxes and goals have been placed.")
				for subArray in range(tempLevelMatrix.size()):
					print(tempLevelMatrix[subArray])
			levelCollection.append(tempLevelMatrix)
	
	if global.debug == true:
		print("Time is up!")
		print("We have ", potentialBoxPositionsCollection.size(), " potential box positions and ", potentialGoalPositionsCollection.size(), " potential goal positions.")
		print("We will now find the level with the longest distance between it's boxes.")
	for x in range(potentialGoalPositionsCollection.size()):
		floodLevelMatrix = []
		placesVisited = []
		floodFillDistance(potentialGoalPositionsCollection[x][0][0], potentialGoalPositionsCollection[x][0][1], 0, 0, finalLevelMatrix)
		var joeMama = floodLevelMatrix.duplicate(true)
		if goalDistanceCollection.has(joeMama):
			pass
		elif joeMama != []:
			goalDistanceCollection.append(joeMama)
			goalDistancePositions.append([potentialGoalPositionsCollection[x][0][0], potentialGoalPositionsCollection[x][0][1]])
			
	if global.debug == true:
		print("We have ", goalDistanceCollection.size(), " level variations for elimination!")
		print("We will now choose the best one.")
	var john = goalDistanceCollection.size()
	var bestLevel = 0
			
	if global.debug == true:
		print("The best level variation is number ", bestLevel, "!")
	finalLevelMatrix = levelCollection[bestLevel].duplicate(true)
	
	if global.debug == true:
		print("Determining the position of the player...")
	var foundGoodOne = false
	var playerSA
	var playerE
	
	while foundGoodOne == false:
		var potentialPlayerY = randi() % levelMatrix.size()
		var potentialPlayerX = randi() % levelMatrix[0].size()
		
		if typeof(finalLevelMatrix[potentialPlayerY][potentialPlayerX]) != TYPE_STRING:
			playerSA 	= potentialPlayerY
			playerE 	= potentialPlayerX
			foundGoodOne = true
			
	finalLevelMatrix[playerSA][playerE] = 'p'
	
	if global.debug == true:
		print("The final level is:")
		for subArray in range(finalLevelMatrix.size()):
			print(finalLevelMatrix[subArray])
	
	generationStageFour(finalLevelMatrix)
	return




func floodFillDistance(var subArray, var element, var targetNumber, var counter, var levelMatrix):
	if (element < 0 or element >= levelMatrix[0].size() or subArray < 0 or subArray >= levelMatrix.size() or typeof(finalLevelMatrix[subArray][element]) != TYPE_INT):
		return
	elif placesVisited.has([subArray, element]):
		floodLevelMatrix = levelMatrix
	else:
		counter += 1
		placesVisited.append([subArray, element])
		levelMatrix[subArray][element] = counter
		
		# North, East, South, West
		floodFillDistance(subArray - 1, element, targetNumber, counter, levelMatrix)
		floodFillDistance(subArray, element + 1, targetNumber, counter, levelMatrix)
		floodFillDistance(subArray + 1, element, targetNumber, counter, levelMatrix)
		floodFillDistance(subArray, element - 1, targetNumber, counter, levelMatrix)

#
# A* FUNCTIONS
#

# G(n) = √(N(x)² + N(y)²)
# Here, N(x) and N(y) are represented by the first and second elements of the n array, n being the current node's position.
func g(n):
	return(sqrt(pow(n[1], 2) + pow(n[0], 2)))
	pass

# H(n, t) = (T(x) - N(x)) + (T(y) - N(y))
# Here, T represents the target node array, that being the goal's position. 
func h(n, t):
	return((t[1] - n[1]) + (t[0] - n[0]))

# F(n, t) = G(n) + H(n, t)
func f(n, t):
	return(sqrt(pow(n[1],2) + pow(n[0], 2)) + (t[1] - n[1]) + (t[0] - n[0]))

func findSmallest(array):
	var minVal = 2000000
	var kaboom = 0
	
	for i in range(array.size()):
		if array[i][0] == 0:
			kaboom = [array[i][1], array[i][0]]
			return kaboom
			break
		if array[i][0] < 0:
			if i == 0:
				minVal = -999999
			if minVal < array[i][0]:
				minVal = array[i][0]
		else:
			if minVal > array[i][0]:
				minVal = array[i][0]
	
	for i in range(array.size()):
		if minVal == array[i][0]:
			if global.debug == true:
				print("kaboom should be ", array[i][1])
			kaboom = [array[i][1], array[i][0]]
	

	if global.debug == true:
		print ("kaboom is ", kaboom)
	return kaboom

# See if the level is solveable. We do this by the following the paper linked below.
# http://publikasi.dinus.ac.id/index.php/jais/article/download/3409/1851
func generationStageFour(bruhLevelMatrix):
	# Declare variables.
	var goals = []
	var boxes = []
	var player
	var gotBox = false
	var finished = 0
	var good = false
	var otherBox
	var target
	var boxNode
	var playerNode
	var northNode
	var southNode
	var eastNode
	var westNode
	var placesVisited = []
	var fValuesCollection = []
	var new = true
	
	# Define variables.
	for subArray in bruhLevelMatrix.size():
		for element in bruhLevelMatrix[subArray].size():
			if typeof(bruhLevelMatrix[subArray][element]) == TYPE_STRING:
				if bruhLevelMatrix[subArray][element] == 'p':
					player = [subArray, element]
				elif bruhLevelMatrix[subArray][element] == 'b':
					boxes.append([subArray, element, "pushable"])
				elif bruhLevelMatrix[subArray][element] == 'g':
					goals.append([subArray, element, "unsolved"])
				
	# Debugging stuff.
	if boxes.size() != 2:
		if global.debug == true:
			print("not enough boxes")
		badEgg()
		return
	if goals.size() != 2:
		if global.debug == true:
			print("not enough goals")
		badEgg()
		return
	
	if global.debug == true:
		print("The player is located at ", player)
		print("The boxes are located at")
		for x in range(boxes.size()):
			print(boxes[x])
		print("And the goals are located at")
		for x in range(goals.size()):
			print(goals[x])
		
	playerNode = player.duplicate(true)
		
	# Now we do the meat of the process, the process being:
	# 1. Get the player to a box.
	# 2. Push the box to the goal.
	# 3. Define the box as 'in-goal' and thus shouldn't be pursued anymore.
	# We do this until either all the boxes are in the goals and thus the level is solveable, or the box can no longer be pushed and thus the level is insolveable.
	
	while good != true:
		if finished == 2:
			good = true
		if gotBox == false:
			finished = 0
			if new == true:
				placesVisited = []
				new = false
			else:
				pass
			for item in range(boxes.size()):
				if boxes[item][2] != 'in-goal':
					target = boxes[item]
					if boxes[item - 1] != null and item - 1 >= 0:
						if boxes[item - 1][2] != 'in-goal':
							otherBox = [boxes[item - 1][0], boxes[item - 1][1]]
					if item + 1 <= 1:
						if boxes[item + 1][2] != 'in-goal':
							otherBox = [boxes[item + 1][0], boxes[item + 1][1]]
					boxNode = boxes[item]
					if global.debug == true:
						print("we are targeting the box at ", boxes[item])
						print("-----------------------------------------")
					break
				else:
					finished += 1
					
			if [playerNode[0],playerNode[1]] == [target[0],target[1]]:
				gotBox = true
				if global.debug == true:
					print("We have the box.")
					print("-----------------------------------------")
				new = true
			else:
				fValuesCollection.clear()
				northNode = null
				southNode = null
				eastNode = null
				westNode = null
				if global.debug == true:
					print(placesVisited)
				if (playerNode[0] - 1) >= 0 and not placesVisited.has([playerNode[0] - 1, playerNode[1]]):
					if levelMatrix[playerNode[0] - 1][playerNode[1]] != 2:
							northNode = [playerNode[0] - 1, playerNode[1]]
							var fValue
							if northNode == [target[0],target[1]] or northNode == [target[0] + 1, target[1]] or northNode == [target[0] - 1, target[1]] or northNode == [target[0], target[1] + 1] or northNode == [target[0], target[1] - 1]:
								fValue = [0, "north"]
							else: 
								fValue = [f(northNode, target), "north"]
							fValuesCollection.append(fValue)
				if (playerNode[0] + 1) <= levelMatrix.size() - 1 and not placesVisited.has([playerNode[0] + 1, playerNode[1]]):
					if levelMatrix[playerNode[0] + 1][playerNode[1]] != 2:
							southNode = [playerNode[0] + 1, playerNode[1]]
							var fValue
							if southNode == [target[0],target[1]] or southNode == [target[0] + 1, target[1]] or southNode == [target[0] - 1, target[1]] or southNode == [target[0], target[1] + 1] or southNode == [target[0], target[1] - 1]:
								fValue = [0, "south"]
							else: 
								fValue = [f(southNode, target), "south"]
							fValuesCollection.append(fValue)
				if (playerNode[1] + 1) <= levelMatrix[0].size() - 1 and not placesVisited.has([playerNode[0], playerNode[1] + 1]):
					if levelMatrix[playerNode[0]][playerNode[1] + 1] != 2:
							eastNode = [playerNode[0], playerNode[1] + 1]
							var fValue
							if eastNode == [target[0],target[1]] or eastNode == [target[0] + 1, target[1]] or eastNode == [target[0] - 1, target[1]] or eastNode == [target[0], target[1] + 1] or eastNode == [target[0], target[1] - 1]:
								fValue = [0, "east"]
							else: 
								fValue = [f(eastNode, target), "east"]
							fValuesCollection.append(fValue)
				if (playerNode[1] - 1) >= 0 and not placesVisited.has([playerNode[0], playerNode[1] - 1]):
					if levelMatrix[playerNode[0]][playerNode[1] - 1] != 2:
							westNode = [playerNode[0], playerNode[1] - 1]
							var fValue
							if westNode == [target[0],target[1]] or westNode == [target[0] + 1, target[1]] or westNode == [target[0] - 1, target[1]] or westNode == [target[0], target[1] + 1] or westNode == [target[0], target[1] - 1]:
								fValue = [0, "west"]
							else: 
								fValue = [f(westNode, target), "west"]
							fValuesCollection.append(fValue)
				if northNode == null and southNode == null and eastNode == null and westNode == null:
					good = false
					levelEvaluate(good, levelMatrix)
					return
					break
					
				var bruh = findSmallest(fValuesCollection)
				
				if northNode != null and (bruh[0] == "north"):
					if global.debug == true:
						print("The north node at ", [northNode[0], northNode[1]], " has the lowest fValue, it being ", bruh[1], " while moving to the box.")
						print("-----------------------------------------")
					placesVisited.append(northNode)
					playerNode = [northNode[0], northNode[1]]
				if southNode != null and (bruh[0] == "south"):
					if global.debug == true:
						print("The south node at", [southNode[0], southNode[1]], " has the lowest fValue, it being ", bruh[1], " while moving to the box.")
						print("-----------------------------------------")
					placesVisited.append(southNode)
					playerNode = [southNode[0], southNode[1]]
				if eastNode != null and (bruh[0] == "east"):
					if global.debug == true:
						print("The east node at ", [eastNode[0], eastNode[1]], " has the lowest fValue, it being ", bruh[1], " while moving to the box.")
						print("-----------------------------------------")
					placesVisited.append(eastNode)
					playerNode = [eastNode[0], eastNode[1]]
				if westNode != null and (bruh[0] == "west"):
					if global.debug == true:
						print("The west node at ", [westNode[0], westNode[1]], " has the lowest fValue, it being ", bruh[1], " while moving to the box.")
						print("-----------------------------------------")
					placesVisited.append(westNode)
					playerNode = [westNode[0], westNode[1]]
				else: 
					pass
		else:
			if new == true:
				placesVisited = []
				new = false
				for item in range(goals.size()):
					if goals[item][2] != 'solved':
						target = goals[item]
						if global.debug == true:
							print("we are targetting the goal at ", target)
						break
			else:
				pass
			if [playerNode[0],playerNode[1]] == [target[0],target[1]]:
				target[2] = 'solved'
				if global.debug == true:
					print("box is in goal")
				if finished == 2:
					levelEvaluate(true, levelMatrix)
					return
				else:
					pass
				boxNode[2] = "in-goal"
				boxNode = []
				gotBox = false
				new = true
			else:
				fValuesCollection.clear()
				northNode = null
				southNode = null
				eastNode = null
				westNode = null
				if global.debug == true:
					print(placesVisited)
				if (playerNode[0] - 1) >= 0 and not placesVisited.has([playerNode[0] - 1, playerNode[1]]):
						if levelMatrix[playerNode[0] - 1][playerNode[1]] != 2:
							if (playerNode[0] + 1) <= levelMatrix.size() - 1:
									if levelMatrix[playerNode[0] + 1][playerNode[1]] != 2:
										if playerNode != otherBox:
											northNode = [playerNode[0] - 1, playerNode[1]]
											var fValue
											if northNode == [target[0],target[1]] or northNode == [target[0] + 1, target[1]] or northNode == [target[0] - 1, target[1]] or northNode == [target[0], target[1] + 1] or northNode == [target[0], target[1] - 1]:
												fValue = [0, "north"]
											else: 
												fValue = [f(northNode, target), "north"]
											fValuesCollection.append(fValue)
				if (playerNode[0] + 1) <= levelMatrix.size() - 1 and not placesVisited.has([playerNode[0] + 1, playerNode[1]]):
						if levelMatrix[playerNode[0] + 1][playerNode[1]] != 2:
							if (playerNode[0] - 1) >= 0:
									if levelMatrix[playerNode[0] - 1][playerNode[1]] != 2:
										southNode = [playerNode[0] + 1, playerNode[1]]
										var fValue
										if southNode == [target[0],target[1]] or southNode == [target[0] + 1, target[1]] or southNode == [target[0] - 1, target[1]] or southNode == [target[0], target[1] + 1] or southNode == [target[0], target[1] - 1]:
											fValue = [0, "south"]
										else: 
											fValue = [f(southNode, target), "south"]
										fValuesCollection.append(fValue)
				if (playerNode[1] + 1) <= levelMatrix[0].size() - 1 and not placesVisited.has([playerNode[0], playerNode[1] + 1]):
						if levelMatrix[playerNode[0]][playerNode[1] + 1] != 2:
							if (playerNode[1] - 1) >= 0:
									if levelMatrix[playerNode[0]][playerNode[1] - 1] != 2:
										eastNode = [playerNode[0], playerNode[1] + 1]
										var fValue
										if eastNode == [target[0],target[1]] or eastNode == [target[0] + 1, target[1]] or eastNode == [target[0] - 1, target[1]] or eastNode == [target[0], target[1] + 1] or eastNode == [target[0], target[1] - 1]:
											fValue = [0, "east"]
										else: 
											fValue = [f(eastNode, target), "east"]
										fValuesCollection.append(fValue)
				if (playerNode[1] - 1) >= 0 and not placesVisited.has([playerNode[0], playerNode[1] - 1]):
						if levelMatrix[playerNode[0]][playerNode[1] - 1] != 2:
							if (playerNode[1] + 1) <= levelMatrix[0].size() - 1:
									if levelMatrix[playerNode[0]][playerNode[1] + 1] != 2:
										westNode = [playerNode[0], playerNode[1] - 1]
										var fValue
										if westNode == [target[0],target[1]] or westNode == [target[0] + 1, target[1]] or westNode == [target[0] - 1, target[1]] or westNode == [target[0], target[1] + 1] or westNode == [target[0], target[1] - 1]:
											fValue = [0, "west"]
										else: 
											fValue = [f(westNode, target), "west"]
										fValuesCollection.append(fValue)
				else:
					pass
				if northNode == null and southNode == null and eastNode == null and westNode == null:
					good = false
					levelEvaluate(good, levelMatrix)
					return
					break
					
			
				var bruh = findSmallest(fValuesCollection)
				if northNode != null and (bruh[0] == "north"):
					if global.debug == true:
						print("The north node at ", [northNode[0], northNode[1]], " has the lowest fValue, it being ", bruh[1], " while moving to the goal.")
						print("-----------------------------------------")
					placesVisited.append(northNode)
					playerNode = [northNode[0], northNode[1]]
				if southNode != null and (bruh[0] == "south"):
					if global.debug == true:
						print("The south node at", [southNode[0], southNode[1]], " has the lowest fValue, it being ", bruh[1], " while moving to the goal.")
						print("-----------------------------------------")
					placesVisited.append(southNode)
					playerNode = [southNode[0], southNode[1]]
				if eastNode != null and (bruh[0] == "east"):
					if global.debug == true:
						print("The east node at ", [eastNode[0], eastNode[1]], " has the lowest fValue, it being ", bruh[1], " while moving to the goal.")
						print("-----------------------------------------")
					placesVisited.append(eastNode)
					playerNode = [eastNode[0], eastNode[1]]
				if westNode != null and (bruh[0] == "west"):
					if global.debug == true:
						print("The west node at ", [westNode[0], westNode[1]], " has the lowest fValue, it being ", bruh[1], " while moving to the goal.")
						print("-----------------------------------------")
					placesVisited.append(westNode)
					playerNode = [westNode[0], westNode[1]]
				else: 
					pass	
				if global.debug == true:
					print(fValuesCollection)
		
	levelEvaluate(good, levelMatrix)
	return
	
	pass

func levelEvaluate(rating, level):
	if rating == false:
		if global.debug == true:
			print("fuck")
			print("bad evaluate")
		badEgg()
		return
	else:
		if global.debug == true:
			print("The level is solvable")
		for subArray in range(finalLevelMatrix.size()):
			print(finalLevelMatrix[subArray])
		#generationStageFive(finalLevelMatrix, false)
		return

# Run everything.
func main():
	global.positions = []
	global.dropZones = []
	global.boxPositions = []
	global.boxesInGoals = 0
	if global.debug == true:
		print("Setting things up...")
	randomize()
	if enableTestLevel == true:
		pass
	else:
		initialisation()
	if enableTestLevel == true:
		contiguousFloorTestLevel()
	else:
		generationStageOne()
	generationStageTwo()
	return

func _ready():
	main()