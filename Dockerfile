#Python 3 Slim base image
FROM python:3-slim AS builder

ADD ./app
WORKDIR /app
COPY . /app 

RUN pip install --target=/app requests
RUN pip install --target=/app pytest

FROM ubuntu-24.04
COPY --from=builder /app /app 
WORKDIR /app
ENV PYTHONPATH "/app:/app/github:/app/gitlab"

ENTRYPOINT ["app/gh_sync"]
