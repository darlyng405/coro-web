#!/usr/bin/env bash
set -e

mkdir -p src/components src/pages

# ==================== COMPONENTES ====================

# ---------- Header (versión correcta con logotipo.svg) ----------
cat > src/components/Header.astro <<'ASTRO_EOF'
---
import { SITE } from '@/data/site';

const navItems = [
  { href: '#que-es', label: 'Qué es' },
  { href: '#como-funciona', label: 'Cómo funciona' },
  { href: '#ods', label: 'ODS' },
  { href: '#equipo', label: 'Equipo' },
  { href: '#descargar', label: 'Descargar' },
];
---

<header class="header" id="header">
  <div class="container header__inner">
    <a href="/" class="header__brand" aria-label="CORO — Inicio">
      <img src="/logotipo.svg" alt="CORO" width="140" height="40" />
    </a>

    <nav class="header__nav" aria-label="Navegación principal">
      <ul>
        {navItems.map(item => (
          <li><a href={item.href}>{item.label}</a></li>
        ))}
      </ul>
    </nav>

    <div class="header__actions">
      <a href="#descargar" class="btn btn--primary header__cta">Descargar app</a>
      <button class="header__menu" aria-label="Abrir menú" aria-expanded="false" id="menu-toggle">
        <span></span><span></span><span></span>
      </button>
    </div>
  </div>

  <div class="header__mobile" id="mobile-menu" hidden>
    <nav aria-label="Navegación móvil">
      <ul>
        {navItems.map(item => (
          <li><a href={item.href}>{item.label}</a></li>
        ))}
      </ul>
      <a href="#descargar" class="btn btn--primary">Descargar app</a>
    </nav>
  </div>
</header>

<style>
  .header {
    position: sticky;
    top: 0;
    z-index: 100;
    background: rgba(250, 247, 242, 0.85);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-bottom: 1px solid transparent;
    transition: border-color 0.2s ease, background 0.2s ease;
  }
  .header--scrolled { border-bottom-color: var(--border); }
  .header__inner {
    height: var(--header-h);
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: var(--sp-5);
  }
  .header__brand { display: flex; align-items: center; flex-shrink: 0; }
  .header__brand img { height: 36px; width: auto; }
  .header__nav ul { display: flex; gap: var(--sp-5); align-items: center; }
  .header__nav a {
    font-size: var(--fs-sm);
    font-weight: 600;
    color: var(--ink-soft);
    padding: var(--sp-2) 0;
    position: relative;
  }
  .header__nav a:hover { color: var(--navy); }
  .header__nav a::after {
    content: '';
    position: absolute;
    left: 0; right: 0; bottom: -2px;
    height: 2px;
    background: var(--teal);
    transform: scaleX(0);
    transform-origin: left;
    transition: transform 0.2s ease;
  }
  .header__nav a:hover::after { transform: scaleX(1); }
  .header__actions { display: flex; align-items: center; gap: var(--sp-3); }
  .header__cta { padding: 10px 20px; font-size: var(--fs-sm); }
  .header__menu {
    display: none;
    background: none;
    border: none;
    padding: var(--sp-2);
    cursor: pointer;
    flex-direction: column;
    gap: 5px;
    width: 40px; height: 40px;
    align-items: center;
    justify-content: center;
    border-radius: var(--radius-sm);
  }
  .header__menu span {
    display: block;
    width: 22px; height: 2px;
    background: var(--navy);
    border-radius: 2px;
    transition: transform 0.2s ease, opacity 0.2s ease;
  }
  .header__menu[aria-expanded="true"] span:nth-child(1) { transform: translateY(7px) rotate(45deg); }
  .header__menu[aria-expanded="true"] span:nth-child(2) { opacity: 0; }
  .header__menu[aria-expanded="true"] span:nth-child(3) { transform: translateY(-7px) rotate(-45deg); }
  .header__mobile {
    padding: var(--sp-4) var(--sp-5) var(--sp-5);
    border-top: 1px solid var(--border);
    background: var(--cream);
  }
  .header__mobile ul { display: flex; flex-direction: column; gap: var(--sp-2); margin-bottom: var(--sp-4); }
  .header__mobile a {
    display: block;
    padding: var(--sp-3) var(--sp-2);
    font-weight: 600;
    color: var(--ink-soft);
    border-radius: var(--radius-sm);
  }
  .header__mobile a:hover { background: var(--paper); color: var(--navy); }
  .header__mobile .btn { width: 100%; }
  @media (max-width: 900px) {
    .header__nav, .header__cta { display: none; }
    .header__menu { display: flex; }
  }
</style>

<script>
  const header = document.getElementById('header');
  const toggle = document.getElementById('menu-toggle');
  const mobileMenu = document.getElementById('mobile-menu');

  const onScroll = () => {
    if (window.scrollY > 8) header?.classList.add('header--scrolled');
    else header?.classList.remove('header--scrolled');
  };
  onScroll();
  window.addEventListener('scroll', onScroll, { passive: true });

  toggle?.addEventListener('click', () => {
    const isOpen = toggle.getAttribute('aria-expanded') === 'true';
    toggle.setAttribute('aria-expanded', String(!isOpen));
    if (mobileMenu) mobileMenu.hidden = isOpen;
  });

  mobileMenu?.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
      toggle?.setAttribute('aria-expanded', 'false');
      if (mobileMenu) mobileMenu.hidden = true;
    });
  });
</script>
ASTRO_EOF

