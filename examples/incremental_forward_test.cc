#include "cnn/nodes.h"
#include "cnn/cnn.h"
#include "cnn/training.h"
#include "cnn/gpu-ops.h"
#include "cnn/expr.h"
#include "cnn/dhg-util.h"
#include <boost/archive/text_oarchive.hpp>
#include <boost/archive/text_iarchive.hpp>

#include <iostream>
#include <fstream>

using namespace std;
using namespace cnn;
using namespace cnn::expr;

int main(int argc, char** argv) {
  cnn::Initialize(argc, argv);

  // parameters
  const unsigned HIDDEN_SIZE = 8;
  Model m;
  SimpleSGDTrainer sgd(&m);
  //MomentumSGDTrainer sgd(&m);

  ComputationGraph cg;

  Expression W = parameter(cg, m.add_parameters({HIDDEN_SIZE, 2}));
  Expression b = parameter(cg, m.add_parameters({HIDDEN_SIZE}));
  Expression V = parameter(cg, m.add_parameters({1, HIDDEN_SIZE}));
  Expression a = parameter(cg, m.add_parameters({1}));

  vector<cnn::real> x_values(2);  // set x_values to change the inputs to the network
  Expression x = input(cg, {2}, &x_values);
  cnn::real y_value;  // set y_value to change the target output
  Expression y = input(cg, &y_value);

  Expression h = tanh(W*x + b);
  //Expression h = softsign(W*x + b);
  Expression y_pred = V*h + a;
  Expression loss = squared_distance(y_pred, y);

  cg.PrintGraphviz();

  cout << "W = " << W.i << endl;
  cout << "b = " << b.i << endl;
  cout << "V = " << V.i << endl;
  cout << "a = " << a.i << endl;
  cout << "x = " << x.i << endl;
  cout << "y = " << y.i << endl;
  cout << "h = " << h.i << endl;
  cout << "y_pred = " << y_pred.i << endl;
  cout << "loss = " << loss.i << endl;
  cout << "cg.nodes.size() = " << cg.nodes.size() << endl;
  cout << endl;

  cout << "TEST cg.forward()" << endl; cg.forward(); cout << endl;
  cout << "TEST cg.incremental_forward()" << endl; cg.incremental_forward(); cout << endl;
  cout << "TEST cg.invalidate()" << endl; cg.invalidate(); cout << endl;
  cout << "TEST cg.incremental_forward()" << endl; cg.incremental_forward(); cout << endl;
  cout << "TEST cg.forward(h)" << endl; cg.forward(h.i); cout << endl;
  cout << "TEST cg.incremental_forward(y_pred)" << endl; cg.incremental_forward(y_pred.i); cout << endl;
  cout << "TEST cg.get_value(b)" << endl; cg.get_value(b.i); cout << endl;
  cout << "TEST cg.get_value(loss)" << endl; cg.get_value(loss.i); cout << endl;
  cout << "TEST cg.get_value(W)" << endl; cg.get_value(W.i); cout << endl;
  cout << "TEST cg.invalidate()" << endl; cg.invalidate(); cout << endl;
  cout << "TEST cg.get_value(y_pred)" << endl; cg.get_value(y_pred.i); cout << endl;
  cout << "TEST cg.get_value(h)" << endl; cg.get_value(h.i); cout << endl;


  cout << "TEST cg.forward(20)" << endl; cg.forward((VariableIndex) 20); cout << endl;
  cout << "TEST cg.incremental_forward(20)" << endl; cg.incremental_forward((VariableIndex) 20); cout << endl;
  cout << "TEST cg.get_value(20)" << endl; cg.get_value((VariableIndex) 20); cout << endl;



}

