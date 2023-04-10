#!/bin/bash

git clone https://github.com/kamiyaa/joshuto
cd joshuto
cargo install --path=. --force
cd ../
rm -rf joshuto
