%module cnn
%{

#include "cnn/cnn-helper.h"
#include "cnn/dict.h"
#include "cnn/dim.h"
#include "cnn/except.h"
#include "cnn/functors.h"
#include "cnn/gpu-ops.h"
#include "cnn/grad-check.h"
#include "cnn/graph.h"
#include "cnn/init.h"
#include "cnn/random.h"
#include "cnn/rnn-state-machine.h"
#include "cnn/saxe-init.h"
#include "cnn/timing.h"
#include "cnn/cuda.h"
//#include "cnn/gpu-kernels.h"
#include "cnn/aligned-mem-pool.h"
#include "cnn/tensor.h"
#include "cnn/model.h"
#include "cnn/shadow-params.h"
#include "cnn/training.h"
#include "cnn/cnn.h"
#include "cnn/conv.h"
#include "cnn/exec.h"
#include "cnn/nodes.h"
#include "cnn/conll-2005.h"
#include "cnn/dhg-util.h"
#include "cnn/expr.h"
#include "cnn/param-nodes.h"
#include "cnn/rnn.h"
#include "cnn/gru.h"
#include "cnn/deep-lstm.h"
#include "cnn/lstm.h"
//#include "cnn/c2w.h"
#include "cnn/treelstm.h"

%}

%include "std_string.i"

%include "/usr/local/Cellar/boost/1.58.0/include/boost/serialization/split_member.hpp"
%include "/usr/local/Cellar/boost/1.58.0/include/boost/serialization/strong_typedef.hpp"
%rename(op_apply) operator ();
%rename(op_lookup) operator [];
%rename(op_assign) operator =;
%rename(op_equals) operator ==;
%rename(op_notequalto) operator !=;
%rename(lessthan) operator <;
%rename(plus) operator +;
%rename(minus) operator -;
%rename(times) operator *;
%rename(divided_by) operator /;
%rename(op_double_lessthan) operator <<;
%rename("op_applyptr") cnn::Tensor::operator *() const;
%rename(op_and) operator unsigned&;
%rename(op_and_const) operator const unsigned&;
%rename(op_const_intaddr) operator const int&;
%rename(op_intaddr) operator int&;
%ignore cnn::Dim::Dim(std::initializer_list<long>);

%include "build/swig-cnn/cnn-helper.h"
%include "build/swig-cnn/dict.h"
%include "build/swig-cnn/dim.h"
%include "build/swig-cnn/except.h"
%include "build/swig-cnn/functors.h"
%include "build/swig-cnn/gpu-ops.h"
%include "build/swig-cnn/grad-check.h"
%include "build/swig-cnn/graph.h"
%include "build/swig-cnn/init.h"
%include "build/swig-cnn/random.h"
%include "build/swig-cnn/rnn-state-machine.h"
%include "build/swig-cnn/saxe-init.h"
%include "build/swig-cnn/timing.h"
%include "build/swig-cnn/cuda.h"
//include "build/swig-cnn/gpu-kernels.h"
%include "build/swig-cnn/aligned-mem-pool.h"
%include "build/swig-cnn/tensor.h"
%include "build/swig-cnn/model.h"
%include "build/swig-cnn/shadow-params.h"
%include "build/swig-cnn/training.h"
%include "build/swig-cnn/cnn.h"
%include "build/swig-cnn/conv.h"
%include "build/swig-cnn/exec.h"
%include "build/swig-cnn/nodes.h"
%include "build/swig-cnn/conll-2005.h"
%include "build/swig-cnn/dhg-util.h"
%include "build/swig-cnn/expr.h"
%include "build/swig-cnn/param-nodes.h"
%include "build/swig-cnn/rnn.h"
%include "build/swig-cnn/gru.h"
%include "build/swig-cnn/deep-lstm.h"
%include "build/swig-cnn/lstm.h"
//include "build/swig-cnn/c2w.h" 
%include "build/swig-cnn/treelstm.h"
