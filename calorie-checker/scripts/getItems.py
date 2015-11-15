import csv
import sys

def createFoodDcit(data_file, food_dict):	
	"""This function populates a dictionary with the 'name' values from input csv. 
	
	Usage: 
		f_dic = {}
		createFoodDcit('C:\\input.csv', f_dic)
	
	Args:
		data_file : absolute path of csv file containing data
		food_dict : dictionary to be populated
	
	Returns:
		NA 
	
	Note:
		Please verify the csv format.
	"""
	
	with open(data_file) as csvfile:
		reader = csv.DictReader(csvfile)
		for row in reader:
			food_dict[row['name'].lower()] = True



def extractFoodItems(input_list, food_dict):
	"""This function return a list of valid food items from a word list.
	One food item may be a sequence of multiple words.
	
	Usage: 
		food_list = extractFoodItems(['peanut', 'butter', 'jelly'], ['peanut', 'peanut butter', 'jelly'])
	
	Args:
		food_dict : dictionary containing all food items for validation
		input_list : the input word list - construct this by calling split() on raw input string.
	
	Returns:
		List of valid food items. 
	
	Note:
		If a food list cannot be constructed incorporating all the words in the list, this function returns None.
	"""
	
	word_count = len(input_list)
	if word_count == 0:
		return []
	for i in range(word_count,0,-1):
		if " ".join(input_list[:i+1]) in food_dict: #redo
			rest = extractFoodItems(input_list[i+1:], food_dict)
			if rest == None:
				continue
			else:
				return [" ".join(input_list[:i+1])] + rest

'''
def extractFoodItems(input_string, food_dict):
	input_list = input_string.split()
	word_count = len(input_list)
	word_matrix = [False for i in word_count]*word_count
	for i in range(word_count):
		for j in range(i, word_count):
			if " ".join(input_list[i:j+1]): 
				word_matrix[i][j] = True		
'''
	
	
	
def main():
	# food_dict = {}
	# data_file = "nutrition_data_clean_jm.csv"
	# createFoodDcit(data_file, food_dict)
	
	# #food_dict = {'peanut':True, 'butter':True, 'peanut butter':True, 'peanut butter jelly':True, 'butter jelly':True, 'jelly mixed':True, 'mixed':True}
	# input_string =  sys.argv[1]#'peanut butter jelly mixed'
	# response = extractFoodItems(input_string.lower().split(), food_dict)
	# food_items = " " if response == None else ",".join(response)
	print('cheese,butter')
	sys.stdout.flush()

if __name__ == '__main__':
	main()