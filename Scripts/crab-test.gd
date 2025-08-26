extends Node2D

var score = 5
var atk_dmg = 1.5
var game_over = false
var atk_type = "Pinch"

var country : String = "Canada"
var population_mil : float = 41.29
var highest_alt_meters : int = 5959
var landlocked : bool = false
var country_info = [country, population_mil, highest_alt_meters, landlocked]


# Runs when the game is first initialized
func _ready():
	for i in range(3):
		score +=5
		print(score)
		if score % 10 == 0:
			print("It's divisible by 10")
	
	for j in country_info:
		print(j)
	
	var money : float = 0.0  # Scope is limited to the function
	money += 5
	money *= 2
	money -= 3
	money /= 2
	print(money)
	
	if money >= 10:
		print("We have more than 10 dollary-doos!")
	elif money == atk_dmg:
		print("Our money is equal to our attack damage")
	else:
		print("We have {} dollary-doos!".format([money], "{}"))
		
	if game_over:
		print("Go to menu")
	else:
		print("Keep playing")
	
	match money:
		10:
			print("We have 10 dollars")
		_:  # _ = Anything, bascially. If _ matches anything money is. Think of it as match's 
			# version of else from the if/elif/else block
			print("We DON'T have 10 dollars")
			
	# We can write functions from the future here.
	_private_funct()  # Will be defined later
	print(public_funct())  # public_funct will also be defined later
	

# Called every frame:
func _process(_delta: float) -> void:  # void tells us that this function returns none, void.
	print("I'm a beautiful frame! Delta = {}".format([_delta], "{}"))
	# We can put functions from the future here as well
	_private_funct()


# We can make functions after _process, though
func _private_funct():  # For private functions, the convention is to put an _ befpre the first word
	print("Welcome to the game")
	

func public_funct() -> String:  # For public, the word comes before any underscore
	# 							  The -> String tells us that the function returns a String.
	# And returning is the same as in Python:
	var funct_type = "This is a public function"
	return funct_type
	# Or, 'return "This is a public function"'
	
# PRIVATE FUNCTIONS: Functions only called within their script
# PUBLIC FUNCTIONS: Funtions called outside of their original script
