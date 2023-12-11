FROM python:3.11

WORKDIR /app
COPY app/requirements.txt requirements.txt
COPY run.py run.py

RUN apt update -y && apt install -y curl
RUN pip install -r requirements.txt

ENV PWD="/app"

CMD [ "flask", "--app", "app", "run", "--host","0.0.0.0", "-p", "5000"]