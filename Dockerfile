FROM python:3.11-alpine

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY requirements.txt .
RUN pip install -r requirements.txt

EXPOSE 8000/tcp

STOPSIGNAL SIGINT
CMD ["uwsgi", "--http", "0.0.0.0:8000", "--master", "-w", "wsgi:app"]
