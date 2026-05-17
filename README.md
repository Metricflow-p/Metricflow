# MetricFlow — Tu e-commerce analizado en segundos

Herramienta SaaS que analiza datos de ventas de e-commerce y genera informes ejecutivos con inteligencia artificial.

---

## Guía de despliegue paso a paso

### Paso 1: Crear cuentas (5 minutos)

Necesitas crear cuentas gratuitas en estos servicios:

**GitHub** — para alojar tu código
→ https://github.com/signup

**Vercel** — para desplegar la web (gratis hasta 100GB de ancho de banda)
→ https://vercel.com/signup (usa tu cuenta de GitHub)

**Supabase** — para la base de datos y recoger emails (gratis hasta 50.000 filas)
→ https://supabase.com (crea un nuevo proyecto, elige región EU West)

**Anthropic** — para la API de IA que genera los informes
→ https://console.anthropic.com (necesitarás añadir créditos, ~$5 para empezar)


### Paso 2: Configurar Supabase (5 minutos)

1. Entra en tu proyecto de Supabase
2. Ve a **SQL Editor** en el menú lateral
3. Copia todo el contenido del archivo `supabase-setup.sql` y pégalo
4. Pulsa **Run** — esto crea las tablas `waitlist` y `events`
5. Ve a **Settings > API** y copia:
   - `Project URL` → será tu VITE_SUPABASE_URL
   - `anon public` key → será tu VITE_SUPABASE_ANON_KEY


### Paso 3: Subir el código a GitHub (5 minutos)

1. Crea un nuevo repositorio en GitHub llamado `metricflow`
2. En tu terminal:

```bash
cd metricflow
git init
git add .
git commit -m "Initial commit - MetricFlow v1.0"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/metricflow.git
git push -u origin main
```


### Paso 4: Desplegar en Vercel (3 minutos)

1. Entra en https://vercel.com/new
2. Importa tu repositorio `metricflow` de GitHub
3. En **Environment Variables** añade:
   - `VITE_SUPABASE_URL` = (tu URL de Supabase)
   - `VITE_SUPABASE_ANON_KEY` = (tu anon key)
   - `VITE_ANTHROPIC_API_KEY` = (tu API key de Anthropic)
4. Pulsa **Deploy**
5. En 1-2 minutos tendrás tu web en `metricflow.vercel.app`


### Paso 5: Conectar dominio propio (5 minutos)

1. Compra un dominio en https://namecheap.com o https://porkbun.com
   - Sugerencias: metricflow.es, metricflow.io, getmetricflow.com
2. En Vercel > Settings > Domains, añade tu dominio
3. Vercel te dará registros DNS que configurar en tu registrador
4. Espera 5-30 minutos para la propagación DNS
5. HTTPS se configura automáticamente


### Paso 6: Verificar que todo funciona

1. Abre tu dominio en el navegador
2. Comprueba que la landing carga correctamente
3. Introduce un email en el formulario de waitlist
4. Ve a Supabase > Table Editor > waitlist y confirma que el email aparece
5. Entra en /app y prueba el análisis con datos demo
6. Pulsa "Generar informe IA" y confirma que funciona


---

## Estructura del proyecto

```
metricflow/
├── index.html              ← HTML principal
├── package.json            ← Dependencias
├── vite.config.js          ← Config de Vite
├── vercel.json             ← Config de Vercel (SPA routing)
├── supabase-setup.sql      ← SQL para crear tablas
├── .env.example            ← Plantilla de variables de entorno
├── .gitignore
├── src/
│   ├── main.jsx            ← Punto de entrada
│   ├── App.jsx             ← Router principal
│   ├── styles/
│   │   └── global.css      ← Estilos globales + animaciones
│   ├── components/
│   │   └── UI.jsx          ← Componentes reutilizables (KPI, Chart, etc.)
│   ├── pages/
│   │   ├── Landing.jsx     ← Landing page con waitlist
│   │   └── Dashboard.jsx   ← App de analytics
│   └── utils/
│       ├── supabase.js     ← Cliente Supabase (emails + events)
│       ├── analytics.js    ← Motor de procesamiento de datos
│       └── ai.js           ← Generación de informes con IA
```


---

## Costes mensuales estimados

| Servicio | Plan | Coste |
|----------|------|-------|
| Vercel | Hobby (gratis) | €0 |
| Supabase | Free tier | €0 |
| Anthropic API | ~100 informes/mes | ~€3-5 |
| Dominio | .es o .com | ~€1/mes |
| **TOTAL** | | **~€4-6/mes** |

Con los primeros 10 clientes a €19/mes ya estarías facturando €190/mes con costes de €6.


---

## Próximas funcionalidades (roadmap)

### Fase 2 — Autenticación y pagos
- Login con Google/email (Supabase Auth)
- Pasarela de pago con Stripe
- Límites por plan (1 análisis gratis, ilimitados en Pro)

### Fase 3 — Integraciones
- Conexión directa con Shopify API
- Conexión con WooCommerce REST API
- Import desde Amazon Seller Central

### Fase 4 — Automatización
- Reportes automáticos semanales por email (Resend + cron)
- Alertas cuando una métrica cambie significativamente
- Comparativas mes vs mes automáticas

### Fase 5 — Crecimiento
- Blog con SEO (Next.js o Astro)
- Programa de referidos
- API pública para agencias


---

## Comandos útiles

```bash
# Instalar dependencias
npm install

# Desarrollo local
npm run dev

# Build de producción
npm run build

# Preview del build
npm run preview
```


---

## Soporte

Si tienes dudas sobre el despliegue o quieres añadir funcionalidades,
vuelve a Claude con el contexto de este proyecto y continúa desde donde lo dejaste.
