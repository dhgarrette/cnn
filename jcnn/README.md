# jcnn: cnn for for the JVM

export JAVA_HOME=/Library/Java/Home
export JAVA_INCLUDE=$JAVA_HOME/include
export JAVA_BIN=$JAVA_HOME/bin
export CNN_DIR=$HOME/workspace/cnn
export EIGEN_DIR=$HOME/workspace/eigen
export CNN_PACKAGE=edu.cmu.cs.clab.cnn
export packageWithSlashes=build/src/main/java/`echo $CNN_PACKAGE | sed -e 's/\./\//g'`


mkdir -p $packageWithSlashes
mkdir -p build/cnn

swig -c++ -java -nspace -package $CNN_PACKAGE -outdir $packageWithSlashes -o build/cnn/dict_wrap.cc swig/cnn/dict.i
g++ -fPIC -c build/cnn/dict_wrap.cc -I$JAVA_INCLUDE -I$JAVA_INCLUDE/darwin -I$BOOST_ROOT/include -o build/cnn/dict_wrap.o
g++ -shared build/cnn/dict_wrap.o ../build/cnn/libcnn_shared.dylib -o build/libjcnn.dylib


<!-- 
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

agenda = header_names[::]
ordered_header_names = []
while agenda:
  name = agenda.pop()
  deps = dep_map[name]
  if deps.issubset(set(ordered_header_names)):
    ordered_header_names.append(name)
  else:
    agenda.insert(0, name)

# for name in ordered_header_names:
#   print name, dep_map[name]

with open('/u/dhg/workspace/cnn/jcnn/build/cnn/cnn.i', 'w') as f:
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

  swig -c++ -java -package $CNN_PACKAGE -outdir $packageWithSlashes -o build/cnn/${name}_wrap.cc build/cnn/${name}.i
  g++ -std=c++0x -fPIC -c build/cnn/${name}_wrap.cc -I$CNN_DIR -I$EIGEN_DIR -I$JAVA_INCLUDE -I$JAVA_INCLUDE/darwin -I$BOOST_ROOT/include -o build/cnn/${name}_wrap.o
  g++ -shared build/cnn/${name}_wrap.o $CNN_DIR/build/cnn/libcnn_shared.dylib -o build/libjcnn.dylib
  
done
 -->



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


