import re
infile = open("DATA2.TXT", "r")
outfile = open("OUT2.TXT", "w")
line = infile.readline()
while line:
	match = re.match('^(\d+) (\d+)', line)
	if match:
		nls = int(match.group(1))
		ll = int(match.group(2))
		scardout = []
		for i in range(nls):
			scardout.append([])
			for r in range(ll):
					scardout[i].append('#')
		hc = 0
		lcard = []
		line = infile.readline()
		continue
	if hc <= nls:
		letters = list(line.rstrip())
		lcard.append(letters)
		hc += 1
	if hc > nls:
		phrase = list(line.rstrip())
		lcard.pop()
		ifbre = False
		found = True
		for l in range(len(phrase)):
			ifbre = False
			foundthis = False
			for r in range(ll):
				for i in range(nls):
					if lcard[i][r] == phrase[l]:
						scardout[i][r] = "."
						lcard[i][r] = "*"
						ifbre = True
						foundthis = True
					if ifbre == True:
						break
				if ifbre == True:
					break
			if not foundthis:
				found = False
		if found:
			for i in scardout:
				for r in i:
					outfile.write(r)
				outfile.write("\n")
		else:
			for i in scardout:
				for r in i:
					outfile.write("x")
				outfile.write("\n")
		hc = 0
	line = infile.readline()
outfile.close()