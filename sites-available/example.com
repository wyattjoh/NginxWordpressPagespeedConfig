server {
	server_name _;
	return 301 http://example.com$request_uri;
}

server {
	server_name example.com;
	root /srv/www/example.com/public_html;
	
	# Protect the site first
	include global/restrictions.conf;

	# Include pagespeed second
	include global/pagespeed.conf;
	
	# Only include one of the files below.
	include global/wordpress.conf;
}
