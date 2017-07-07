FROM debian:stretch-slim

ENTRYPOINT ["/usr/local/sbin/php-fpm"]
CMD ["-y", "/srv/www/config/php/fpm.ini"]
STOPSIGNAL SIGQUIT
WORKDIR /srv/www

ENV DEBIAN_FRONTEND="teletype" LANG="C.UTF-8" \
	TRV_HSW_SERVICE_PHP_OPCACHE_TTL=1 \
	TRV_HSW_SERVICE_PHP_ZEND_ASSERTIONS=1

COPY resources/vendor-keys.pub /usr/local/src/vendor-keys.pub

RUN \
set -exu;\
\
readonly PHP_VERSION=7.1.6;\
readonly PHP_DIGEST=01584dc521ab7ec84b502b61952f573652fe6aa00c18d6d844fb9209f14b245b;\
readonly PHP_DEPS='libcurl4-openssl-dev libgmp-dev libicu-dev libxml2-dev zlib1g-dev';\
readonly BUILD_DEPS='build-essential ca-certificates curl gnupg re2c';\
\
mkdir -p /etc/dpkg/dpkg.conf.d;\
echo 'path-exclude /usr/share/doc-base/*' > /etc/dpkg/dpkg.conf.d/01_nodoc;\
echo 'path-exclude /usr/share/doc/*' >> /etc/dpkg/dpkg.conf.d/01_nodoc;\
echo 'path-exclude /usr/share/groff/*' >> /etc/dpkg/dpkg.conf.d/01_nodoc;\
echo 'path-exclude /usr/share/info/*' >> /etc/dpkg/dpkg.conf.d/01_nodoc;\
echo 'path-exclude /usr/share/linda/*' >> /etc/dpkg/dpkg.conf.d/01_nodoc;\
echo 'path-exclude /usr/share/lintian/*' >> /etc/dpkg/dpkg.conf.d/01_nodoc;\
echo 'path-exclude /usr/share/man/*' >> /etc/dpkg/dpkg.conf.d/01_nodoc;\
\
cd /usr/local/src;\
apt-get update -q;\
apt-get install -q -y --auto-remove --no-install-recommends --no-install-suggests ${BUILD_DEPS} ${PHP_DEPS};\
\
mkdir -p /usr/include/curl;\
ln -s /usr/include/x86_64-linux-gnu/curl/easy.h /usr/include/curl/easy.h;\
\
gpg --import vendor-keys.pub;\
rm /usr/local/src/vendor-keys.pub;\
\
cd /usr/local/src;\
curl -sLSo php.tar.xz https://secure.php.net/get/php-${PHP_VERSION}.tar.xz/from/this/mirror;\
echo "${PHP_DIGEST} *php.tar.xz" | sha256sum -c -;\
curl -sLSo php.tar.xz.asc https://secure.php.net/get/php-${PHP_VERSION}.tar.xz.asc/from/this/mirror;\
gpg --batch --verify php.tar.xz.asc php.tar.xz;\
tar -xJf php.tar.xz;\
\
adduser --system --group --disabled-password --disabled-login --no-create-home php;\
\
cd /usr/local/src/php-${PHP_VERSION};\
export CFLAGS='-fstack-protector-strong -fpic -fpie -O2 -pipe';\
export PHP_CPPFLAGS="${CFLAGS}";\
export LDFLAGS='-pie -s -Wl,-O1 -Wl,--hash-style,gnu,-z,relro,-z,now';\
./configure \
--build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
--with-config-file-path=/srv/www/config/php \
--with-config-file-scan-dir=/srv/www/config/php/fpm-enabled \
--with-libdir="lib/$(dpkg-architecture --query DEB_BUILD_MULTIARCH)" \
\
--disable-cgi \
--disable-cli \
--disable-rpath \
--disable-short-tags \
--enable-fpm \
--enable-inline-optimization \
--enable-ipv6 \
--enable-libgcc \
--enable-re2c-cgoto \
--enable-static \
\
--with-fpm-user=php \
--with-fpm-group=php \
\
--disable-all \
--enable-fileinfo \
--enable-filter \
--enable-intl \
--enable-json \
--enable-mbstring \
--enable-mysqlnd \
--enable-opcache \
--enable-pcntl \
--enable-sockets \
--with-curl \
--with-gmp \
--with-mysqli=mysqlnd \
--with-pcre-jit \
--with-pcre-regex \
--with-pic \
--with-zlib;\
make -sj `nproc`;\
make -s install;\
strip --strip-all /usr/local/sbin/php-fpm;\
\
mkdir -p /var/log/php;\
ln -sf /dev/stdout /var/log/php/access.log;\
ln -sf /dev/stderr /var/log/php/error.log;\
\
apt-get purge -q -y --auto-remove ${BUILD_DEPS};\
apt-get clean -q -y;\
rm -rf \
/etc/dpkg/dpkg.conf.d/ \
/root/.gnupg/ \
/tmp/* \
/usr/local/etc/nginx/ \
/usr/local/src/ \
/usr/share/doc-base/ \
/usr/share/doc/ \
/usr/share/groff/ \
/usr/share/info/ \
/usr/share/linda/ \
/usr/share/lintian/ \
/usr/share/man/ \
/var/lib/apt/lists/* \
/var/tmp/*;\
\
php-fpm -v
