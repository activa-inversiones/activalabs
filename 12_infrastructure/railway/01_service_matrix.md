# 01 Service Matrix

| Servicio Railway | Repo GitHub | Runtime real | Entrypoint real | ExposiciÃ³n | Dominio recomendado | Rol |
|---|---|---|---|---|---|---|
| Postgres | Railway managed | Managed DB | N/A | Interno | N/A | Persistencia central |
| activa-sales-os | activa-sales-os | Node.js | src/server.js | Interno protegido | ops.activalabs.ai | Dashboard, takeover, ingest, trazabilidad |
| whatsapp-ia-hubspot | whatsapp-ia-hubspot | Node.js | index.js | PÃºblico | wa.activalabs.ai | WhatsApp API, IA, cotizaciÃ³n, takeover |
| unified-cxm-ads-flow | unified-cxm-ads-flow | Node.js | index.js | PÃºblico | hooks.activalabs.ai | Webhooks ads / formularios / eventos |
| motor-permisos-araucania | motor-permisos-araucania | Python principal + Node auxiliar | permisos_edificacion_vigentes.py | Interno / worker | sin dominio pÃºblico | Radar de permisos / leads tÃ©cnicos |

## Decisiones

- Node.js se mantiene para servicios pÃºblicos.
- Python se mantiene para procesos de extracciÃ³n y worker.
- motor-permisos-araucania no se publica como endpoint pÃºblico en esta fase.
- no se fusionan repos en esta etapa.
