ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION} as base

# Timezone
ARG TIMEZONE
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

COPY --chown=nginx:nginx ./images/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx:nginx ./images/nginx/snippets/security.conf /etc/nginx/snippets/security.conf
COPY --chown=nginx:nginx ./images/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

ARG APP_CODE_PATH
RUN sed -i "s#root __NGINX_ROOT;#root $APP_CODE_PATH/public;#" /etc/nginx/conf.d/default.conf

FROM base as development

FROM base as production
