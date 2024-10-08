FROM python:3.12-slim

# Atualizar e instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && apt-get clean

# Configurar ambiente virtual Python
RUN python -m venv --copies /opt/venv

# Definir variáveis de ambiente necessárias
ENV PATH="/opt/venv/bin:$PATH"

# Definir o diretório de trabalho
WORKDIR /app

# Copiar os arquivos do projeto
COPY . /app

# Instalar dependências do projeto
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expor a porta que a aplicação irá usar
EXPOSE 8000

# Comando para rodar o servidor
CMD ["gunicorn", "core.wsgi:application"]
