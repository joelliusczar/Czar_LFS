#!/bin/bash

bash setup1.sh &&
ch5_scripts.sh &&
{ echo "Ch 6 prereqs done"; exit 0; } ||
{ echo "Ch 6 prereqs had an error"; exit 1; }
