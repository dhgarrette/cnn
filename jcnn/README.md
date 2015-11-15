# jcnn: cnn for for the JVM

export JAVA_HOME=/Library/Java/Home
export JAVA_INCLUDE=$JAVA_HOME/include
export JAVA_BIN=$JAVA_HOME/bin
export CNN_DIR=$HOME/workspace/cnn
export EIGEN_DIR=$HOME/workspace/eigen
export CNN_PACKAGE=edu.cmu.cs.clab.cnn
export BOOST_ROOT=/usr/local/Cellar/boost/1.58.0
export packageWithSlashes=build/src/main/java/`echo $CNN_PACKAGE | sed -e 's/\./\//g'`


mkdir -p $packageWithSlashes
mkdir -p build/cnn

swig -c++ -java -nspace -package $CNN_PACKAGE -outdir $packageWithSlashes -o build/cnn/dict_wrap.cc swig/cnn/dict.i
g++ -fPIC -c build/cnn/dict_wrap.cc -I$JAVA_INCLUDE -I$JAVA_INCLUDE/darwin -I$BOOST_ROOT/include -o build/cnn/dict_wrap.o
g++ -shared build/cnn/dict_wrap.o ../build/cnn/libcnn_shared.dylib -o build/libjcnn.dylib


import os
cnn_dir = "/u/dhg/workspace/cnn/cnn/"
header_names = [f[:-2] for f in os.listdir(cnn_dir) if f.endswith(".h")]
dep_map = {}
for name in header_names:
  with open(os.path.join(cnn_dir,name+".h")) as f:
    deps = set()
    for line in f.readlines():
      if line.startswith("#include \"cnn/"):
        deps.add(line[len("#include \"cnn/"):-4])
  dep_map[name] = deps

# for k,vs in dep_map.iteritems():
#   print k, vs

# agenda = header_names[::]
agenda = [k for k,v in sorted(((k,v) for (k,v) in sorted(dep_map.iteritems())), key=lambda t: len(t[1]))][::]
#print 'initial agenda:', agenda
ordered_header_names = []
head_queue = []
while agenda:
  name = agenda[0]
  agenda = agenda[1:]
  deps = dep_map[name]
  if deps.issubset(set(ordered_header_names)):
    ordered_header_names.append(name)
    agenda = head_queue + agenda
    head_queue = []
  else:
    head_queue.append(name)
#  print 'agenda:', agenda
#  print 'head_queue:', head_queue
#  print 'ordered_header_names:', ordered_header_names
    
    
#for name in ordered_header_names:
#  print name, dep_map[name]

<!-- 
with open('/u/dhg/workspace/cnn/jcnn/build/cnn/jcnn.i', 'w') as f:
  f.write("""%module cnn
%{\n
""")
  for name in ordered_header_names:
    f.write("#include \"../../../cnn/"+name+".h\"\n")
  f.write("""
%}\n
%include \"std_string.i\"
\n""")
  for name in ordered_header_names:
    f.write("%include \"../../../cnn/"+name+".h\"\n")

  swig -c++ -java -package $CNN_PACKAGE -outdir $packageWithSlashes -o build/cnn/cnn_wrap.cc build/cnn/cnn.i

  #swig -c++ -java -package $CNN_PACKAGE -outdir $packageWithSlashes -o build/cnn/${name}_wrap.cc build/cnn/${name}.i
  #g++ -std=c++0x -fPIC -c build/cnn/${name}_wrap.cc -I$CNN_DIR -I$EIGEN_DIR -I$JAVA_INCLUDE -I$JAVA_INCLUDE/darwin -I$BOOST_ROOT/include -o build/cnn/${name}_wrap.o
  #g++ -shared build/cnn/${name}_wrap.o $CNN_DIR/build/cnn/libcnn_shared.dylib -o build/libjcnn.dylib
done
 -->


