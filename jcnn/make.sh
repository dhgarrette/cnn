mkdir -p src/main/java/edu/cmu/cs/clab/cnn
swig -c++ -java -package edu.cmu.cs.clab.cnn -outdir src/main/java/edu/cmu/cs/clab/cnn -o jcnn_wrap.cc jcnn.i

