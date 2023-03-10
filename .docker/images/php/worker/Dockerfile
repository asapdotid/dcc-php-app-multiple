ARG BASE_IMAGE
FROM ${BASE_IMAGE} as base

# Timezone
ARG TIMEZONE
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE >/etc/timezone

RUN apk add --no-cache --update \
    supervisor \
    && rm -rf /etc/supervisord.conf

COPY ./images/php/worker/supervisor/ /etc/supervisor/

ARG PHP_WORKER_PROCESS_NUMBER
ARG PHP_WORKER_COMMAND="php $APP_CODE_PATH/artisan queue:work"
ARG PHP_WORKER_COMMAND_ARGS
RUN sed -i "s/numprocs=__PHP_WORKER_PROCESSES_NUMBER/numprocs=$PHP_WORKER_PROCESS_NUMBER/" /etc/supervisor/supervisord.conf && \
    sed -i "s#command=__PHP_WORKER_COMMAND#command=$PHP_WORKER_COMMAND $PHP_WORKER_COMMAND_ARGS#" /etc/supervisor/supervisord.conf && \
    sed -i "s/__APP_USER_NAME/$APP_USER_NAME/" /etc/supervisor/supervisord.conf && \
    mkdir /var/run/application/ && \
    chown $APP_USER_NAME:$APP_GROUP_NAME /var/run/application/

EXPOSE 9001

USER $APP_USER_NAME

CMD ["supervisord"]

FROM base as development

FROM base as production
