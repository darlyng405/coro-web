#!/usr/bin/env bash
set -e

# ============================================================
# 1. Header con logotipo.jpg
# ============================================================
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
      <img src="/logotipo.jpg" alt="CORO" width="140" height="40" />
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
  .header__brand img {
    height: 40px;
    width: auto;
    border-radius: 6px;
  }
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

# ============================================================
# 2. Footer con logotipo.jpg
# ============================================================
cat > src/components/Footer.astro <<'ASTRO_EOF'
---
import { SITE } from '@/data/site';

const year = new Date().getFullYear();
const social = Object.entries(SITE.social).filter(([, url]) => url);
---

<footer class="footer">
  <div class="container">
    <div class="footer__grid">
      <div class="footer__brand">
        <img src="/logotipo.jpg" alt="CORO" width="120" height="40" />
        <p class="footer__tagline">
          Que ninguna voz se quede fuera del coro.
        </p>
      </div>

      <div class="footer__col">
        <h4>Plataforma</h4>
        <ul>
          <li><a href="#que-es">Qué es CORO</a></li>
          <li><a href="#como-funciona">Cómo funciona</a></li>
          <li><a href="#ods">ODS</a></li>
          <li><a href="#descargar">Descargar</a></li>
        </ul>
      </div>

      <div class="footer__col">
        <h4>Proyecto</h4>
        <ul>
          <li><a href="#equipo">Equipo</a></li>
          <li><a href="#proposito">Propósito y visión</a></li>
          <li><a href="/privacidad">Privacidad</a></li>
          <li><a href="/terminos">Términos</a></li>
        </ul>
      </div>

      <div class="footer__col">
        <h4>Contacto</h4>
        <ul>
          <li>
            <a href={`mailto:${SITE.contact.generalEmail}`}>
              {SITE.contact.generalEmail}
            </a>
          </li>
          {SITE.contact.darlyngPhone && (
            <li>
              <a href={`tel:${SITE.contact.darlyngPhone.replace(/\s/g, '')}`}>
                {SITE.contact.darlyngPhone}
              </a>
            </li>
          )}
        </ul>
        {social.length > 0 && (
          <ul class="footer__social">
            {social.map(([name, url]) => (
              <li>
                <a href={url} target="_blank" rel="noopener noreferrer">
                  {name}
                </a>
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>

    <div class="footer__bottom">
      <p>© {year} CORO — Proyecto de participación ciudadana juvenil.</p>
      <p class="footer__legal">
        Hecho con <span aria-hidden="true">💚</span> en República Dominicana.
      </p>
    </div>
  </div>
</footer>

<style>
  .footer {
    background: var(--navy);
    color: rgba(255, 255, 255, 0.85);
    padding: var(--sp-9) 0 var(--sp-5);
    margin-top: var(--sp-9);
  }
  .footer__grid {
    display: grid;
    grid-template-columns: 1.5fr repeat(3, 1fr);
    gap: var(--sp-7) var(--sp-6);
    margin-bottom: var(--sp-8);
  }
  .footer__brand img {
    height: 44px;
    width: auto;
    margin-bottom: var(--sp-4);
    border-radius: 6px;
    background: white;
    padding: 6px 10px;
  }
  .footer__tagline {
    color: rgba(255, 255, 255, 0.7);
    font-size: var(--fs-sm);
    max-width: 30ch;
    font-style: italic;
  }
  .footer__col h4 {
    color: white;
    font-size: var(--fs-sm);
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    margin-bottom: var(--sp-4);
    opacity: 0.85;
  }
  .footer__col ul { display: flex; flex-direction: column; gap: var(--sp-3); }
  .footer__col a {
    color: rgba(255, 255, 255, 0.75);
    font-size: var(--fs-sm);
    transition: color 0.15s ease;
  }
  .footer__col a:hover { color: white; }
  .footer__social {
    margin-top: var(--sp-4);
    flex-direction: row !important;
    gap: var(--sp-4) !important;
  }
  .footer__bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: var(--sp-4);
    padding-top: var(--sp-5);
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    font-size: var(--fs-sm);
    color: rgba(255, 255, 255, 0.6);
    flex-wrap: wrap;
  }
  @media (max-width: 900px) {
    .footer__grid { grid-template-columns: 1fr 1fr; gap: var(--sp-6); }
  }
  @media (max-width: 560px) {
    .footer__grid { grid-template-columns: 1fr; }
    .footer__bottom { flex-direction: column; text-align: center; }
  }
</style>
ASTRO_EOF

# ============================================================
# 3. BaseLayout con isotipo.jpg
# ============================================================
cat > src/layouts/BaseLayout.astro <<'ASTRO_EOF'
---
import '@/styles/global.css';
import Header from '@/components/Header.astro';
import Footer from '@/components/Footer.astro';
import { SITE } from '@/data/site';

interface Props {
  title?: string;
  description?: string;
  noindex?: boolean;
}

const {
  title = `${SITE.name} — ${SITE.tagline}`,
  description = SITE.description,
  noindex = false,
} = Astro.props;

const fullTitle = title.includes(SITE.name) ? title : `${title} — ${SITE.name}`;
const canonicalURL = new URL(Astro.url.pathname, Astro.site);
---

<!doctype html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="generator" content={Astro.generator} />
    <link rel="icon" type="image/jpeg" href="/isotipo.jpg" />
    <link rel="canonical" href={canonicalURL} />

    <title>{fullTitle}</title>
    <meta name="description" content={description} />
    {noindex && <meta name="robots" content="noindex" />}

    <meta property="og:type" content="website" />
    <meta property="og:title" content={fullTitle} />
    <meta property="og:description" content={description} />
    <meta property="og:url" content={canonicalURL} />
    <meta property="og:site_name" content={SITE.name} />
    <meta property="og:locale" content="es_DO" />
    <meta property="og:image" content={`${SITE.url}/og-image.png`} />

    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content={fullTitle} />
    <meta name="twitter:description" content={description} />
    <meta name="twitter:image" content={`${SITE.url}/og-image.png`} />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Manrope:wght@600;700;800&display=swap"
      rel="stylesheet"
    />

    <meta name="theme-color" content="#1E3A5F" />
  </head>
  <body>
    <Header />
    <main>
      <slot />
    </main>
    <Footer />
  </body>
</html>
ASTRO_EOF

# ============================================================
# 4. data/site.ts
# ============================================================
cat > src/data/site.ts <<'EOF'
export const SITE = {
  name: 'CORO',
  tagline: 'Que tu voz sea escuchada',
  tagline2: 'Con un buen CORO podemos cambiar el país.',
  description:
    'CORO es una plataforma de participación ciudadana juvenil con trazabilidad. Reporta problemas, sigue cada respuesta y transforma tu comunidad.',
  url: 'https://coro.onrender.com',

  contact: {
    generalEmail: 'ningunavozfueradelcoro@gmail.com',
    darlyngEmail: 'mateodarlyng5@gmail.com',
    ailinEmail: '',
    darlyngPhone: '+1 829-876-0411',
  },

  social: {
    instagram: '',
    twitter: '',
    tiktok: '',
    linkedin: '',
  },

  app: {
    available: false,
    androidMinVersion: 'Android 13 (API 33)',
    apkSize: '~23 MB',
    playStoreUrl: '',
    apkUrl: '/coro.apk',
  },
} as const;
EOF

# ============================================================
# 5. data/sdgs.ts — con imágenes
# ============================================================
cat > src/data/sdgs.ts <<'EOF'
export interface SDG {
  number: number;
  name: string;
  description: string;
  color: string;
  image: string;
}

export const SDGS: SDG[] = [
  {
    number: 10,
    name: 'Reducción de las desigualdades',
    description:
      'Damos voz a comunidades que normalmente no son escuchadas y reducimos la brecha entre jóvenes y las instituciones.',
    color: '#DD1367',
    image: '/sdgs/ods-10.png',
  },
  {
    number: 11,
    name: 'Ciudades y comunidades sostenibles',
    description:
      'Mejoramos los espacios públicos del barrio reportando y resolviendo problemas reales con evidencia verificable.',
    color: '#FD9D24',
    image: '/sdgs/ods-11.png',
  },
  {
    number: 16,
    name: 'Paz, justicia e instituciones sólidas',
    description:
      'Construimos transparencia: cada caso tiene seguimiento público y cada institución responde con datos.',
    color: '#00689D',
    image: '/sdgs/ods-16.png',
  },
  {
    number: 17,
    name: 'Alianzas para lograr los objetivos',
    description:
      'Conectamos jóvenes, comunidades y organizaciones verificadas para multiplicar el impacto colectivo.',
    color: '#19486A',
    image: '/sdgs/ods-17.png',
  },
];
EOF

# ============================================================
# 6. data/team.ts — con info real
# ============================================================
cat > src/data/team.ts <<'EOF'
export interface TeamMember {
  name: string;
  role: string;
  description?: string;
  quote?: string;
  photo?: string;
  email?: string;
  phone?: string;
  links?: { label: string; url: string }[];
}

export const TEAM: TeamMember[] = [
  {
    name: 'Ailin Cruz Crisóstomo Lopez',
    role: 'Catalizadora de ideas · Estratega de innovación',
    description:
      'Transformo ideas en propuestas, conecto la innovación con necesidades reales y comunico soluciones capaces de generar impacto.',
    quote: '¿Quién dijo que eres muy joven?',
    photo: '/team/ailin.jpg',
    email: '',
    phone: '',
    links: [],
  },
  {
    name: 'Darlyng Rafael Mateo Peral',
    role: 'Desarrollador de software · Analista de sistemas',
    description:
      'Transformo ideas en algo visual, hago que la imaginación deje de ser un sueño y se convierta en una realidad.',
    quote: 'La vida es muy corta como para no vivirla.',
    photo: '/team/yomismo.jpg',
    email: 'mateodarlyng5@gmail.com',
    phone: '+1 829-876-0411',
    links: [],
  },
];
EOF

# ============================================================
# 7. WhatIsCoro — trazabilidad en lenguaje natural
# ============================================================
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
    <div class="trazabilidad__icon" aria-hidden="true">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M21 12a9 9 0 1 1-6.219-8.56"/>
        <polyline points="22 4 12 14.01 9 11.01"/>
      </svg>
    </div>
    <div>
      <h3 class="trazabilidad__title">Y algo que lo hace diferente: seguimiento real</h3>
      <p class="trazabilidad__text">
        Cada caso que reportas se puede seguir paso a paso:
        <strong>quién lo está atendiendo, en qué etapa va y las fotos del antes y el después.</strong>
        Nada se pierde en el olvido.
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
    align-items: center;
    background: linear-gradient(135deg, var(--teal-soft) 0%, var(--paper) 100%);
    border: 1px solid var(--border-soft);
    border-radius: var(--radius-lg);
    padding: var(--sp-6);
  }
  .trazabilidad__icon {
    flex-shrink: 0;
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--navy);
    color: var(--orange);
    border-radius: 50%;
  }
  .trazabilidad__icon svg {
    width: 26px;
    height: 26px;
  }
  .trazabilidad__title { font-size: var(--fs-lg); margin-bottom: var(--sp-2); }
  .trazabilidad__text { color: var(--ink-soft); line-height: 1.55; }
  .trazabilidad__text strong { color: var(--navy); }
  @media (max-width: 640px) {
    .trazabilidad { flex-direction: column; align-items: flex-start; }
  }
</style>
ASTRO_EOF

# ============================================================
# 8. SDGSection — con imágenes PNG
# ============================================================
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
        <div class="sdg__image-wrap">
          <img
            src={sdg.image}
            alt={`Objetivo de Desarrollo Sostenible ${sdg.number}: ${sdg.name}`}
            width="200"
            height="200"
            loading="lazy"
            class="sdg__image"
          />
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
    display: flex;
    flex-direction: column;
    gap: var(--sp-4);
  }
  .sdg::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 4px;
    background: var(--sdg-color);
  }
  .sdg:hover { transform: translateY(-3px); box-shadow: var(--shadow); }
  .sdg__image-wrap { display: flex; justify-content: flex-start; }
  .sdg__image {
    width: 96px;
    height: 96px;
    object-fit: contain;
    display: block;
  }
  .sdg__name {
    font-size: var(--fs-base);
    font-weight: 700;
    line-height: 1.3;
    color: var(--navy);
  }
  .sdg__desc {
    color: var(--muted);
    font-size: var(--fs-sm);
    line-height: 1.55;
  }
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