# ---------- Hero ----------
cat > src/components/Hero.astro <<'ASTRO_EOF'
---
import Button from './Button.astro';
---

<section class="hero">
  <div class="hero__bg" aria-hidden="true">
    <div class="hero__blob hero__blob--1"></div>
    <div class="hero__blob hero__blob--2"></div>
  </div>

  <div class="container hero__inner">
    <span class="chip hero__chip">
      <span class="hero__dot" aria-hidden="true"></span>
      Participación ciudadana juvenil · RD
    </span>

    <h1 class="hero__title">
      Que tu voz sea escuchada.<br />
      <span class="hero__title-accent">Con un buen CORO podemos cambiar el país.</span>
    </h1>

    <p class="hero__lead">
      CORO conecta jóvenes, comunidades e instituciones para que cada problema
      del barrio tenga respuesta verificable, con evidencia y trazabilidad pública.
    </p>

    <div class="hero__actions">
      <Button href="#descargar" variant="primary" size="lg">Descargar la app</Button>
      <Button href="#que-es" variant="ghost" size="lg">Conocer CORO →</Button>
    </div>

    <ul class="hero__features">
      <li>✓ Funciona sin conexión</li>
      <li>✓ Trazabilidad de cada caso</li>
      <li>✓ Gratis para las personas</li>
    </ul>
  </div>
</section>

<style>
  .hero {
    position: relative;
    padding: var(--sp-9) 0 var(--sp-10);
    overflow: hidden;
    isolation: isolate;
  }
  .hero__bg { position: absolute; inset: 0; z-index: -1; pointer-events: none; }
  .hero__blob { position: absolute; border-radius: 50%; filter: blur(80px); opacity: 0.4; }
  .hero__blob--1 { width: 520px; height: 520px; background: var(--teal); top: -180px; right: -120px; }
  .hero__blob--2 { width: 420px; height: 420px; background: var(--orange); bottom: -200px; left: -100px; opacity: 0.28; }
  .hero__inner { max-width: 780px; }
  .hero__chip {
    background: var(--paper);
    border: 1px solid var(--border);
    color: var(--ink-soft);
    margin-bottom: var(--sp-5);
    font-weight: 600;
  }
  .hero__dot {
    display: inline-block;
    width: 8px; height: 8px;
    border-radius: 50%;
    background: var(--teal);
    box-shadow: 0 0 0 3px rgba(46, 159, 182, 0.2);
    animation: pulse 2s ease-in-out infinite;
  }
  @keyframes pulse {
    0%, 100% { box-shadow: 0 0 0 3px rgba(46, 159, 182, 0.2); }
    50%      { box-shadow: 0 0 0 6px rgba(46, 159, 182, 0.08); }
  }
  .hero__title {
    font-size: var(--fs-4xl);
    line-height: 1.08;
    margin-bottom: var(--sp-5);
    letter-spacing: -0.035em;
  }
  .hero__title-accent {
    background: linear-gradient(120deg, var(--teal) 0%, var(--navy) 60%);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
  }
  .hero__lead {
    font-size: var(--fs-lg);
    color: var(--muted);
    max-width: 60ch;
    margin-bottom: var(--sp-6);
    line-height: 1.55;
  }
  .hero__actions { display: flex; gap: var(--sp-3); flex-wrap: wrap; margin-bottom: var(--sp-7); }
  .hero__features {
    display: flex;
    gap: var(--sp-5);
    flex-wrap: wrap;
    font-size: var(--fs-sm);
    font-weight: 600;
    color: var(--muted);
  }
  .hero__features li { display: flex; align-items: center; gap: var(--sp-2); }
  @media (max-width: 640px) {
    .hero { padding: var(--sp-7) 0 var(--sp-8); }
    .hero__actions { flex-direction: column; }
    .hero__actions :global(.btn) { width: 100%; }
    .hero__features { gap: var(--sp-3); }
  }
</style>
ASTRO_EOF

# ---------- Problem ----------
cat > src/components/Problem.astro <<'ASTRO_EOF'
---
---

<section class="problem">
  <div class="container">
    <div class="problem__intro">
      <span class="section__eyebrow">El problema</span>
      <h2 class="problem__title">
        No es apatía. Es falta de espacios donde la voz joven se convierta en acción.
      </h2>
    </div>

    <div class="problem__stats">
      <article class="stat">
        <span class="stat__number">70<span class="stat__unit">%</span></span>
        <p class="stat__text">
          de los jóvenes dominicanos considera la política
          <strong>poco o nada importante</strong>.
        </p>
        <span class="stat__source">IDEICE, Encuesta de Juventud (2022)</span>
      </article>

      <article class="stat">
        <span class="stat__number">4.7<span class="stat__unit">%</span></span>
        <p class="stat__text">
          de los parlamentarios en América Latina tiene
          <strong>menos de 30 años</strong>.
        </p>
        <span class="stat__source">PNUD (2024)</span>
      </article>

      <article class="stat">
        <span class="stat__number">75.7<span class="stat__unit">%</span></span>
        <p class="stat__text">
          de los jóvenes cree que su país es gobernado por
          <strong>grupos que responden a sus propios intereses</strong>.
        </p>
        <span class="stat__source">PNUD (2024)</span>
      </article>
    </div>

    <p class="problem__closing">
      CORO no parte de que a los jóvenes "no les importe nada".
      Parte de que <strong>faltan herramientas útiles, trazables y accesibles</strong>
      donde la participación se convierta en colaboración, propuestas y acciones medibles.
    </p>
  </div>
