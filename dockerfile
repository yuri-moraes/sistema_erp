FROM python:3.12-slim

# Atualizar e instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && apt-get clean

# Configurar ambiente virtual Python
RUN python -m venv /opt/venv

# Definir variáveis de ambiente necessárias
ENV VIRTUAL_ENV="/opt/venv"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Definir o diretório de trabalho
WORKDIR /app

# Copiar os arquivos do projeto
COPY . /app

# Instalar dependências do projeto
RUN pip install --upgrade pip && pip install -r requirements.txt

# Adicionar um usuário não root
RUN adduser --disabled-password appuser
USER appuser

# Expor a porta que a aplicação irá usar
EXPOSE 8000

# Comando para rodar o servidor
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:${PORT}"]
