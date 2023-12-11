FROM python:3.11

COPY run.py run.py
WORKDIR /app
COPY requirements.txt requirements.txt


RUN apt update -y && apt install -y curl
RUN pip install -r requirements.txt

ENV PWD="/app"

CMD [ "flask", "--app", "app", "run", "--host","0.0.0.0", "-p", "5000"]