</section>

<style>
  .problem {
    background: var(--navy);
    color: rgba(255, 255, 255, 0.85);
    padding: var(--sp-9) 0;
    position: relative;
    overflow: hidden;
  }
  .problem::before {
    content: '';
    position: absolute;
    inset: 0;
    background: radial-gradient(circle at 20% 0%, rgba(46, 159, 182, 0.25), transparent 55%);
    pointer-events: none;
  }
  .problem :global(.section__eyebrow) { color: var(--orange); }
  .problem__intro { max-width: 780px; margin-bottom: var(--sp-8); position: relative; }
  .problem__title { color: white; font-size: var(--fs-3xl); line-height: 1.15; margin-top: var(--sp-2); }
  .problem__stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: var(--sp-5);
    margin-bottom: var(--sp-7);
    position: relative;
  }
  .stat {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: var(--radius-lg);
    padding: var(--sp-6);
    backdrop-filter: blur(8px);
  }
  .stat__number {
    display: block;
    font-family: var(--font-display);
    font-size: clamp(2.5rem, 1.5rem + 3.5vw, 4rem);
    font-weight: 800;
    line-height: 1;
    color: var(--orange);
    margin-bottom: var(--sp-4);
    letter-spacing: -0.03em;
  }
  .stat__unit { font-size: 0.5em; color: var(--teal); margin-left: 2px; }
  .stat__text {
    color: rgba(255, 255, 255, 0.85);
    font-size: var(--fs-base);
    line-height: 1.5;
    margin-bottom: var(--sp-3);
  }
  .stat__text strong { color: white; }
  .stat__source {
    display: block;
    font-size: var(--fs-xs);
    color: rgba(255, 255, 255, 0.5);
    font-style: italic;
  }
  .problem__closing {
    max-width: 780px;
    font-size: var(--fs-lg);
    line-height: 1.55;
    color: rgba(255, 255, 255, 0.85);
    padding-top: var(--sp-6);
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    position: relative;
  }
  .problem__closing strong { color: var(--orange); }
</style>
ASTRO_EOF

# ---------- WhatIsCoro ----------
cat > src/components/WhatIsCoro.astro <<'ASTRO_EOF'
---
import Section from './Section.astro';

const pillars = [
  { icon: '💬', title: 'Debatir', text: 'Foros por tema, sin ruido ni algoritmos que premien la polémica.' },
  { icon: '📸', title: 'Documentar', text: 'Reportajes y evidencias de lo que pasa en tu comunidad.' },
  { icon: '💡', title: 'Proponer', text: 'Propuestas ciudadanas colaborativas con seguimiento real.' },
  { icon: '🤝', title: 'Conectar', text: 'Organizaciones verificadas que ofrecen oportunidades concretas.' },
];
---

<Section
  id="que-es"
  eyebrow="Qué es CORO"
  title="Cuatro espacios, un solo propósito: que la participación joven tenga consecuencias reales."
  lead="CORO reúne todo lo que normalmente está disperso: conversación, documentación, propuestas y conexión con organizaciones."
>
  <div class="grid grid--4 pillars">
    {pillars.map((p, i) => (
      <article class="card card--hover pillar">
        <span class="pillar__icon" aria-hidden="true">{p.icon}</span>
        <span class="pillar__number">0{i + 1}</span>
        <h3 class="pillar__title">{p.title}</h3>
        <p class="pillar__text">{p.text}</p>
      </article>
    ))}
  </div>

  <div class="trazabilidad">
    <div class="trazabilidad__icon" aria-hidden="true">🎯</div>
    <div>
      <h3 class="trazabilidad__title">Y una capa que hace la diferencia: trazabilidad</h3>
      <p class="trazabilidad__text">
        Cada incidente tiene un <strong>protocolo público</strong> (por ejemplo
        <code>CR-2026-000041</code>) que cualquiera puede consultar para ver su estado,
        su historial y la evidencia del antes y el después.
      </p>
    </div>
  </div>
</Section>

<style>
  .pillars { margin-bottom: var(--sp-7); }
  .pillar { position: relative; overflow: hidden; }
  .pillar__icon {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 52px; height: 52px;
    font-size: 26px;
    background: var(--teal-soft);
    border-radius: var(--radius);
    margin-bottom: var(--sp-4);
  }
  .pillar__number {
    position: absolute;
    top: var(--sp-4); right: var(--sp-5);
    font-family: var(--font-display);
    font-size: var(--fs-2xl);
    font-weight: 800;
    color: var(--border);
    letter-spacing: -0.03em;
    line-height: 1;
  }
  .pillar__title { font-size: var(--fs-xl); margin-bottom: var(--sp-2); }
  .pillar__text { color: var(--muted); line-height: 1.5; }
  .trazabilidad {
    display: flex;
    gap: var(--sp-5);
    align-items: flex-start;
    background: linear-gradient(135deg, var(--teal-soft) 0%, var(--paper) 100%);
    border: 1px solid var(--border-soft);
    border-radius: var(--radius-lg);
    padding: var(--sp-6);
  }
  .trazabilidad__icon { flex-shrink: 0; font-size: 36px; line-height: 1; }
  .trazabilidad__title { font-size: var(--fs-lg); margin-bottom: var(--sp-2); }
  .trazabilidad__text { color: var(--ink-soft); line-height: 1.55; }
  .trazabilidad__text code {
    font-family: ui-monospace, SFMono-Regular, monospace;
    background: var(--navy);
    color: var(--orange);
    padding: 2px 8px;
    border-radius: var(--radius-sm);
    font-size: 0.9em;
    font-weight: 600;
  }
  @media (max-width: 640px) { .trazabilidad { flex-direction: column; } }
