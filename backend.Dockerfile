FROM python:3.11-slim-bookworm
ENV DEBIAN_FRONTEND=noninteractive PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    libatomic1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /backend

COPY backend/requirements.txt requirements.txt
COPY schema.prisma schema.prisma


RUN pip3 install -r requirements.txt
RUN prisma generate

COPY ./backend/src src

WORKDIR /backend/src

CMD ["sh", "-c", "gunicorn -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8081 --timeout 180 --workers 4 app:app"]
