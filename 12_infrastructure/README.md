# 12_infrastructure

Infraestructura maestra de ACTIVALABS para producciÃ³n real.

## PropÃ³sito

Este directorio concentra la verdad tÃ©cnica de despliegue y operaciÃ³n para evitar retrabajo:

- mapa de servicios Railway
- dominios y exposiciÃ³n pÃºblica
- entrypoints reales por repositorio
- variables ejemplo por servicio
- orden de despliegue
- runbooks de preproducciÃ³n, go-live y rollback

## Regla de gobierno

- GitHub = verdad tÃ©cnica
- Railway = ejecuciÃ³n
- Zoho = operaciÃ³n comercial
- WordPress (activaspa.cl) = frente comercial actual

## Repos actuales observados

- activa-sales-os
- whatsapp-ia-hubspot
- unified-cxm-ads-flow
- motor-permisos-araucania

## Principios

- no romper producciÃ³n actual
- no rehacer lo que ya funciona
- respetar mezcla real Node.js + Python
- mantener trazabilidad auditable