</style>
ASTRO_EOF

# ---------- HowItWorks ----------
cat > src/components/HowItWorks.astro <<'ASTRO_EOF'
---
import Section from './Section.astro';

const steps = [
  { n: '01', icon: '📱', title: 'Reportas el problema', text: 'Foto, ubicación y descripción. La app te avisa si ya existe un caso igual cerca para sumarte.' },
  { n: '02', icon: '🏛️', title: 'La institución lo revisa', text: 'Un gestor analiza el caso, define prioridad y lo asigna a la brigada correspondiente.' },
  { n: '03', icon: '🚛', title: 'Una brigada lo atiende', text: 'El equipo trabaja en campo con CORO Campo, incluso sin conexión. Todo se sincroniza después.' },
  { n: '04', icon: '✅', title: 'Se resuelve con evidencia', text: 'La institución valida con fotos del antes y el después. Toda la comunidad lo ve.' },
];
---

<Section
  id="como-funciona"
  eyebrow="Cómo funciona"
  title="Del reporte a la solución, con trazabilidad en cada paso."
  lead="Un ciclo simple que convierte una queja aislada en un caso público con seguimiento, responsable y evidencia."
  alt
>
  <div class="steps">
    {steps.map((s, i) => (
      <>
        <article class="step">
          <div class="step__badge">{s.n}</div>
          <span class="step__icon" aria-hidden="true">{s.icon}</span>
          <h3 class="step__title">{s.title}</h3>
          <p class="step__text">{s.text}</p>
        </article>
        {i < steps.length - 1 && <div class="step__arrow" aria-hidden="true">→</div>}
      </>
    ))}
  </div>
</Section>

<style>
  .steps { display: grid; grid-template-columns: repeat(4, 1fr); gap: var(--sp-4); align-items: stretch; }
  .step {
    position: relative;
    background: var(--paper);
    border: 1px solid var(--border-soft);
    border-radius: var(--radius-lg);
    padding: var(--sp-5) var(--sp-5) var(--sp-6);
    display: flex;
    flex-direction: column;
    gap: var(--sp-3);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }
  .step:hover { transform: translateY(-4px); box-shadow: var(--shadow); }
  .step__badge {
    position: absolute;
    top: -12px; left: var(--sp-5);
    background: var(--orange);
    color: var(--navy);
    font-family: var(--font-display);
    font-size: var(--fs-sm);
    font-weight: 800;
    padding: 4px 12px;
    border-radius: var(--radius-pill);
    letter-spacing: 0.05em;
  }
  .step__icon { font-size: 34px; line-height: 1; margin-top: var(--sp-3); }
  .step__title { font-size: var(--fs-lg); line-height: 1.25; }
  .step__text { color: var(--muted); font-size: var(--fs-sm); line-height: 1.55; }
  .step__arrow { display: none; }
  @media (max-width: 980px) { .steps { grid-template-columns: repeat(2, 1fr); } }
  @media (max-width: 560px) { .steps { grid-template-columns: 1fr; } }
</style>
ASTRO_EOF

# ---------- SDGSection ----------
cat > src/components/SDGSection.astro <<'ASTRO_EOF'
---
import Section from './Section.astro';
import { SDGS } from '@/data/sdgs';
---

<Section
  id="ods"
  eyebrow="Agenda 2030"
  title="Trabajamos alineados con los Objetivos de Desarrollo Sostenible."
  lead="CORO contribuye directa e indirectamente a cuatro ODS de las Naciones Unidas."
  align="center"
>
  <div class="grid grid--4 sdgs">
    {SDGS.map(sdg => (
      <article class="sdg" style={`--sdg-color: ${sdg.color};`}>
        <div class="sdg__header">
          <span class="sdg__number">{sdg.number}</span>
          <span class="sdg__icon" aria-hidden="true">{sdg.icon}</span>
        </div>
        <h3 class="sdg__name">{sdg.name}</h3>
        <p class="sdg__desc">{sdg.description}</p>
      </article>
    ))}
  </div>

  <p class="sdgs__note">
    Los ODS son una referencia global. CORO trabaja localmente en un municipio piloto
    y crecerá por etapas.
  </p>
</Section>

<style>
  .sdgs { margin-bottom: var(--sp-6); text-align: left; }
  .sdg {
    position: relative;
    background: var(--paper);
    border: 1px solid var(--border-soft);
    border-radius: var(--radius-lg);
    padding: var(--sp-5);
    overflow: hidden;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }
  .sdg::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 4px;
    background: var(--sdg-color);
  }
  .sdg:hover { transform: translateY(-3px); box-shadow: var(--shadow); }
  .sdg__header { display: flex; align-items: center; justify-content: space-between; margin-bottom: var(--sp-4); }
  .sdg__number {
    font-family: var(--font-display);
    font-size: var(--fs-2xl);
    font-weight: 800;
    line-height: 1;
    color: var(--sdg-color);
    letter-spacing: -0.03em;
  }
  .sdg__icon { font-size: 26px; line-height: 1; opacity: 0.85; }
  .sdg__name { font-size: var(--fs-base); font-weight: 700; line-height: 1.3; margin-bottom: var(--sp-3); color: var(--navy); }
  .sdg__desc { color: var(--muted); font-size: var(--fs-sm); line-height: 1.55; }
  .sdgs__note {
    max-width: 640px;
    margin: 0 auto;
    font-size: var(--fs-sm);
    color: var(--muted);
    font-style: italic;
    text-align: center;
  }
