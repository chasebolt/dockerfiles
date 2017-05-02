Docker image based off of [phusion/passenger-ruby22](https://github.com/phusion/passenger-docker)
that enables NGINX by default. This allows the use of mounting volumes into the container
rather that building new images to deploy a webapp. On startup the container will correct
file permissions for `/home/app/webapp` and run `bundler installer`.
