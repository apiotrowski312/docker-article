FROM alpine:3.10.1

ENV USER=prodUser UID=12345 GID=23456

RUN apk add --no-cache \
      build-base=0.5-r1 \
      python3=3.7.3-r0 \
      python3-dev=3.7.3-r0 \
      postgresql-client=11.4-r0 \
      postgresql-dev=11.4-r0


COPY ./requirements.txt /
RUN pip3 install --no-cache-dir -r /requirements.txt

WORKDIR /app
COPY ./simple_app /app

RUN addgroup --gid "$GID" "$USER" \
    && adduser \
    --disabled-password \
    --gecos "" \
    --ingroup "$USER" \
    --uid "$UID" \
    "$USER"
USER $USER

CMD ["gunicorn", "-b 0.0.0.0:8080", "simple_app.wsgi:application"]
