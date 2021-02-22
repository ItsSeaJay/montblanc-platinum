extends Node

"""
Moves 'a' towards 'b' by 'amount' and returns the result
Nice because it will not overshoot 'b' and works with both positive and
negative targets
"""
func approach(a, b, amount):
	assert(amount > 0)
	
	if a < b:
		a += amount
		
		if a > b:
			return b
	else:
		a -= amount
		
		if a < b:
			return b
	
	return a
