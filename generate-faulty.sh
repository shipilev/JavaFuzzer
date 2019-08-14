#!/bin/bash
set -u

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# Number of tests to generate in the bundle
NUM_TESTS=16

PARALLEL=16

# Output directory
OUTDIR=tests/

R=`pwd`

rm -rf $OUTDIR
mkdir $OUTDIR
cp $R/rb/FuzzerUtils.java $OUTDIR
cp run*.sh $OUTDIR
cd $OUTDIR
javac FuzzerUtils.java
cd ..

seq -w 1 $NUM_TESTS | xargs -n 1 -P $PARALLEL -I TESTID bash -c "mkdir $OUTDIR/TESTID; cd $OUTDIR/TESTID; $R/generate-one-faulty.sh $R"