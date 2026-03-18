FROM python:3.11-slim-bookworm
ENV DEBIAN_FRONTEND=noninteractive PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y --no-install-recommends git curl libatomic1 && rm -rf /var/lib/apt/lists/*

# Install Prisma CLI
RUN pip3 install prisma

COPY schema.prisma schema.prisma
COPY ./migrations migrations

# Generate Prisma client
RUN prisma generate

# Start Prisma Studio
CMD ["prisma", "migrate", "deploy"]
