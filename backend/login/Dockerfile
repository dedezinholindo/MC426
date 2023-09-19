FROM python:3.11

WORKDIR /app
COPY requirements.txt /app/requirements.txt
COPY login_registration.py /app/login_registration.py

RUN apt update -y && apt install -y curl
RUN pip install -r requirements.txt

ENV PWD="/app"

CMD [ "flask", "--app", "login_registration", "run", "--host","0.0.0.0", "-p", "5000"]