</style>
ASTRO_EOF

# ---------- PurposeVision ----------
cat > src/components/PurposeVision.astro <<'ASTRO_EOF'
---
import Section from './Section.astro';

const blocks = [
  { icon: '🎯', label: 'Propósito', title: 'Reducir la apatía política juvenil.', text: 'Crear un puente entre las voces jóvenes y las instituciones que pueden resolver problemas reales. Que la participación no se quede en un like, sino en un caso con seguimiento.', color: 'orange' },
  { icon: '🔭', label: 'Visión', title: 'Que en 2030 cualquier joven pueda reportar y ver respuestas.', text: 'Imaginamos un país donde reportar un bache, una fuga o un foco de basura no sea un grito al vacío, sino el inicio de un proceso claro con responsables identificables.', color: 'teal' },
  { icon: '📐', label: 'Alcance', title: 'Empezamos con un municipio, crecemos por etapas.', text: 'MVP: 1 municipio piloto, 50–200 usuarios, 1,000 incidentes. Fase 2: multi-municipio, iOS, panel institucional. Fase 3: expansión regional en el Caribe hispanohablante.', color: 'navy' },
];
---

<Section
  id="proposito"
  eyebrow="Propósito, visión y alcance"
  title="Lo que buscamos, hacia dónde vamos y hasta dónde llegamos."
  align="center"
>
  <div class="pva">
    {blocks.map(b => (
      <article class={`pva__item pva__item--${b.color}`}>
        <span class="pva__icon" aria-hidden="true">{b.icon}</span>
        <span class="pva__label">{b.label}</span>
        <h3 class="pva__title">{b.title}</h3>
        <p class="pva__text">{b.text}</p>
      </article>
    ))}
  </div>
</Section>

<style>
  .pva { display: grid; grid-template-columns: repeat(3, 1fr); gap: var(--sp-5); text-align: left; }
  .pva__item {
    background: var(--paper);
    border: 1px solid var(--border-soft);
    border-radius: var(--radius-lg);
    padding: var(--sp-6);
    position: relative;
    overflow: hidden;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }
  .pva__item::before {
    content: '';
    position: absolute;
    inset: 0 0 auto 0;
    height: 4px;
    background: var(--accent);
  }
  .pva__item--orange { --accent: var(--orange); }
  .pva__item--teal   { --accent: var(--teal); }
  .pva__item--navy   { --accent: var(--navy); }
  .pva__item:hover { transform: translateY(-3px); box-shadow: var(--shadow); }
  .pva__icon { display: inline-block; font-size: 32px; line-height: 1; margin-bottom: var(--sp-4); }
  .pva__label {
    display: block;
    font-size: var(--fs-xs);
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: var(--muted);
    margin-bottom: var(--sp-2);
  }
  .pva__title { font-size: var(--fs-lg); line-height: 1.25; margin-bottom: var(--sp-3); }
  .pva__text { color: var(--muted); font-size: var(--fs-sm); line-height: 1.6; }
  @media (max-width: 900px) { .pva { grid-template-columns: 1fr; } }
</style>
ASTRO_EOF

# ---------- Team ----------
cat > src/components/Team.astro <<'ASTRO_EOF'
---
import Section from './Section.astro';
import { TEAM } from '@/data/team';
---

<Section
  id="equipo"
  eyebrow="Quiénes somos"
  title="Un equipo pequeño con una idea grande."
  lead="CORO nació de una conversación entre dos jóvenes dominicanos que se cansaron de ver problemas sin respuesta."
  align="center"
  alt
>
  <div class="team">
    {TEAM.map(member => (
      <article class="member">
        <div class="member__photo">
          {member.photo ? (
            <img src={member.photo} alt={`Foto de ${member.name}`} loading="lazy" />
          ) : (
            <div class="member__placeholder" aria-hidden="true">
              {member.name.split(' ').slice(0, 2).map(n => n[0]).join('')}
            </div>
          )}
        </div>
        <h3 class="member__name">{member.name}</h3>
        <p class="member__role">{member.role}</p>
        {member.quote && <p class="member__quote">"{member.quote}"</p>}
        <div class="member__contact">
          {member.email && (
            <a href={`mailto:${member.email}`} class="member__link">{member.email}</a>
          )}
          {member.phone && (
            <a href={`tel:${member.phone.replace(/\s/g, '')}`} class="member__link">{member.phone}</a>
          )}
        </div>
      </article>
    ))}
  </div>

  <div class="team__note">
    <p>
      Si quieres colaborar, aportar ideas o llevarnos a tu municipio,
      escríbenos a <a href="mailto:ningunavozfueradelcoro@gmail.com">ningunavozfueradelcoro@gmail.com</a>.
    </p>
  </div>
</Section>

