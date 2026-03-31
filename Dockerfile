FROM python:3.12-slim AS build
WORKDIR /app
COPY Chat2Me/requirements.txt .
RUN pip install --prefix=/install --no-cache-dir -r requirements.txt
COPY Chat2Me/ .

FROM python:3.12-slim
RUN useradd -m appuser
WORKDIR /app
COPY --from=build /install /usr/local
COPY --from=build /app /app

USER appuser
EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]