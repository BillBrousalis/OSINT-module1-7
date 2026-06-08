FROM python:3.12-slim

RUN pip install flask --no-cache-dir

WORKDIR /app
COPY app.py .
COPY templates/ templates/
COPY static/ static/

EXPOSE 8080

CMD ["python", "app.py"]