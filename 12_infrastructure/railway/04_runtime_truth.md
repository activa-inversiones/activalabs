# 04 Runtime Truth

## activa-sales-os

- package.json:
  - start = node src/server.js
- railway.json presente
- usa express + pg
- requiere DATABASE_URL

## whatsapp-ia-hubspot

- package.json:
  - start = node index.js
- railway.json presente
- usa express + openai + zoho
- existe archivo services/salesOsBridge.js
- hallazgo importante:
  - el bridge a Sales OS existe en el repo
  - pero actualmente no se observa integrado al flujo principal de index.js
  - esto se debe corregir en la ModificaciÃ³n 2

## unified-cxm-ads-flow

- package.json:
  - start = node index.js
- servicio Node.js pÃºblico

## motor-permisos-araucania

- Python principal:
  - permisos_edificacion_vigentes.py
- Node auxiliar:
  - index.js
- requirements.txt presente
- Dockerfile presente
- debe seguir como worker interno en esta etapa
