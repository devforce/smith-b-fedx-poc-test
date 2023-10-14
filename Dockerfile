FROM docker.repo.local.sfdc.net/sfci/gec/devforce/sfdc_centos7_ruby_3_2_nodejs16:a79bb0924e13eac1d69b13ec11196b9384f9a351

ARG NEXUS_USERNAME
ARG NEXUS_PASSWORD

ENV APP /usr/src/app

WORKDIR ${APP}
COPY Gemfile .
COPY Gemfile.lock .

RUN source /opt/rh/devtoolset-10/enable && \
    bundle config nexus-proxy.repo.local.sfdc.net "${NEXUS_USERNAME}:${NEXUS_PASSWORD}" && \
    bundle install && \
    bundle config disable_multisource true && \
    bundle config --delete nexus-proxy.repo.local.sfdc.net 

COPY . .

ENV PORT=7442
EXPOSE 7442

CMD ["bash", "-e", "bin/server"]
