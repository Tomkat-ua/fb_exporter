FROM tomkat/python-base:latest

WORKDIR /app

COPY requirements.txt /app
COPY *.py /app

RUN pip install -r requirements.txt

CMD [ "python3", "main.py" ]
