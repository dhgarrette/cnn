%module cnn
%{

#include "../cnn/cnn-helper.h"
#include "../cnn/dict.h"
#include "../cnn/dim.h"
#include "../cnn/except.h"
#include "../cnn/functors.h"
#include "../cnn/gpu-ops.h"
#include "../cnn/grad-check.h"
#include "../cnn/graph.h"
#include "../cnn/init.h"
#include "../cnn/random.h"
#include "../cnn/rnn-state-machine.h"
#include "../cnn/saxe-init.h"
#include "../cnn/timing.h"
#include "../cnn/cuda.h"
#include "../cnn/gpu-kernels.h"
#include "../cnn/aligned-mem-pool.h"
#include "../cnn/tensor.h"
#include "../cnn/model.h"
#include "../cnn/shadow-params.h"
#include "../cnn/training.h"
#include "../cnn/cnn.h"
#include "../cnn/conv.h"
#include "../cnn/exec.h"
#include "../cnn/nodes.h"
#include "../cnn/conll-2005.h"
#include "../cnn/dhg-util.h"
#include "../cnn/expr.h"
#include "../cnn/param-nodes.h"
#include "../cnn/rnn.h"
#include "../cnn/gru.h"
#include "../cnn/deep-lstm.h"
#include "../cnn/lstm.h"
#include "../cnn/c2w.h"
#include "../cnn/treelstm.h"
#include "../cnn/srl-viterbi.h"

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

%include "../cnn/cnn-helper.h"
%include "../cnn/dict.h"
%include "../cnn/dim.h"
%include "../cnn/except.h"
%include "../cnn/functors.h"
%include "../cnn/gpu-ops.h"
%include "../cnn/grad-check.h"
%include "../cnn/graph.h"
%include "../cnn/init.h"
%include "../cnn/random.h"
%include "../cnn/rnn-state-machine.h"
%include "../cnn/saxe-init.h"
%include "../cnn/timing.h"
%include "../cnn/cuda.h"
%include "../cnn/gpu-kernels.h"
%include "../cnn/aligned-mem-pool.h"
%include "../cnn/tensor.h"
%include "../cnn/model.h"
%include "../cnn/shadow-params.h"
%include "../cnn/training.h"
%include "../cnn/cnn.h"
%include "../cnn/conv.h"
%include "../cnn/exec.h"
%include "../cnn/nodes.h"
%include "../cnn/conll-2005.h"
%include "../cnn/dhg-util.h"
%include "../cnn/expr.h"
%include "../cnn/param-nodes.h"
%include "../cnn/rnn.h"
%include "../cnn/gru.h"
%include "../cnn/deep-lstm.h"
%include "../cnn/lstm.h"
%include "../cnn/c2w.h"
%include "../cnn/treelstm.h"
%include "../cnn/srl-viterbi.h"
