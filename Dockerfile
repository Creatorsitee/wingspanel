FROM ubuntu:22.04

# Install semua kebutuhan dasar
RUN apt-get update && apt-get install -y \
    curl sudo bash git python3 nodejs npm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy script eksekusi otomatis
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Port 3000 (Panel) & Port 8080/2022 (Wings)
EXPOSE 3000 3002 2022

CMD ["./entrypoint.sh"]
