# Baseando-se em uma imagem Python slim
FROM python:3.12-slim

# Atualize e instale dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libmariadb-dev \
    pkg-config \
    && apt-get clean

# Crie e ative um ambiente virtual
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copie o código da aplicação para o container
COPY . /app

# Defina o diretório de trabalho
WORKDIR /app

# Instale as dependências do projeto
RUN pip install --upgrade pip && pip install -r requirements.txt

# Exponha a porta que será usada pela aplicação
EXPOSE 8000

# Execute o servidor da aplicação (ajuste o comando conforme necessário)
CMD ["gunicorn", "-b", "0.0.0.0:8000", "core.wsgi:application"]
