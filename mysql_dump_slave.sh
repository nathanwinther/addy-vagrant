#!/bin/sh

mysqldump \
  --host="${ADDY_DB_HOST}" \
  --user="${ADDY_DB_USER}" \
  --password="${ADDY_DB_PASS}" \
  --no-create-db \
  --opt \
  --single-transaction\
  adverator > adverator.sql

