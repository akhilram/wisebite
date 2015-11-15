import csv
import sys
import string
import re

complete_food_string = ""
transtable = {ord(c): " " for c in string.punctuation} # if c!= ','
stopwords = []

def buildStopWords(stopfile):
	"""This function builds a stopword list from a stopwords file given as input.
	   stopwords list is kept global.
	   stopwords file format: one stopword per line

	Usage:
		buildStopWords(filepath)

	Args:
		stopfile : full path of stopwords file

	Returns:
		NA
	"""

	global stopwords
	stopwords = [word.strip() for word in open(stopfile).readlines()]

def preprocess(input_string, doStopWords, doPunctuation):
	"""This function preprocess the input_string to remove punctuation and/or remove stopwords

	Usage:
		preprocess('this is a string', True, False)

	Args:
		input_string : absolute path of csv file containing data
		doStopWords : boolean to represent whether to remove stopwords
		doPunctuation : boolean to represent whether to remove punctuations

	Returns:
		preprocessed string
	"""

	new_str = input_string.lower()
	if doPunctuation:
		new_str = new_str.translate(transtable)
	if doStopWords:
		try:
			new_str = " ".join([word for word in new_str.split() if word not in stopwords])
		except ValueError as e:
			new_str = ""
	return new_str

def createFoodStringFile(data_file, output_file):
	"""This function creates a giant string of all food items listed in data_file.
		The food string is then written to output_file

	Usage:
		createFoodStringFile(data file name, output file name)

	Args:
		data_file : full path of csv file containing data
		output_file : name of output_file into which the food string is to be written

	Returns:
		NA

	Note:
		Please verify the csv format.
	"""

	food_list = []
	with open(data_file) as csvfile:
		reader = csv.DictReader(csvfile)
		for row in reader:
			preprocessed_foodname = preprocess(row['name'], True, True)
			food_list.append(preprocessed_foodname)

	food_str = ",".join(food_list)
	with open(output_file, 'w') as fout:
		fout.write(food_str)

def isValidFood(input_string):
	"""This function verifies whether the input string is a food item

	Usage:
		isfood = isValidFood('cereal', food_dict)

	Args:
		input_string : string to be validated to be a food item
		food_dict : dictionary containing all food items for validation

	Returns:
		Boolean representing if the string is valid food or not
	"""
	if  re.search(input_string, complete_food_string) != None:
		return True
	else:
		return False

def extractFoodItems(input_list):
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
	for i in range(word_count,-1,-1):
		if isValidFood(" ".join(input_list[:i+1])):
			rest = extractFoodItems(input_list[i+1:])
			if rest == None:
				continue
			else:
				return [" ".join(input_list[:i+1])] + rest

def mains(inp):
	global complete_food_string
	data_file = "./hello/nutrition_data_clean_jm.csv"
	food_str_file = "./hello/all_food.txt"
	stop_file = "./hello/stopwords.txt"

	buildStopWords(stop_file)
	try:
		complete_food_string = open(food_str_file, 'r').read()
		if complete_food_string.strip() == "":
			raise ValueError('food string empty')
	except (FileNotFoundError, ValueError) as e:
		createFoodStringFile(data_file, food_str_file)
		complete_food_string = open(food_str_file, 'r').read()

	input_string =  inp#sys.argv[1] #'peanut butter jelly mixed'
	processed_input = preprocess(input_string, True, True)
	response = extractFoodItems(processed_input.split())
	food_items = " " if response == None else ",".join(response)
	#print(food_items)
	#sys.stdout.flush()
	return food_items

# if __name__ == '__main__':
# 	main()
