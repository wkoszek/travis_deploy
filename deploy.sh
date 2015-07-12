#!/bin/bash
# Copyright (c) 2015 Wojciech A. Koszek <wojciech@koszek.com>

DEPLOY_RESOURCE=$1

echo "============================================================================="
echo "# env:"
env
echo "# printenv:"
printenv
echo "============================================================================="

echo "============================================================================="
echo "# deployment started:"
echo "#   deploy repo file: '${DEPLOY_FILE}'"
echo "#   deploy resource : '${DEPLOY_RESOURCE}'"
echo "#   deploy host     : '${DEPLOY_HOST}'"
echo "#   deploy key      : '${DEPLOY_KEY}'"
echo "#   deploy URL      : '${DEPLOY_LOCATION}'"
echo "============================================================================="

VAR_K=encrypted_${DEPLOY_KEY}_key
VAR_IV=encrypted_${DEPLOY_KEY}_iv

K=${!VAR_K}
IV=${!VAR_IV}

TMPDIR=/tmp/deploy
rm -rf $TMPDIR
mkdir -p $TMPDIR

KEYFN=${TMPDIR}/travis
openssl aes-256-cbc -K "${K}" -iv "${IV}" -in ${DEPLOY_FILE}.enc -out ${KEYFN} -d
chmod 600 $KEYFN

scp -o StrictHostKeyChecking=no -i ${KEYFN} ${DEPLOY_RESOURCE} ${DEPLOY_HOST}:${DEPLOY_LOCATION}
