#Python 3 Slim base image
FROM python:3-slim AS builder

#ADD . /app
WORKDIR /app
COPY . /app 

RUN ls /app

RUN pip install --target=/app requests
RUN pip install --target=/app pytest

FROM ubuntu:24.04
COPY --from=builder /app /app 
WORKDIR /app
ENV PYTHONPATH "/app"
RUN chmod u+x /app/test.py

ENTRYPOINT ["python ./app/test.py"]