<style>
  .team {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 340px));
    gap: var(--sp-6);
    justify-content: center;
    margin-bottom: var(--sp-7);
    text-align: center;
  }
  .member { display: flex; flex-direction: column; align-items: center; gap: var(--sp-3); }
  .member__photo {
    width: 140px; height: 140px;
    border-radius: 50%;
    overflow: hidden;
    border: 4px solid var(--paper);
    box-shadow: 0 8px 24px rgba(30, 58, 95, 0.12);
    margin-bottom: var(--sp-2);
  }
  .member__photo img { width: 100%; height: 100%; object-fit: cover; }
  .member__placeholder {
    width: 100%; height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, var(--teal) 0%, var(--navy) 100%);
    color: white;
    font-family: var(--font-display);
    font-size: 2.5rem;
    font-weight: 800;
    letter-spacing: 0.02em;
  }
  .member__name { font-size: var(--fs-lg); line-height: 1.25; margin: 0; }
  .member__role { font-size: var(--fs-sm); color: var(--teal-dark); font-weight: 600; margin: 0; }
  .member__quote { font-style: italic; color: var(--muted); font-size: var(--fs-sm); max-width: 34ch; line-height: 1.55; }
  .member__contact { display: flex; flex-direction: column; gap: var(--sp-1); margin-top: var(--sp-2); }
  .member__link { font-size: var(--fs-sm); color: var(--muted); transition: color 0.15s ease; }
  .member__link:hover { color: var(--navy); }
  .team__note { max-width: 600px; margin: 0 auto; text-align: center; color: var(--muted); font-size: var(--fs-base); line-height: 1.6; }
  .team__note a {
    font-weight: 600;
    color: var(--teal-dark);
    text-decoration: underline;
    text-decoration-thickness: 2px;
    text-underline-offset: 3px;
  }
</style>
ASTRO_EOF

# ---------- Download ----------
cat > src/components/Download.astro <<'ASTRO_EOF'
---
import Button from './Button.astro';
import { SITE } from '@/data/site';
---

<section class="download" id="descargar">
  <div class="container">
    <div class="download__card">
      <div class="download__content">
        <span class="section__eyebrow download__eyebrow">Próximamente</span>
        <h2 class="download__title">Descarga CORO para Android</h2>
        <p class="download__lead">
          Estamos afinando los últimos detalles de la primera versión.
          Déjanos tu correo y te avisamos el día que esté disponible.
        </p>

        <ul class="download__specs">
          <li><strong>Requisito:</strong> {SITE.app.androidMinVersion} o superior</li>
          <li><strong>Tamaño:</strong> {SITE.app.apkSize}</li>
          <li><strong>Funciona sin conexión</strong> para reportar en campo</li>
          <li><strong>Gratis</strong> y sin publicidad</li>
        </ul>

        <div class="download__actions">
          <Button href={`mailto:${SITE.contact.generalEmail}?subject=Quiero%20probar%20CORO`} variant="accent" size="lg">
            Avísenme cuando esté lista
          </Button>
        </div>
      </div>

      <div class="download__visual" aria-hidden="true">
        <div class="phone">
          <div class="phone__notch"></div>
          <div class="phone__screen">
            <div class="phone__logo">CORO</div>
            <div class="phone__line"></div>
            <div class="phone__line phone__line--short"></div>
            <div class="phone__line"></div>
            <div class="phone__line phone__line--short"></div>
            <div class="phone__badge">Próximamente</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<style>
  .download { padding: var(--sp-9) 0; }
  .download__card {
    background: linear-gradient(135deg, var(--navy) 0%, var(--navy-soft) 100%);
    border-radius: var(--radius-xl);
    padding: var(--sp-8);
    display: grid;
    grid-template-columns: 1.2fr 1fr;
    gap: var(--sp-7);
    align-items: center;
    position: relative;
    overflow: hidden;
    color: rgba(255, 255, 255, 0.9);
  }
  .download__card::before {
    content: '';
    position: absolute;
    top: -50%; right: -20%;
    width: 500px; height: 500px;
    background: radial-gradient(circle, rgba(46, 159, 182, 0.35), transparent 65%);
    pointer-events: none;
  }
  .download__eyebrow { color: var(--orange); }
  .download__title { color: white; font-size: var(--fs-2xl); line-height: 1.15; margin-bottom: var(--sp-4); position: relative; }
  .download__lead { color: rgba(255, 255, 255, 0.75); font-size: var(--fs-base); line-height: 1.6; margin-bottom: var(--sp-5); position: relative; }
  .download__specs { display: grid; gap: var(--sp-3); margin-bottom: var(--sp-6); position: relative; }
  .download__specs li {
    color: rgba(255, 255, 255, 0.85);
    font-size: var(--fs-sm);
    padding-left: var(--sp-5);
    position: relative;
    line-height: 1.5;
  }
  .download__specs li::before {
    content: '✓';
    position: absolute;
    left: 0;
    color: var(--orange);
    font-weight: 700;
  }
  .download__specs strong { color: white; }
  .download__actions { position: relative; }
  .download__visual { display: flex; justify-content: center; position: relative; }
  .phone {
    width: 220px;
    aspect-ratio: 9 / 18;
    background: #0B1219;
    border-radius: 32px;
    padding: 12px;
    box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4), 0 0 0 2px rgba(255, 255, 255, 0.06) inset;
    position: relative;
    transform: rotate(-3deg);
    transition: transform 0.4s ease;
  }
  .download__card:hover .phone { transform: rotate(0deg) translateY(-4px); }
  .phone__notch {
    position: absolute;
    top: 12px; left: 50%;
    transform: translateX(-50%);
    width: 80px; height: 18px;
    background: #0B1219;
    border-radius: 0 0 14px 14px;
    z-index: 2;
  }
  .phone__screen {
    background: var(--cream);
    border-radius: 22px;
    height: 100%;
    padding: 44px 20px 20px;
    display: flex;
    flex-direction: column;
    gap: 12px;
  }
  .phone__logo {
    font-family: var(--font-display);
    font-weight: 800;
    font-size: 1.5rem;
    color: var(--navy);
    letter-spacing: -0.02em;
    margin-bottom: 8px;
    text-align: center;
  }
  .phone__line { height: 10px; background: var(--border); border-radius: 6px; }
  .phone__line--short { width: 60%; }
  .phone__badge {
    margin-top: auto;
    align-self: center;
    background: var(--orange);
    color: var(--navy);
    font-weight: 700;
    font-size: var(--fs-xs);
    padding: 6px 14px;
    border-radius: var(--radius-pill);
    text-transform: uppercase;
    letter-spacing: 0.08em;
  }
  @media (max-width: 800px) {
    .download__card { grid-template-columns: 1fr; padding: var(--sp-6); text-align: center; }
    .download__specs li { text-align: left; }
    .download__actions :global(.btn) { width: 100%; }
    .phone { width: 180px; transform: rotate(0deg); }
  }
