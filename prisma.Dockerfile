FROM python:3.11-slim-bookworm
ENV DEBIAN_FRONTEND=noninteractive PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y --no-install-recommends git curl && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    libatomic1 \
    && rm -rf /var/lib/apt/lists/*

# Install Prisma CLI
RUN pip3 install prisma

COPY schema.prisma schema.prisma

# Generate Prisma client
RUN prisma generate


# Expose the port Prisma Studio uses
EXPOSE 5555

# Start Prisma Studio
CMD ["prisma", "studio", "--port", "5555","--schema", "schema.prisma"]
