#!/bin/bash

echo "${CRC_SETUP}" > /tmp/crc-setup.sh
chmod +x /tmp/crc-setup.sh

echo "${PULL_SECRETS}" > /tmp/pull-secrets-base64
cat /tmp/pull-secrets-base64 | base64 -d > /tmp/pull-secrets

echo "${HAPROXY_CFG}" > /tmp/haproxy.cfg