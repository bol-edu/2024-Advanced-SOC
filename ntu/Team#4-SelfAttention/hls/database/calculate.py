import math
f = open("in_data.txt", "r")

mq = [[0]*64 for i in range(56)]
mk = [[0]*64 for i in range(56)]
mv = [[0]*64 for i in range(56)]

f = f.readlines()
  
for i in range(3):
  for j in range(56):
    for k in range(64):
      data = int(f[i*56*64 + j*64 + k])
      if i == 0:
        mq[j][k] = data
      elif i == 1:
        mk[j][k] = data
      elif i == 2:
        mv[j][k] = data
        
def dvd12(x):
  if (x > 0):
    return x / 4096
  else:
    return -((-1 * x) / 4096)

for i in range(56):
  maxn = -10000000
  avgn = 0
  list1 = []
  list2 = []
  maxn2 = -10000000
  cnt = 0
  for j in range(56):
    qk = 0
    for k in range(64):
      qk = qk + dvd12(mq[i][k]) * dvd12(mk[j][k])
      if (i==0 and j==0):
        print(dvd12(mq[i][k]), dvd12(mk[j][k]), qk)
    if (j != 0):
      threshold = (maxn + ((avgn * 3) / (j))) / 4
    else:
      threshold = -1000000
    
    #print(j, qk, maxn, avgn, threshold)
    if (qk > threshold):
      list1.append(j)
      cnt = cnt + 1
    if (qk > maxn):
        maxn = qk
        avgn = avgn + qk
    
  for j in range(cnt):
    qk = 0
    for k in range(64):
      qk = qk + mq[i][k] * mk[list1[j]][k]  
    qk = qk >> (22 + 3)
    list2.append(qk)
    
  for j in range(cnt):
    print(list1[j])
  
  maxn2 = -10000000
  for j in range(cnt):
    list2[j] = list2[j]
    if (list2[j] > maxn2):
      maxn2 = list2[j]
  for j in range(cnt):
    list2[j] = list2[j] - maxn2
  
  sum = 0
  for j in range(cnt):
    list2[j] = int(math.exp(float(list2[j]) + 5))
    sum = sum + list2[j]
  sum = int(65536 / sum)
  
  data_out = [0 for i in range (64)]
  for j in range(cnt):
    for k in range(64):
      data_out[k] = data_out[k] + (list2[j] * sum * mv[list1[j]][k]) >> 16
      #print(list1[j], list2[j]*sum, mv[list1[j]][k])
  
  

  break 



print("aaaaa")