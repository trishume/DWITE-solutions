# the NINJAX team's contest template
# Adapted from PropagandaPanda's python contest template

# CONFIG ===========

QUESTION = 5

# BS answer to spout on exception
BS_ANSWER = "1"

# UTILS =============

import sys

infile = "DATA%s.txt"%QUESTION
curline = 0

if len(sys.argv) > 1:
    if sys.argv[1] == "-d":
        DEBUG = True
    else:
        infile = sys.argv[1]


DEBUG = len(sys.argv) > 1 and (sys.argv[1] == "-d")

def Debug(str):
    if DEBUG:
        print "DEBUG: ", str

def ReadFile():
    global curline
    for Line in open(infile,"r"):
            curline += 1
            for Part in Line.split():
                yield Part

def ReadConsole():
    try:
        while True:
            Line = raw_input()
            for Part in Line.split():
                yield Part.strip()
    except EOFError:
        print "Error: No console input"

Next = None
if DEBUG:
    Next = ReadConsole().next
else:
    open("OUT%s.txt"%QUESTION,"w").close()
    Next = ReadFile().next

def NextInt():
    return int(Next())

def WriteLine(Line):
    if DEBUG:
        print "OUT: ", Line
    else:
        f = open("OUT%s.txt"%QUESTION,"a")
        f.write(str(Line) + "\n")
        f.close()

#=============

def solveCase(case_num):
    global curline
    Debug("Solving case " + str(case_num))
    #solving code =======
    sets = []
    selfset = set()

    num = NextInt()
    for II in xrange(num):
        instr = Next()
        city1, city2 = Next(), Next()
        Debug("INSTR: {} {} {}".format(instr,city1,city2))

        cs1, cs2 = None, None
        csi1, csi2 = 0,0
        for ind,s in enumerate(sets):
            if city1 in s:
                cs1 = s
                csi1 = ind
            if city2 in s:
                cs2 = s
                csi2 = ind
        
        if instr == "p":
            if city1 == city2:
                selfset.add(city1)
                continue

            if cs1 == None and cs2 == None:
                sets.append({city1,city2})
            elif cs2 == None:
                cs1.add(city2)
            elif cs1 == None:
                cs2.add(city1)
            elif cs1 != cs2:
                sets[csi1] = cs1 | cs2
                del sets[csi2]
        elif instr == "q":
            if city1 == city2:
                if city1 in selfset:
                     WriteLine("connected")
                else:
                    WriteLine("not connected")
            else:
                if cs1 != None and cs1 == cs2:
                    WriteLine("connected")
                else:
                    WriteLine("not connected")
        else:
            raise Exception('Data de-synced near %s'%curline)

for QQ in xrange(5):
    try:
        solveCase(QQ)
    except: # exception? guess?
        if DEBUG:
            raise
        WriteLine(BS_ANSWER)
        raise
