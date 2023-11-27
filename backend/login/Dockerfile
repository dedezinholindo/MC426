FROM python:3.11

WORKDIR /app
COPY requirements.txt /app/requirements.txt
COPY login_registration.py /app/login_registration.py

RUN apt update -y && apt install -y curl
RUN pip install -r requirements.txt

ENV PWD="/app"

ENV PORT 5000
EXPOSE 5000
ENV N_WORKERS 1
ENV KEEPALIVE 300
ENV LOG_LEVEL "INFO"
ENV TIMEOUT 300

CMD gunicorn login_registration:app \
    -w ${N_WORKERS} \
    -b 0.0.0.0:${PORT} \
    --log-level ${LOG_LEVEL} \
    --timeout ${TIMEOUT} \
    --keep-alive ${KEEPALIVE}

#CMD [ "flask", "--app", "login_registration", "run", "--host","0.0.0.0", "-p", "5000"]