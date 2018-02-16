### Sets ###
set J; # set of jobs released

### Variables ###
var C{J} >= 0; # completion times
var T{J} >= 0; # tardiness
var X{J, J} binary; # or variable

### Parameters ###
param r{J}; # release time
param p{J}; # processing time
param w{J}; # weight
param d{J}; # due date
param M := sum{j in J}p[j]+max{j in J}r[j]; # large M

### Objective ###
minimize wT: sum{j in J}w[j]*T[j]; # weighted tardiness

### Constraints ###
s.t. tardiness{j in J}: C[j]<=d[j]+T[j];
s.t. release_time{j in J}: C[j]>=r[j]+p[j];
s.t. overlap1{j in J, k in J: j<k}:
	M*X[j,k]+C[j]>=C[k]+p[j];
s.t. overlap2{j in J, k in J: j<k}:
	M*(1-X[j,k])+C[k]>=C[j]+p[k];