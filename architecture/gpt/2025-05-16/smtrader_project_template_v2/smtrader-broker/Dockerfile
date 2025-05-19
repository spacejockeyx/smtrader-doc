FROM python:3.10-slim

# Install necessary system dependencies (adjust as needed)
RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*

# Copy IBKR Gateway installation (assume you add it here)
COPY ibgateway /opt/ibkr/ibgateway

# Copy API code
COPY api /app/api
COPY scripts /scripts

WORKDIR /app/api

RUN pip install fastapi uvicorn

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

