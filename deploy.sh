#!/bin/sh
# Copyright (c) 2015 Wojciech A. Koszek <wojciech@koszek.com>

DEPLOY_FILE=$1

echo "============================================================================="
echo "# deployment started:"
echo "#   deploy repo: '${DEPLOY_REPO}'"
echo "#   deploy fn  : '${DEPLOY_FILE}'"
echo "#   deploy host: '${DEPLOY_HOST}'"
echo "#   deploy key : '${DEPLOY_KEY}'"
echo "#   deploy URL : '${DEPLOY_LOCATION}'"
echo "============================================================================="

K=encrypted_${DEPLOY_KEY}_key
IV=encrypted_${DEPLOY_LOCATION}_key

TMPDIR=/tmp/deploy
rm -rf $TMPDIR
mkdir -p $TMPDIR

KEYFN=${TMPDIR}/travis

openssl aes-256-cbc -K $K -iv $IV -in ${DEPLOY_REPO}.env -out ${KEYFN} -d

scp -i ${KEYFN} ${DEPLOY_FILE} ${DEPLOY_HOST}:${DEPLOY_LOCATION}
