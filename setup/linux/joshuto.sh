#!/bin/bash

git clone https://github.com/kamiyaa/joshuto
cargo install --path=. --force
cd ../
rm -rf joshuto
