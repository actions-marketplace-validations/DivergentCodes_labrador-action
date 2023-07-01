#!/bin/bash


# Determine AWS SSM Parameter Store path.
if [ -z $GHACTION_LABRADOR_AWS_PS ]; then
    echo "No AWS SSM Parameter Store path defined in env var: GHACTION_LABRADOR_AWS_PS"
    exit 1
else
    echo "GHACTION_LABRADOR_AWS_PS=$GHACTION_LABRADOR_AWS_PS"
fi

# Determine outfile.
if [ -n $GITHUB_ENV ]; then
    GHACTION_LABRADOR_OUTFILE="$GITHUB_ENV"
else
    GHACTION_LABRADOR_OUTFILE=./labrador-outfile.txt
fi

# Run Labrador.
./labrador fetch \
    --verbose \
    --out-file "$GHACTION_LABRADOR_OUTFILE" \
    --aws-ps "$GHACTION_LABRADOR_AWS_PS"
