# melonDS_fuzzing
Centralized repo for fuzzing this emulator. Everything in the repo is *supposed to be* (haven't gotten around to it yet) set up to fuzz entirely within this repo, but we can just use it for file storage.

## Using the repo as storage
Store the crashing files in `crashfiles` and the ROMs in example\_roms.
Throw any information (notes, thoughts, etc) into the repo as needed.

## Setting up Instrumentation
Just clone the melonDS repo into the same directory as this README, it should be included in the .gitignore.
Then do the following commands to instrument:
```
cd melonDS/
mkdir build
cmake -B build -DCMAKE_C_COMPILER=afl-cc -DCMAKE_CXX_COMPILER=afl-c++
cmake --build build -j7
```

## Running afl-fuzz
Run the following command to run `afl-fuzz`: `afl-fuzz -i in -o out -t 5000 build/melonDS @@`
