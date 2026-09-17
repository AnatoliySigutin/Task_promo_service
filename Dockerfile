FROM python:3.12

WORKDIR /app

RUN apt-get update && apt-get install -y gcc libpq-dev && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml poetry.lock* ./

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1

RUN pip install poetry

RUN poetry install --only main --no-interaction --no-ansi

COPY . .

ENV PATH="/app/venv/bin:$PATH"

CMD ["python", "manage.py", "runserver", "0.0.0.0:8002"]