</style>
ASTRO_EOF

# ==================== PÁGINAS ====================

cat > src/pages/index.astro <<'ASTRO_EOF'
---
import BaseLayout from '@/layouts/BaseLayout.astro';
import Hero from '@/components/Hero.astro';
import Problem from '@/components/Problem.astro';
import WhatIsCoro from '@/components/WhatIsCoro.astro';
import HowItWorks from '@/components/HowItWorks.astro';
import SDGSection from '@/components/SDGSection.astro';
import PurposeVision from '@/components/PurposeVision.astro';
import Team from '@/components/Team.astro';
import Download from '@/components/Download.astro';
---

<BaseLayout>
  <Hero />
  <Problem />
  <WhatIsCoro />
  <HowItWorks />
  <SDGSection />
  <PurposeVision />
  <Team />
  <Download />
</BaseLayout>
ASTRO_EOF

cat > src/pages/404.astro <<'ASTRO_EOF'
---
import BaseLayout from '@/layouts/BaseLayout.astro';
import Button from '@/components/Button.astro';
---

<BaseLayout title="Página no encontrada" noindex>
  <section class="nf">
    <div class="container nf__inner">
      <span class="nf__code">404</span>
      <h1 class="nf__title">Esta página no existe (todavía).</h1>
      <p class="nf__lead">
        Puede que hayas escrito mal la dirección o que el enlace esté viejo.
        Vuelve al inicio para seguir explorando CORO.
      </p>
      <div class="nf__actions">
        <Button href="/" variant="primary" size="lg">Volver al inicio</Button>
      </div>
    </div>
  </section>
</BaseLayout>

<style>
  .nf { padding: var(--sp-10) 0; min-height: 60vh; display: flex; align-items: center; }
  .nf__inner { text-align: center; max-width: 560px; margin: 0 auto; }
  .nf__code {
    display: block;
    font-family: var(--font-display);
    font-size: clamp(5rem, 4rem + 8vw, 10rem);
    font-weight: 800;
    line-height: 1;
    color: var(--teal);
    letter-spacing: -0.05em;
    margin-bottom: var(--sp-4);
    opacity: 0.9;
  }
  .nf__title { font-size: var(--fs-2xl); margin-bottom: var(--sp-4); }
  .nf__lead { color: var(--muted); font-size: var(--fs-lg); line-height: 1.6; margin-bottom: var(--sp-6); }
  .nf__actions { display: flex; justify-content: center; }
</style>
ASTRO_EOF

cat > src/pages/privacidad.astro <<'ASTRO_EOF'
---
import BaseLayout from '@/layouts/BaseLayout.astro';
import { SITE } from '@/data/site';
---

<BaseLayout
  title="Aviso de privacidad"
  description="Cómo CORO trata los datos de sus usuarios."
  noindex
>
  <article class="legal">
    <div class="container container-narrow">
      <span class="section__eyebrow">Legal</span>
      <h1 class="legal__title">Aviso de privacidad</h1>
      <p class="legal__updated">Última actualización: 15 de octubre de 2026</p>

      <section>
        <h2>1. Qué datos recogemos</h2>
        <p>
          Recogemos únicamente los datos necesarios para que CORO funcione:
          correo electrónico, nombre visible, y los datos que aportes al reportar
          un incidente (foto, ubicación, descripción). No pedimos cédula,
          no pedimos documentos de identidad, no pedimos datos bancarios para
          usar la plataforma gratuita.
        </p>
      </section>

      <section>
        <h2>2. Para qué los usamos</h2>
        <ul>
          <li>Crear y proteger tu cuenta.</li>
          <li>Permitir que las instituciones responsables de tu zona reciban tus reportes.</li>
          <li>Mostrar el estado público de los incidentes en el tablero.</li>
          <li>Enviarte notificaciones sobre tus casos, solo si las activas.</li>
        </ul>
      </section>

      <section>
        <h2>3. Qué NO hacemos</h2>
        <ul>
          <li>No vendemos tus datos a terceros.</li>
          <li>No mostramos tu correo ni tu nombre completo en las vistas públicas.</li>
          <li>No rastreamos tu ubicación en segundo plano.</li>
          <li>No usamos tu actividad para publicidad.</li>
        </ul>
      </section>

      <section>
        <h2>4. Tus derechos</h2>
        <p>
          Puedes acceder, corregir o eliminar tu cuenta en cualquier momento
          desde la app. Los incidentes que hayas reportado quedarán anonimizados
          para preservar el historial del caso.
        </p>
      </section>

      <section>
        <h2>5. Menores de edad</h2>
        <p>
          Los usuarios menores de 18 años requieren autorización del tutor.
          Solo se muestra el primer nombre en el ranking público y no se permite
          mensajería con comunidades.
        </p>
      </section>

      <section>
        <h2>6. Contacto</h2>
        <p>
          Para cualquier consulta sobre tus datos:
          <a href={`mailto:${SITE.contact.generalEmail}`}>{SITE.contact.generalEmail}</a>
        </p>
      </section>
    </div>
  </article>
