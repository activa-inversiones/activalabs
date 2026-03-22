# 03 Deploy Order

## Orden correcto de despliegue

1. Postgres
2. activa-sales-os
3. whatsapp-ia-hubspot
4. unified-cxm-ads-flow
5. motor-permisos-araucania

## JustificaciÃ³n

- Sales OS debe estar arriba antes de takeover y eventos conversacionales.
- WhatsApp IA depende del plano operativo para trazabilidad completa.
- Unified CXM puede entrar despuÃ©s sin bloquear la conversaciÃ³n comercial.
- motor-permisos no es ruta crÃ­tica para ventas de hoy.

## Orden de validaciÃ³n

1. /health de activa-sales-os
2. /health de whatsapp-ia-hubspot
3. /health de unified-cxm-ads-flow
4. prueba de conversaciÃ³n real en WhatsApp
5. prueba de registro en Zoho CRM
6. prueba de takeover humano
