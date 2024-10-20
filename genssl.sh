     openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
          -subj '/CN=sni-support-required-for-valid-ssl' \
	       -keyout ssl/resty-auto-ssl-fallback.key \
	           -out ssl/resty-auto-ssl-fallback.crt