</BaseLayout>

<style>
  .legal { padding: var(--sp-9) 0; }
  .legal__title { font-size: var(--fs-3xl); margin-bottom: var(--sp-2); }
  .legal__updated { color: var(--muted); font-size: var(--fs-sm); font-style: italic; margin-bottom: var(--sp-7); }
  .legal section { margin-bottom: var(--sp-6); }
  .legal h2 { font-size: var(--fs-lg); margin-bottom: var(--sp-3); color: var(--navy); }
  .legal p, .legal li { color: var(--ink-soft); line-height: 1.7; margin-bottom: var(--sp-3); }
  .legal ul { padding-left: var(--sp-5); list-style: disc; }
  .legal ul li::marker { color: var(--teal); }
  .legal a { color: var(--teal-dark); text-decoration: underline; }
</style>
ASTRO_EOF

cat > src/pages/terminos.astro <<'ASTRO_EOF'
---
import BaseLayout from '@/layouts/BaseLayout.astro';
import { SITE } from '@/data/site';
---

<BaseLayout
  title="Términos de uso"
  description="Reglas para usar CORO."
  noindex
>
  <article class="legal">
    <div class="container container-narrow">
      <span class="section__eyebrow">Legal</span>
      <h1 class="legal__title">Términos de uso</h1>
      <p class="legal__updated">Última actualización: 15 de octubre de 2026</p>

      <section>
        <h2>1. Qué es CORO</h2>
        <p>
          CORO es una plataforma de participación ciudadana juvenil que
          permite reportar problemas territoriales, seguir su estado y
          conectar con instituciones responsables. No sustituye a los
          canales oficiales de emergencia.
        </p>
      </section>

      <section>
        <h2>2. Uso responsable</h2>
        <ul>
          <li>Reporta solo problemas reales y verificables.</li>
          <li>No publiques datos personales de terceros sin consentimiento.</li>
          <li>No uses la plataforma para acosar, difamar ni discriminar.</li>
          <li>No subas contenido ilegal o que infrinja derechos de autor.</li>
        </ul>
      </section>

      <section>
        <h2>3. Contenido que publicas</h2>
        <p>
          Conservas la autoría de tus aportes. Al publicarlos, otorgas a CORO
          una licencia no exclusiva para mostrarlos dentro de la plataforma
          y en el tablero público, con fines de transparencia.
        </p>
      </section>

      <section>
        <h2>4. Moderación</h2>
        <p>
          Podemos ocultar contenido que incumpla estos términos. Si tu
          contenido fue ocultado, tienes derecho a apelar la decisión.
          Las apelaciones se revisan por una persona distinta a la que tomó
          la decisión original.
        </p>
      </section>

      <section>
        <h2>5. Limitación de responsabilidad</h2>
        <p>
          CORO conecta personas e instituciones, pero no garantiza que
          cada reporte sea resuelto. La respuesta depende de las instituciones
          responsables de cada territorio.
        </p>
      </section>

      <section>
        <h2>6. Cambios</h2>
        <p>
          Podemos actualizar estos términos. Te avisaremos dentro de la app
          cuando haya cambios importantes.
        </p>
      </section>

      <section>
        <h2>7. Contacto</h2>
        <p>
          Dudas o reportes sobre estos términos:
          <a href={`mailto:${SITE.contact.generalEmail}`}>{SITE.contact.generalEmail}</a>
        </p>
      </section>
    </div>
  </article>
</BaseLayout>

<style>
  .legal { padding: var(--sp-9) 0; }
  .legal__title { font-size: var(--fs-3xl); margin-bottom: var(--sp-2); }
  .legal__updated { color: var(--muted); font-size: var(--fs-sm); font-style: italic; margin-bottom: var(--sp-7); }
  .legal section { margin-bottom: var(--sp-6); }
  .legal h2 { font-size: var(--fs-lg); margin-bottom: var(--sp-3); color: var(--navy); }
  .legal p, .legal li { color: var(--ink-soft); line-height: 1.7; margin-bottom: var(--sp-3); }
  .legal ul { padding-left: var(--sp-5); list-style: disc; }
  .legal ul li::marker { color: var(--teal); }
  .legal a { color: var(--teal-dark); text-decoration: underline; }
</style>
ASTRO_EOF

echo ""
echo "✅ Landing completa creada"
echo ""
echo "Archivos creados:"
echo "  components/  → Header, Hero, Problem, WhatIsCoro, HowItWorks,"
echo "                 SDGSection, PurposeVision, Team, Download"
echo "  pages/       → index.astro, 404.astro, privacidad.astro, terminos.astro"
echo ""
echo "Ahora ejecuta:  npm run dev"
