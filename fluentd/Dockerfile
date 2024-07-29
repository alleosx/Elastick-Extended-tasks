FROM fluent/fluentd:v1.17-1

# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install elasticsearch -v 7.8.0 \
 && sudo gem install fluent-plugin-s3 \
 && sudo gem install elasticsearch-api -v 7.8.0 \
 && sudo gem install elasticsearch-transport -v 7.8.0 \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh
RUN gem install fluent-plugin-elasticsearch -v 5.0.3 --no-document
RUN gem install fluent-plugin-prometheus -v 2.0.1 --no-document

RUN mkdir -p /var/log/fluent
RUN chown -R fluent /var/log/fluent

USER fluent
