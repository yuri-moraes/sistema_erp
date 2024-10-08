# Use uma imagem base do Python
FROM python:3.12-slim

# Atualize e instale dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libmariadb-dev \
    libpq-dev \
    pkg-config \
    && apt-get clean

# Configure a variável de ambiente PATH para o virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Crie e ative um virtual environment
RUN python -m venv --copies /opt/venv && . /opt/venv/bin/activate

# Copie os arquivos do projeto para o diretório /app
COPY . /app

# Defina o diretório de trabalho
WORKDIR /app

# Instale as dependências do projeto
RUN pip install --upgrade pip && pip install -r requirements.txt

# Exponha a porta que será usada pela aplicação
EXPOSE 8000

# Comando padrão para iniciar o servidor da aplicação
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]
