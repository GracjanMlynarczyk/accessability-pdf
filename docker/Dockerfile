FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /src

# 🧱 Systemowe zależności potrzebne przez WeasyPrint
RUN apt-get update && apt-get install -y \
    build-essential \
    libcairo2 \
    libpango-1.0-0 \
    libpangoft2-1.0-0 \
    libgdk-pixbuf2.0-0 \
    libffi-dev \
    libxml2 \
    libxslt1.1 \
    shared-mime-info \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# 📦 Instalacja zależności Pythona
COPY ../src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 📁 Kopiowanie aplikacji
COPY ../src /src/

# 🚀 Start aplikacji
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]