import sys

def openfile():
	"Opening input file"
	file_name = sys.argv[1]
	minsupport = int(sys.argv[2])
	
	"Reading input file"
	doc = open(file_name).read()

	"Removing newline characters"
	newfile=doc.split()

	"Creating buckets"
	buckets=[]
	for x in newfile:
		buckets.append(x.split(','))
	 
	size1freqset(minsupport,buckets);

def size1freqset(minsupport,buckets):
	
	"Creating Candidate List of Size 1"
	candidatelist1=[]
	finalist1=[]
	
	for i in range(0, len(buckets)):
		for b in buckets[i]:
			candidatelist1.append(b)

	candidatelist1=sorted(set(candidatelist1))

	"Appending frequent items of size 1 to finalist1"
	lala=0
	for k in candidatelist1:
		for i in range(0, len(buckets)):
			for j in buckets[i]:
				if(k==j):
					lala+=1
		if lala>=minsupport:
			finalist1.append(k)
		lala=0

	finalist1=sorted(finalist1)
	if finalist1:
		print("\n######### Frequent Itemset(s) of size 1 #########\n")
		for x in finalist1:
			print(x)
		size2freqset(minsupport,buckets,finalist1);
	else:
		print("No combination satisfied your entered minsupport!")

def size2freqset(minsupport,buckets,finalist1):

	"Creating Candidate List of Size 2"
	k=3
	candidatelist2=[]
	finalist2=[]

	for x in range(0,len(finalist1)-1):
		for y in range(x+1,len(finalist1)):
			candidatelist2.append([finalist1[x],finalist1[y]])

	"Appending frequent items of size 2 to finalist12"
	p=0
	for c in range(0,len(candidatelist2)):
		for b in range(0,len(buckets)):	
			if set(candidatelist2[c]).issubset(set(buckets[b])):
				p+=1
		if p>=minsupport and p!=0:
			finalist2.append(candidatelist2[c])
		p=0

	finalist2=sorted(finalist2)

	if finalist2:
		print("\n######### Frequent Itemset(s) of size 2 #########\n")
		for b in finalist2:
			print(','.join(b))
		sizekfreqset(minsupport,buckets,finalist2,k);
	else:
		print("\n######################################")
		print("No Further Frequent Itemsets Found...")
		print("######################################")

def sizekfreqset(minsupport,buckets,prevout,k):

	"Creating Candidate List of Size k"
	kcombination=[]
	prevout=prevout
	for a in prevout:
		for b in prevout:
			if(a!=b):
				if set(a) & set(b) and len(list(set(a) & set(b))) >= k-2:
					kcombination.append(sorted(set(a)|set(b)))

	kcombination=sorted(kcombination)

	candidatelistk=[]

	count=1
	for i in range(1, len(kcombination)):
		if kcombination[i]==kcombination[i-1]:
			count+=1
		else:
			if count>=k:
				candidatelistk.append(kcombination[i-1])
			count=1
	if count>=k:
		candidatelistk.append(kcombination[i-1])

	"Appending frequent items of size k to output"
	output=[]
	counter=0
	for c in range(0,len(candidatelistk)):
		for b in range(0,len(buckets)):
			if set(candidatelistk[c]).issubset(set(buckets[b])):
				counter+=1
		if counter>=minsupport and counter!=0:
			output.append(candidatelistk[c])
		counter=0

	if output:
		print("\n######### Frequent Itemset(s) of size ",k,"#########\n")
		for b in output:
			print(','.join(b))
		k+=1
		sizekfreqset(minsupport,buckets,output,k);
	else:
		print("\n######################################")
		print("No Further Frequent Itemsets Found...")
		print("######################################")

openfile();
