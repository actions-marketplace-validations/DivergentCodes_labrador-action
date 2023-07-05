#!/bin/bash


# Determine outfile. Use local file for development,
# and env file in Github Actions.
if [ -n $GITHUB_ENV ]; then
    GHACTION_LABRADOR_OUTFILE="$GITHUB_ENV"
else
    GHACTION_LABRADOR_OUTFILE=./labrador-outfile.txt
fi

# Run Labrador.
./labrador fetch \
    --verbose \
    --out-file "$GHACTION_LABRADOR_OUTFILE"
