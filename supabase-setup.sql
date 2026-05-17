-- ══════════════════════════════════════════════════════════
-- MetricFlow — Supabase Database Setup
-- Ejecuta esto en el SQL Editor de tu proyecto Supabase
-- ══════════════════════════════════════════════════════════

-- ── Tabla: waitlist (lista de espera) ────────────────────
CREATE TABLE IF NOT EXISTS waitlist (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  signed_up_at TIMESTAMPTZ DEFAULT NOW(),
  source TEXT,
  converted BOOLEAN DEFAULT FALSE,
  notes TEXT
);

-- Índice para búsquedas rápidas por email
CREATE INDEX IF NOT EXISTS idx_waitlist_email ON waitlist(email);

-- Habilitar Row Level Security
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- Política: permitir inserts desde el frontend (anon key)
CREATE POLICY "Allow anonymous inserts" ON waitlist
  FOR INSERT TO anon
  WITH CHECK (true);

-- Política: solo lectura para usuarios autenticados (tu panel admin)
CREATE POLICY "Allow authenticated reads" ON waitlist
  FOR SELECT TO authenticated
  USING (true);


-- ── Tabla: events (analytics básicos) ────────────────────
CREATE TABLE IF NOT EXISTS events (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  event TEXT NOT NULL,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Habilitar RLS
ALTER TABLE events ENABLE ROW LEVEL SECURITY;

-- Política: permitir inserts anónimos
CREATE POLICY "Allow anonymous event inserts" ON events
  FOR INSERT TO anon
  WITH CHECK (true);

-- Política: lectura solo autenticada
CREATE POLICY "Allow authenticated event reads" ON events
  FOR SELECT TO authenticated
  USING (true);


-- ── Vista: resumen de waitlist ───────────────────────────
CREATE OR REPLACE VIEW waitlist_summary AS
SELECT
  COUNT(*) AS total_signups,
  COUNT(*) FILTER (WHERE signed_up_at > NOW() - INTERVAL '7 days') AS last_7_days,
  COUNT(*) FILTER (WHERE signed_up_at > NOW() - INTERVAL '24 hours') AS last_24h,
  COUNT(*) FILTER (WHERE converted = true) AS converted
FROM waitlist;


-- ── Vista: eventos por día ───────────────────────────────
CREATE OR REPLACE VIEW events_daily AS
SELECT
  DATE(created_at) AS fecha,
  event,
  COUNT(*) AS total
FROM events
GROUP BY DATE(created_at), event
ORDER BY fecha DESC;
