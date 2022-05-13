import sys

def openfile():
	"Opening input file"
	file_name = sys.argv[1]
	minsupport = int(sys.argv[2])
	nbuckets=int(sys.argv[3])
	"Reading input file"
	doc = open(file_name).read()
	"Removing newline characters"
	newfile=doc.split()
	"Creating buckets"
	buckets=[]
	for x in newfile:
   		buckets.append(x.split(','));
	size1freqset(minsupport,nbuckets,buckets);

def size1freqset(minsupport,nbuckets,buckets):
	
	"Creating Candidate List of Size 1"
	candidatelist1=[]
	finalist1=[]
	
	for i in range(0, len(buckets)):
		for b in buckets[i]:
			candidatelist1.append(b)

	candidatelist1=sorted(set(candidatelist1))
	# print(candidatelist1)

	"Appending frequent items of size 1 to finallist1"
	lala=0
	for k in candidatelist1:
		for i in range(0, len(buckets)):
			for j in buckets[i]:
				if(k==j):
					lala+=1
		if lala>=minsupport:
			finalist1.append(k)
		lala=0

	itemiddic={}
	counter=1
	for c in candidatelist1:
		itemiddic[c]=counter
		counter+=1

	if finalist1:
		print("Frequent Itemsets of size 1")
		for x in finalist1:
			print(x)
		size2freqset(minsupport,nbuckets,itemiddic,buckets,finalist1);
	else:
		print("Finished!")

def size2freqset(minsupport,nbuckets,itemiddic,buckets,finalist1):
	k=3
	countofbuckets=[0]*nbuckets
	bitmap=[0]*nbuckets
	pairs=[]
	
	"PCY Pass 1"
	for i in range(0,len(buckets)):
		for x in range(0,len(buckets[i])-1):
			for y in range(x+1,len(buckets[i])):
				if(buckets[i][x]<buckets[i][y]):
					countofbuckets[int(str(itemiddic[buckets[i][x]])+str(itemiddic[buckets[i][y]]))%nbuckets]+=1
					if ([buckets[i][x],buckets[i][y]] not in pairs):
						pairs.append(sorted([buckets[i][x],buckets[i][y]]))
				else:
					countofbuckets[int(str(itemiddic[buckets[i][y]])+str(itemiddic[buckets[i][x]]))%nbuckets]+=1
					if ([buckets[i][y],buckets[i][x]] not in pairs):
						pairs.append(sorted([buckets[i][y],buckets[i][x]]))

	pairs=sorted(pairs)

	for x in range(0,len(countofbuckets)):
		if countofbuckets[x]>=minsupport:
			bitmap[x]=1
		else:
			bitmap[x]=0

	prunedpairs=[]

	"Checking condition 1 of PCY Pass 2"
	
	for i in range(0,len(pairs)):
		for j in range(0,len(pairs[i])-1):
			if(pairs[i][j] in finalist1 and pairs[i][j+1] in finalist1):
				prunedpairs.append(pairs[i])

	# for f in prunedpairs:
	# 	print(f)

	candidatelist2=[]

	"Checking condition 2 of PCY Pass 2"
	for i in range(0, len(prunedpairs)):
		for j in range(0,len(prunedpairs[i])-1):
			if bitmap[int(str(itemiddic[prunedpairs[i][j]])+str(itemiddic[prunedpairs[i][j+1]]))%nbuckets]==1:
				candidatelist2.append(prunedpairs[i])

	# for p in candidatelist2:
	# 	print(p)

	"Appending frequent items of size 2 to finallist2"
	finalist2=[]
	p=0
	for c in range(0,len(candidatelist2)):
		for b in range(0,len(buckets)):	
			if set(candidatelist2[c]).issubset(set(buckets[b])):
				p+=1
		if p>=minsupport and p!=0:
			finalist2.append(sorted(candidatelist2[c]))
		p=0

	finalist2=sorted(finalist2)
	
	if finalist2:
		print("\nFrequent Itemsets of size 2")
		for b in finalist2:
			print(','.join(b))
		sizekfreqset(minsupport,nbuckets,itemiddic,buckets,finalist2,k);
	else:
		print("Finished!")


def sizekfreqset(minsupport,nbuckets,itemiddic,buckets,prevout,k):

	"Creating Candidate List of Size k"
	
	kcountofbuckets=[0]*nbuckets
	kbitmap=[0]*nbuckets
	kcombination=[]
	prevout=prevout
	
	"Make k combination e.g. triplets"
	for a in prevout:
		for b in prevout:
			if(a!=b):
				if set(a) & set(b) and len(list(set(a) & set(b))) >= k-2:
					kcombination.append(sorted(set(a)|set(b)))

	# print("checking kcombination")
	kcombination=sorted(kcombination)

	"PCY Pass 1 Hashing"

	hashingstring=""

	for i in range(0,len(kcombination)):
		for x in kcombination[i]:
			hashingstring+=str(itemiddic[x])
		kcountofbuckets[int(hashingstring)%nbuckets]+=1
		hashingstring=""

	for x in range(0,len(kcountofbuckets)):
		if kcountofbuckets[x]>=minsupport:
			kbitmap[x]=1
		else:
			kbitmap[x]=0

	"Condition 1 is automatically satisfied"

	"Checking condition 2 of PCY Pass 2"
	hashingstring=""
	klist=[]
	
	for i in range(0, len(kcombination)):
		for j in kcombination[i]:
			hashingstring+=str(itemiddic[j])
		if kbitmap[int(hashingstring)%nbuckets]==1:
			klist.append(kcombination[i])
		teststring=""

	"Creating Candidate List of Size k"
	candidatelistk=[]
	count=1
	for i in range(1, len(klist)):
		if klist[i]==klist[i-1]:
			count+=1
		else:
			# print("ELement is: ",klist[i-1]," and count is: ",count)
			if count>=k:
				candidatelistk.append(klist[i-1])
			count=1
	if count>=k:
		candidatelistk.append(klist[i-1])
		# print("ELement is: ",klist[i-1]," and count is: ",count)
	
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
		print("\nFrequent Itemsets of size ",k)
		for b in output:
			print(','.join(b))
		k+=1
		sizekfreqset(minsupport,nbuckets,itemiddic,buckets,output,k);
		# print("\n")
	else:
		print("Finished")

openfile();

