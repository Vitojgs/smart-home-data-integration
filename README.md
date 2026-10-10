# Integração e Processamento de Dados IoT para Monitorização de uma Smart Home

TP1 — Integração de Sistemas de Informação (ISI), LESI, UPCA 2026/27.

Pipeline ETL que integra sensores Smart Home (MQTT), meteorologia externa (API REST),
histórico (CSV) e metadados (YAML), com transformação em KNIME, persistência em PostgreSQL
e visualização em Grafana.

Narrativa: `interior vs exterior (Barcelos) vs histórico → decisão (ventilar / alertar consumo)`.

## Stack

* Node-RED 5.0.7 — simulação dos sensores IoT
* Mosquitto 2.0 (Docker) — broker MQTT `:1883`
* Open-Meteo REST/JSON — meteorologia Barcelos (41.5275, -8.6157)
* KNIME 5.12.0 — ETL principal (`smart_home_etl` + `smart_home_job`)
* PostgreSQL 18.6 (nativo) — BD `smarthome`
* Grafana (Docker) — dashboard `:3000`
* Docker 29.8.0 Desktop

## Estrutura

```text
docker-compose.yml        # mosquitto + grafana
mosquitto/config/         # mosquitto.conf versionado
docs/                     # relatório, diagramas, screenshots
sql/                      # schema.sql (a criar)
data/                     # sensors.yaml, history_readings.csv, api_sample.json (a criar)
node-red/                 # flows.json (a criar)
knime/                    # workflows exportados (a criar)
exports/                  # CSV/JSON/XML/Parquet/SQL gerados
logs/                     # logs do Job
grafana/                  # dashboard.json
```

## Como correr (infra base)

```powershell
docker compose up -d
docker ps
Test-NetConnection localhost -Port 1883
Test-NetConnection localhost -Port 3000
```

* Grafana: http://localhost:3000 (admin/admin)
* MQTT: localhost:1883
* PostgreSQL nativo: localhost:5432 — Grafana liga via `host.docker.internal:5432`

## Estado

Infra base validada: Mosquitto UP, Grafana UP, PostgreSQL, Node-RED e KNIME instalados.
Já criados `sql/schema.sql`, `data/sensors.yaml` + CSV histórico, flow Node-RED. Por criar workflow KNIME, dashboard.
