FROM --platform=$BUILDPLATFORM python:3.8 as builder

WORKDIR /install

RUN apt-get update && apt-get install -y rustc

COPY requirements.txt /requirements.txt
RUN pip install --prefix=/install -r /requirements.txt && pip uninstall werkzeug -y && pip install pip install -v https://github.com/pallets/werkzeug/archive/refs/tags/2.0.3.tar.gz

FROM python:3.8-slim

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

CMD ["python", "-m", "binance_trade_bot"]
