FROM alpine:3.10.1

RUN apk add --no-cache \
      python3=3.7.3-r0


COPY ./requirements.txt /
RUN pip3 install --no-cache-dir -r /requirements.txt

WORKDIR /app
COPY ./simple_app /app

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8080"]