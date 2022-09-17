#! /usr/bin/python3

#word = ['r', 'a', 'i', 'n', 'b', 'o', 'w']
word = ['a','b','c','d']
orig = ['a','b','c','d']
count = 0
count_pass = 0

def checkWord(word):
	global count_pass
	vowel_found = 0
	condition_pass = 0
	# check if vowels are together
	for x in range(0, len(word)):
		if word[x]=='a' or word[x]=='i' or word[x]=='o':
			if not vowel_found:
				vowel_found = 1
			elif not condition_pass:
				condition_pass = 1
			else:
				condition_pass = 0
		else:
			vowel_found = 0
	# end by adding to count_pass
	print(word, condition_pass)
	if condition_pass:
		count_pass += 1
	return
		
def iter(word, idx):
	global count
	for x in range(idx, len(word)):
		word[idx], word[x] = word[x], word[idx]
		# Perform recursion
		if idx == len(word)-1:
			count += 1
			checkWord(word)
			#print(word, count)
		else:
			iter(word, idx+1)
		# Restore the array to pre recursion state
		word[idx], word[x] = word[x], word[idx]
	return

iter(word, 0)
print(count, count_pass)
