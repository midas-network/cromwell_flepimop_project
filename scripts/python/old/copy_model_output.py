import os
import sys

outputFileListingString = sys.argv[1] 
print("copying model output... " + outputFileListingString)
outputFileListing = open(outputFileListingString,'r')
lines = outputFileListing.readlines()

target_topdir = "/midas"

count = 0
for line in lines:
	count += 1
	outputFile = line.strip()
	print("copying file... " + outputFile)
	outputFileDir = outputFile[0:outputFile.rfind('/') + 1]
	os.system('mkdir -p ' + target_topdir + '/' + outputFileDir + ' && cp ' + outputFile + ' ' + target_topdir + '/' + outputFile)


outputFileListing.close()
