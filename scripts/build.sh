#!/bin/bash

# Latest version of V is downloaded and built
git clone https://github.com/vlang/v
cd v && make && cd .. 

# The application is built
./v/v . -o vapi