# ============================================================
# 9. PurposeVision — sin emojis, con SVG limpios
# ============================================================
cat > src/components/PurposeVision.astro <<'ASTRO_EOF'
---
import Section from './Section.astro';

const icons = {
  proposito: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="6"/><circle cx="12" cy="12" r="2"/></svg>`,
  vision: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/></svg>`,
  alcance: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M21.3 15.3a2.4 2.4 0 0 1 0 3.4l-2.6 2.6a2.4 2.4 0 0 1-3.4 0L2.7 8.7a2.41 2.41 0 0 1 0-3.4l2.6-2.6a2.41 2.41 0 0 1 3.4 0Z"/><path d="m14.5 12.5 2-2"/><path d="m11.5 9.5 2-2"/><path d="m8.5 6.5 2-2"/><path d="m17.5 15.5 2-2"/></svg>`,
};

const blocks = [
  {
    key: 'proposito' as const,
    label: 'Propósito',
    title: 'Reducir la apatía política juvenil.',
    text: 'Crear un puente entre las voces jóvenes y las instituciones que pueden resolver problemas reales. Que la participación no se quede en un like, sino en un caso con seguimiento.',
    color: 'orange',
  },
  {
    key: 'vision' as const,
    label: 'Visión',
    title: 'Que en 2030 cualquier joven pueda reportar y ver respuestas.',
    text: 'Imaginamos un país donde reportar un bache, una fuga o un foco de basura no sea un grito al vacío, sino el inicio de un proceso claro con responsables identificables.',
    color: 'teal',
  },
  {
    key: 'alcance' as const,
    label: 'Alcance',
    title: 'Empezamos con un municipio, crecemos por etapas.',
    text: 'MVP: 1 municipio piloto, 50–200 usuarios, 1,000 incidentes. Fase 2: multi-municipio, iOS, panel institucional. Fase 3: expansión regional en el Caribe hispanohablante.',
    color: 'navy',
  },
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
        <div class="pva__icon" set:html={icons[b.key]} />
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
  .pva__item--orange { --accent: var(--orange); --icon-color: var(--orange); }
  .pva__item--teal   { --accent: var(--teal);   --icon-color: var(--teal); }
  .pva__item--navy   { --accent: var(--navy);   --icon-color: var(--navy); }
  .pva__item:hover { transform: translateY(-3px); box-shadow: var(--shadow); }
  .pva__icon {
    width: 44px;
    height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--icon-color);
    margin-bottom: var(--sp-4);
  }
  .pva__icon :global(svg) { width: 100%; height: 100%; }
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

