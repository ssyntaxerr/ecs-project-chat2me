# BUILD
FROM python:3.12-slim AS build

WORKDIR /app

# Install dependencies
COPY Chat2Me/requirements.txt .

RUN pip install --prefix=/install --no-cache-dir -r requirements.txt

# Copy application source
COPY Chat2Me/ .


# RUNTIME
FROM python:3.12-slim

# Create non-root user
RUN useradd -m appuser

WORKDIR /app

# Copy installed dependencies from build
COPY --from=build /install /usr/local

# Copy application code
COPY --from=build /app /app

# Switch to non-root user
USER appuser

# Expose application port
EXPOSE 8000

# Run the app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]