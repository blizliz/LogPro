import re
fileIn = open('myfamily.ged', 'r')
fileOut = open('famPred.pl', 'w')

IDs = {}
for line in fileIn:
	if line[:4] == '0 @I':
		personID = line[2:11]
	elif line[2:6] == 'GIVN':
		name = line[7:].rstrip()
	elif line[2:6] == 'SURN':
		surname = line[7:].rstrip()
		fullname = '\'' + name + ' ' + surname + '\''
		IDs[personID] = fullname
	elif line[2:5] == 'SEX':
		sex = line[6]
		predicat = 'sex(' + fullname + ',' + sex + ').\n'
		fileOut.writelines(predicat)

fileIn.seek(0)
for line in fileIn:
	if line[:4] == '0 @F':
		husb = '_'; wife = '_'
	elif line[2:6] == 'HUSB':
		husbId = line[7:].rstrip()
		husb = IDs[husbId]
	elif line[2:6] == 'WIFE':
		wifeId = line[7:].rstrip()
		wife = IDs[wifeId]
	elif line[2:6] == 'CHIL':
		childId = line[7:].rstrip()
		child = IDs[childId]
		predicat = 'parents(' + child + ',' + husb + ',' + wife + ').\n'
		fileOut.writelines(predicat)

fileIn.close()
fileOut.close()