# ============================================================
# 10. Team — con descripción y cita
# ============================================================
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
        {member.description && <p class="member__desc">{member.description}</p>}
        {member.quote && <p class="member__quote">“{member.quote}”</p>}
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
    grid-template-columns: repeat(auto-fit, minmax(280px, 380px));
    gap: var(--sp-7);
    justify-content: center;
    margin-bottom: var(--sp-7);
    text-align: center;
  }
  .member { display: flex; flex-direction: column; align-items: center; gap: var(--sp-3); }
  .member__photo {
    width: 160px; height: 160px;
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
    font-size: 2.75rem;
    font-weight: 800;
    letter-spacing: 0.02em;
  }
  .member__name { font-size: var(--fs-lg); line-height: 1.25; margin: 0; }
  .member__role {
    font-size: var(--fs-sm);
    color: var(--teal-dark);
    font-weight: 600;
    margin: 0;
    max-width: 32ch;
  }
  .member__desc {
    font-size: var(--fs-sm);
    color: var(--ink-soft);
    line-height: 1.6;
    max-width: 40ch;
    margin: var(--sp-2) 0 0;
  }
  .member__quote {
    font-style: italic;
    color: var(--muted);
    font-size: var(--fs-sm);
    max-width: 34ch;
    line-height: 1.55;
    padding: var(--sp-3) var(--sp-4);
    background: var(--cream);
    border-radius: var(--radius);
    margin-top: var(--sp-2);
  }
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

echo ""
echo "✅ Todos los cambios aplicados"
echo ""
echo "Coloca estas imágenes en public/:"
echo "  public/logotipo.jpg              ← logotipo con texto CORO"
echo "  public/isotipo.jpg               ← isotipo solo (para favicon)"
echo "  public/team/ailin.jpg            ← foto de Ailin"
echo "  public/team/yomismo.jpg          ← tu foto (Darlyng)"
echo "  public/sdgs/ods-10.png           ← imagen oficial ODS 10"
echo "  public/sdgs/ods-11.png           ← imagen oficial ODS 11"
echo "  public/sdgs/ods-16.png           ← imagen oficial ODS 16"
echo "  public/sdgs/ods-17.png           ← imagen oficial ODS 17"
echo ""
echo "Luego recarga con: Ctrl + Shift + R"
