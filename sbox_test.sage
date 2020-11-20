from sage.crypto.sboxes import SBox
from sage.crypto.sboxes import AES as s
import os
import random
N=256
def Get_Random_Index(min,max):   # this function returns a random index between min and max values
	while True:
		rand_int = ord(os.urandom(1))	
		if ((rand_int >=min) and (rand_int <= max)) :
			break
	return rand_int

def Get_Lut():	 
	lut = [i for i in range(256)]
	for i in range(0,N-1,1):
		swap_index = Get_Random_Index(i,255)
		lut[i],lut[swap_index]=lut[swap_index],lut[i]
	return lut

#print(s.differential_uniformity())       # Differential uniformity of AES Sbox
mat = [[0]*256 for i in range(256)]

min=max=12    # variable max and min uniformity
for i in range(256):
	lut=SBox(Get_Lut())
	#the below line will get max and min uniformity
	temp=lut.differential_uniformity()
	if(temp>max):
		max=temp
	if(temp<min):
		min=temp
file=open("diff_uniformity.txt",'w')
file.write("Max: ")
file.write(str(max))
file.write("\nMin: ")
file.write(str(min))
file.close()

'''
	#this loop counts the mapping of lut in each elements to each possible cell
	for i in range(256):
		mat[i][lut[i]]+=1
	print(mat)
'''
