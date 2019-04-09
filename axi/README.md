# AXI Protocol Checker
An easy-to-use AXI protocol checker using CoSA for model checking. This case study uses the OH! implementation of the AXI protocol, available [here](https://github.com/parallella/oh/tree/master/src/axi).

For convenience, the necessary files have been copied here into the src directory. These files are covered by the MIT license.

# Steps to use

* Instantiate your module in the `top_axi.v` file and use the provided AXI signals
* List your source files in `axi.vlist`
* Run `CoSA --problems problem.txt`
