#this program is to test the number of similar mapping  when the random lut is generated 
#using a cryptographic key of 256bit

from sage.crypto.sbox import SBox

N=256
import os
import random
no_of_test_cases=256
def Get_Random_Index(min,max):   # this function returns a random index between min and max values
	while True:
		rand_int = ord(os.urandom(1))	
		if ((rand_int >=min) and (rand_int <= max)) :
			break
	return rand_int

def Get_Lut():	 
	lut = [i for i in range(N)]
	for i in range(0,N-1,1):
		swap_index = Get_Random_Index(i,N-1)
		lut[i],lut[swap_index]=lut[swap_index],lut[i]
	return lut

#print(s.differential_uniformity())       # Differential uniformity of AES Sbox
max_same_map=0
min_same_map=0
all_lut = []
same_mapping_array=[]
boomerang_uniformity_array=[]
differential_uniformity_array=[]
nonlinearity_array=[]
linearity_array=[]
for i in range(no_of_test_cases):
	lut=Get_Lut()
	all_lut.append(SBox(lut))
file=open("output_data.txt",'w')
for i in range(no_of_test_cases):
	boomerang_uniformity_array.append(all_lut[i].boomerang_uniformity()) # for AES it is 6
	differential_uniformity_array.append(all_lut[i].differential_uniformity()) #for AES it is 4
	nonlinearity_array.append(all_lut[i].nonlinearity()) # for AES it is 112 (max possible)
	linearity_array.append(all_lut[i].linearity())
	for j in range(no_of_test_cases):
		if(i==j): continue
		temp=0
		for k in range(N):
			if(all_lut[i][k]==all_lut[j][k]):
				temp+=1
		same_mapping_array.append(temp)
		
		#file.write("\n")



##--------------------------------Linearity--------------------------##
max_linearity=max(linearity_array)
min_linearityty=min(linearity_array)
summ=sum(linearity_array)
file.write("\n\nMax linearity: ")
file.write(str(max_linearity))
file.write("\nMin linearity: ")
file.write(str(min_linearityty))
file.write("\nAvg linearity ")
file.write(str(summ/float(no_of_test_cases)))


##--------------------------------Non linearity--------------------------##
max_nonlinearity=max(nonlinearity_array)
min_nonlinearityty=min(nonlinearity_array)
summ=sum(nonlinearity_array)
file.write("\n\nMax nonlinearity: ")
file.write(str(max_nonlinearity))
file.write("\nMin nonlinearity: ")
file.write(str(min_nonlinearityty))
file.write("\nAvg nonlinearity ")
file.write(str(summ/float(no_of_test_cases)))


##--------------------------------Differential uniformity--------------------------##
max_diff_uniformity=max(differential_uniformity_array)
min_diff_uniformity=min(differential_uniformity_array)
summ=sum(differential_uniformity_array)
file.write("\n\nMax Differential uniformity: ")
file.write(str(max_diff_uniformity))
file.write("\nMin Differential uniformity: ")
file.write(str(min_diff_uniformity))
file.write("\nAvg Differential uniformity ")
file.write(str(summ/float(no_of_test_cases)))


##--------------------------------boomerang uniformity--------------------------##
max_boom_uniformity=max(boomerang_uniformity_array)
min_boom_uniformity=min(boomerang_uniformity_array)
summ=sum(boomerang_uniformity_array)
file.write("\n\nMax boomerang uniformity: ")
file.write(str(max_boom_uniformity))
file.write("\nMin boomerang uniformity: ")
file.write(str(min_boom_uniformity))
file.write("\nAvg boomerang uniformity ")
file.write(str(summ/float(no_of_test_cases)))


##---------------------------------same mapping----------------------------------##
summ=sum(same_mapping_array)
max_same_map=max(same_mapping_array)
min_same_map=min(same_mapping_array)
file.write("\n\nMax same mapping: ")
file.write(str(max_same_map))
file.write("\nMin same mapping: ")
file.write(str(min_same_map))
file.write("\nAvg same mapping: ")
file.write(str(summ/float(no_of_test_cases*no_of_test_cases)))
file.write("\n")


file.close()