for name in ordered_header_names:
  print 'name=' + name
  with open('/u/dhg/workspace/cnn/jcnn/build/cnn/'+name+'.i', 'w') as f:
    f.write("""%module """+name.replace('-','_')+"""_module
%{

#include \"../../../cnn/"""+name+""".h\"

%}

%include \"std_string.i\"

%include \"../../../cnn/"""+name+""".h\"
""")


  #swig -c++ -java -package $CNN_PACKAGE -outdir $packageWithSlashes -o build/cnn/${name}_wrap.cc build/cnn/${name}.i
  #g++ -std=c++0x -fPIC -c build/cnn/${name}_wrap.cc -I$CNN_DIR -I$EIGEN_DIR -I$JAVA_INCLUDE -I$JAVA_INCLUDE/darwin -I$BOOST_ROOT/include -o build/cnn/${name}_wrap.o
  #g++ -shared build/cnn/${name}_wrap.o $CNN_DIR/build/cnn/libcnn_shared.dylib -o build/libjcnn.dylib










for f in ../cnn/*.h; do
  nopath=$(basename $f)
  name=${nopath/%??/}  # ${f::${#f}-2}
  echo "${name}"

  echo "%module ${name}_module
%{

#include \"../../../cnn/${name}.h\"

%}

%include \"std_string.i\"
%include \"../../../cnn/${name}.h\"

" > build/cnn/${name}.i

  swig -c++ -java -package $CNN_PACKAGE -outdir $packageWithSlashes -o build/cnn/${name}_wrap.cc build/cnn/${name}.i
  #g++ -std=c++0x -fPIC -c build/cnn/${name}_wrap.cc -I$CNN_DIR -I$EIGEN_DIR -I$JAVA_INCLUDE -I$JAVA_INCLUDE/darwin -I$BOOST_ROOT/include -o build/cnn/${name}_wrap.o
  #g++ -shared build/cnn/${name}_wrap.o $CNN_DIR/build/cnn/libcnn_shared.dylib -o build/libjcnn.dylib
  
done







swig -c++ -java -package $CNN_PACKAGE -outdir $packageWithSlashes -o build/cnn/dict_wrap.cc swig/cnn/dict.i
g++ -fPIC -c build/cnn/dict_wrap.cc -I$JAVA_INCLUDE -I$JAVA_INCLUDE/darwin -I$BOOST_ROOT/include -o build/cnn/dict_wrap.o
g++ -shared build/cnn/dict_wrap.o ../build/cnn/libcnn_shared.dylib -o build/libjcnn.dylib

















javac -cp build/src/main/java DictTest.java
java -cp .:build/src/main/java -Djava.library.path=$CNN_DIR/jcnn/build DictTest













g++ -fPIC -c dict_wrap.cc -I$JAVA_INCLUDE -I$JAVA_INCLUDE/darwin -I$BOOST_ROOT/include


























name=cnn-helper
name=dict

name=dim
%ignore cnn::Dim::Dim(std::initializer_list<long>);
%rename(op_lookup) operator [];
%rename(op_equals) operator ==;
%rename(op_notequals) operator !=;
%rename(op_double_lessthan) operator <<;

name=except
build/cnn/../../../cnn/except.h:9: Warning 401: Nothing known about base class 'std::runtime_error'. Ignored.
build/cnn/../../../cnn/except.h:17: Warning 401: Nothing known about base class 'std::logic_error'. Ignored.
build/cnn/../../../cnn/except.h:23: Warning 401: Nothing known about base class 'std::runtime_error'. Ignored.

name=functors
%rename(op_apply) operator ();

name=gpu-ops
name=grad-check
name=graph
name=init
name=random
name=rnn-state-machine
name=saxe-init
name=timing
name=cuda

name=gpu-kernels
-- remove "__global__" from gpu-kernels.h

name=aligned-mem-pool

name=tensor
%include "/usr/local/Cellar/boost/1.58.0/include/boost/serialization/split_member.hpp"
%rename(times) operator *;
%rename("times_nonconst") cnn::Tensor::operator *() const;
%rename(op_double_lessthan) operator <<;

name=model
%include "/usr/local/Cellar/boost/1.58.0/include/boost/serialization/split_member.hpp"


name=shadow-params
name=training

name=cnn
%include "/usr/local/Cellar/boost/1.58.0/include/boost/serialization/strong_typedef.hpp"
%rename(op_equals) operator ==;
%rename(op_assign) operator =;
%rename(op_lessthan) operator <;
%rename(op_and) operator unsigned&;
%rename(op_and_const) operator const unsigned&;
%rename("add_input_constPtr") cnn::ComputationGraph::add_input(real const *);
%rename("add_input_constPtr") cnn::ComputationGraph::add_input(real const *);
-- has a warning that i think is ignorable

name=conv  -- don't understand Node
%include "../../../cnn/cnn.h"
%include "/usr/local/Cellar/boost/1.58.0/include/boost/serialization/strong_typedef.hpp"
%rename(op_equals) operator ==;
%rename(op_assign) operator =;
%rename(op_lessthan) operator <;
%rename(op_and) operator unsigned&;
%rename(op_and_const) operator const unsigned&;
%rename("add_input_constPtr") cnn::ComputationGraph::add_input(real const *);
%rename("add_input_constPtr") cnn::ComputationGraph::add_input(real const *);

name=exec

XXXX name=nodes  -- don't understand Node
%include "../../../cnn/cnn.h"
%include "/usr/local/Cellar/boost/1.58.0/include/boost/serialization/strong_typedef.hpp"
%rename(op_equals) operator ==;
%rename(op_assign) operator =;
%rename(op_lessthan) operator <;
%rename(op_and) operator unsigned&;
%rename(op_and_const) operator const unsigned&;
%rename("add_input_constPtr") cnn::ComputationGraph::add_input(real const *);
%rename("add_input_constPtr") cnn::ComputationGraph::add_input(real const *);

name=conll-2005
name=dhg-util

XXXX name=expr
%rename(plus) operator +;
%rename(minus) operator -;
%rename(times) operator *;
%rename(divided_by) operator /;
%rename("input_constPtr") cnn::expr::input(ComputationGraph &,real const *);

XXXX name=param-nodes  -- don't understand Node; overloaded

name=rnn
%include "/usr/local/Cellar/boost/1.58.0/include/boost/serialization/strong_typedef.hpp"
%rename(op_equals) operator ==;
%rename(op_assign) operator =;
%rename(op_lessthan) operator <;
%rename(op_const_intaddr) operator const int&;
%rename(op_intaddr) operator int&;
-- has a warning that i think is ignorable

XXXX name=gru   -- don't know about RNNBuilder
XXXX name=deep-lstm   -- don't know about RNNBuilder
XXXX name=lstm   -- don't know about RNNBuilder

name=c2w

XXXX name=treelstm   -- don't know about RNNBuilder

name=srl-viterbi



dim.i:

















## jcnn.i
-- gpu-ops.h: remove `softmax` definition





export JAVA_INCLUDE=$JAVA_HOME/include
export BOOST_ROOT=/usr/local/Cellar/boost/1.58.0
export CNN_DIR=$HOME/workspace/cnn
export EIGEN_DIR=$HOME/workspace/eigen

mkdir -p src/main/java/edu/cmu/cs/clab/cnn
mkdir -p build/swig-cnn
cp ../cnn/*.h build/swig-cnn
cp ~/workspace/nn/cpp/cnn/dhg-util.h build/swig-cnn/
cp ~/workspace/nn/cpp/cnn/conll-2005.h build/swig-cnn/
swig -c++ -java -package edu.cmu.cs.clab.cnn -outdir src/main/java/edu/cmu/cs/clab/cnn -o build/jcnn_wrap.cc jcnn.i

// edit jcnn_wrap.cc to remove references to "p< Eigen::MatrixXf,Eigen::Align"

g++ -fPIC -std=c++11 -c build/jcnn_wrap.cc -I$CNN_DIR -I$EIGEN_DIR -I$JAVA_INCLUDE -I$JAVA_INCLUDE/darwin -I$BOOST_ROOT/include -o build/jcnn_wrap.o
g++ -shared build/jcnn_wrap.o ../build/cnn/libcnn_shared.dylib -o build/libjcnn.dylib

javac -cp .:src/main/java DictTest.java
java -cp .:src/main/java -Djava.library.path=$CNN_DIR/jcnn DictTest


































