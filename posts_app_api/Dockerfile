FROM cimg/ruby:2.7.1

ARG TINI_VERSION=v0.19.0

RUN sudo apt-get update -qq \
  && sudo apt-get install -yq --no-install-recommends \
      libxml2-dev libxslt-dev libtool pkg-config \
      libbz2-dev libglib2.0-dev libxml2-dev libxslt-dev cmake \
  && sudo apt-get clean \
  && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && sudo truncate -s 0 /var/log/*log

ENV BUNDLE_JOBS=4 BUNDLE_RETRY=3

RUN gem update --system && gem install rake bundler --no-document

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/local/bin/tini
RUN sudo chmod a+x /usr/local/bin/tini

ENTRYPOINT ["/usr/local/bin/tini", "--"]
