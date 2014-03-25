#!/bin/bash

if [ -z "$WORKSPACE" ]; then
	WORKSPACE=`pwd`
    echo "Guessing WORKSPACE is $WORKSPACE"
fi

VISUALISER_DIR="$WORKSPACE/BCCVL_Visualiser"
BIN_DIR="$VISUALISER_DIR/bin"

PIP="$BIN_DIR/pip"
PYTHON="$BIN_DIR/python"
BUILDOUT="$BIN_DIR/buildout"
TESTS="$BIN_DIR/test"
COVERAGE="$BIN_DIR/coverage"

echo "Using WORKSPACE $WORKSPACE"
cd $WORKSPACE

echo "Setting up virtualenv in $WORKSPACE"
curl -O https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.9.tar.gz
tar -xvzf virtualenv-1.9.tar.gz
cd virtualenv-1.9
python virtualenv.py -p /usr/bin/python2.7 "$VISUALISER_DIR"
cd "$VISUALISER_DIR"
source bin/activate

echo "Python version:"
"$PYTHON" --version

echo "Installing Dependencies"
"$PIP" install setuptools --upgrade
"$PIP" install numpy --upgrade 

echo "Building Visualiser"
"$PYTHON" bootstrap.py
"$BUILDOUT"

# Run unit tests
echo "Running unit tests"
"$TESTS" --with-xunit
TEST_RESULT=$?

echo "Building coverage data"
"$COVERAGE" xml --omit=./lib/*/*.py,./tests/*/*.py,./eggs/*/*.py

# So that Jenkins can see the source
#sed "s#filename=\"#filename=\"$WORKSPACE/data_mover/#g" coverage.xml > coverage-fixed.xml
sed "s#<\!-- Generated by coverage.py: http:\/\/nedbatchelder.com\/code\/coverage -->#<sources><source>$WORKSPACE/BCCVL_Visualiser<\/source><\/sources>#g" coverage.xml > coverage-fixed.xml

# So the build fails in Jenkins when unit tests fail
exit $TEST_RESULT
