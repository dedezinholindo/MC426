FROM python:3.11

WORKDIR /app
COPY requirements.txt /app/requirements.txt
COPY login_registration.py /app/login_registration.py

RUN apt update -y && apt install -y curl
RUN pip install -r requirements.txt

ENV PWD="/app"
ENV PORT 4010
ENV N_WORKERS 1
ENV KEEPALIVE 300
ENV TIMEOUT 300
ENV LOG_JSON True
ENV LOG_LEVEL "INFO"
EXPOSE 4010

CMD ["flask", "run", "-h", "0.0.0.0", "-p", ${PORT}]
