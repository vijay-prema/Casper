#!/usr/bin/env bash

# Please define the following env variables:

# GHOST_ADMIN_API_URL=https://yourblog.com
# GHOST_LOGIN_EMAIL=your@email.com
# GHOST_LOGIN_PASS=your-secure-login-password

source .env

yarn zip

curl -c ghost-cookie.txt -d username=$GHOST_LOGIN_EMAIL -d password=$GHOST_LOGIN_PASS \
   -H "Accept-Version: v5.0" \
   -H "Origin: $GHOST_ADMIN_API_URL" \
   $GHOST_ADMIN_API_URL/ghost/api/admin/session/

curl -X POST -b ghost-cookie.txt \
   -F 'file=@dist/casper-vijay.zip' \
   -H "Accept-Version: v5.0" \
   -H "Origin: $GHOST_ADMIN_API_URL" \
   $GHOST_ADMIN_API_URL/ghost/api/admin/themes/upload/
