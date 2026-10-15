#!/usr/bin/env bash
set -e

echo "🔧 Aplicando todos los arreglos..."

# ============================================================
# 1. site.ts — URL correcta + datos actualizados
# ============================================================
cat > src/data/site.ts <<'EOF'
export const SITE = {
  name: 'CORO',
  tagline: 'Que tu voz sea escuchada',
  tagline2: 'Con un buen CORO podemos cambiar el país.',
  description:
    'CORO es una plataforma de participación ciudadana juvenil con trazabilidad. Reporta problemas, sigue cada respuesta y transforma tu comunidad.',
  url: 'https://coro-beta.vercel.app',

  contact: {
    generalEmail: 'ningunavozfueradelcoro@gmail.com',
    darlyngEmail: 'mateodarlyng5@gmail.com',
    ailinEmail: 'ailincruz015@gmail.com',
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
# 2. Header — logo GRANDE (56px) y bien visible
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
      <img src="/logotipo.jpg" alt="CORO" />
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
    background: rgba(250, 247, 242, 0.92);
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
  .header__brand {
    display: flex;
    align-items: center;
    flex-shrink: 0;
    padding: 4px 0;
  }
  .header__brand img {
    height: 64px;
    width: auto;
    max-width: 240px;
    object-fit: contain;
    border-radius: 8px;
    display: block;
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
    .header__brand img { height: 52px; max-width: 200px; }
  }
  @media (max-width: 480px) {
    .header__brand img { height: 44px; max-width: 170px; }
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
# 3. Footer — logo grande, sin "Hecho con", compacto en mobile
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
        <img src="/logotipo.jpg" alt="CORO" />
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
    </div>
  </div>
</footer>

<style>
  .footer {
    background: var(--navy);
    color: rgba(255, 255, 255, 0.85);
    padding: var(--sp-8) 0 var(--sp-5);
    margin-top: var(--sp-9);
  }
  .footer__grid {
    display: grid;
    grid-template-columns: 1.6fr repeat(3, 1fr);
    gap: var(--sp-6);
    margin-bottom: var(--sp-6);
    align-items: start;
  }
  .footer__brand img {
    height: 64px;
    width: auto;
    max-width: 240px;
    object-fit: contain;
    margin-bottom: var(--sp-3);
    border-radius: 8px;
    background: white;
    padding: 8px 14px;
    display: block;
  }
  .footer__tagline {
    color: rgba(255, 255, 255, 0.7);
    font-size: var(--fs-sm);
    max-width: 32ch;
    font-style: italic;
  }
  .footer__col h4 {
    color: white;
    font-size: var(--fs-sm);
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    margin-bottom: var(--sp-3);
    opacity: 0.85;
  }
  .footer__col ul { display: flex; flex-direction: column; gap: var(--sp-2); }
  .footer__col a {
    color: rgba(255, 255, 255, 0.75);
    font-size: var(--fs-sm);
    transition: color 0.15s ease;
    word-break: break-word;
  }
  .footer__col a:hover { color: white; }
  .footer__social {
    margin-top: var(--sp-3);
    flex-direction: row !important;
    gap: var(--sp-4) !important;
  }
  .footer__bottom {
    padding-top: var(--sp-4);
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    font-size: var(--fs-sm);
    color: rgba(255, 255, 255, 0.6);
    text-align: center;
  }
  @media (max-width: 900px) {
    .footer { padding: var(--sp-6) 0 var(--sp-4); }
    .footer__grid {
      grid-template-columns: 1fr 1fr;
      gap: var(--sp-5);
      margin-bottom: var(--sp-5);
    }
    .footer__brand {
      grid-column: 1 / -1;
      display: flex;
      flex-direction: column;
      align-items: center;
      text-align: center;
    }
    .footer__brand img {
      height: 60px;
      max-width: 220px;
    }
    .footer__tagline { max-width: none; }
  }
  @media (max-width: 560px) {
    .footer { padding: var(--sp-5) 0 var(--sp-4); }
    .footer__grid {
      grid-template-columns: 1fr 1fr;
      gap: var(--sp-4);
      margin-bottom: var(--sp-4);
    }
    .footer__brand img {
      height: 52px;
      max-width: 190px;
    }
    .footer__col h4 {
      font-size: 0.7rem;
      margin-bottom: var(--sp-2);
    }
    .footer__col ul { gap: 4px; }
    .footer__col a { font-size: 0.78rem; }
    .footer__bottom {
      font-size: 0.7rem;
      padding-top: var(--sp-3);
    }
  }
</style>
ASTRO_EOF

# ============================================================
# 4. Download — arreglar "Próximamente" cortado en mobile
# ============================================================
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
    aspect-ratio: 9 / 17;
    background: #0B1219;
    border-radius: 30px;
    padding: 10px;
    box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4), 0 0 0 2px rgba(255, 255, 255, 0.06) inset;
    position: relative;
    transform: rotate(-3deg);
    transition: transform 0.4s ease;
  }
  .download__card:hover .phone { transform: rotate(0deg) translateY(-4px); }
  .phone__notch {
    position: absolute;
    top: 10px; left: 50%;
    transform: translateX(-50%);
    width: 70px; height: 16px;
    background: #0B1219;
    border-radius: 0 0 12px 12px;
    z-index: 2;
  }
  .phone__screen {
    background: var(--cream);
    border-radius: 22px;
    height: 100%;
    padding: 34px 16px 16px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    overflow: hidden;
  }
  .phone__logo {
    font-family: var(--font-display);
    font-weight: 800;
    font-size: 1.35rem;
    color: var(--navy);
    letter-spacing: -0.02em;
    margin-bottom: 6px;
    text-align: center;
  }
  .phone__line { height: 8px; background: var(--border); border-radius: 4px; flex-shrink: 0; }
  .phone__line--short { width: 60%; }
  .phone__badge {
    margin-top: auto;
    align-self: center;
    background: var(--orange);
    color: var(--navy);
    font-weight: 700;
    font-size: 0.7rem;
    padding: 6px 14px;
    border-radius: var(--radius-pill);
    text-transform: uppercase;
    letter-spacing: 0.06em;
    white-space: nowrap;
    flex-shrink: 0;
  }

  @media (max-width: 800px) {
    .download { padding: var(--sp-7) 0; }
    .download__card {
      grid-template-columns: 1fr;
      padding: var(--sp-6) var(--sp-5);
      text-align: center;
      gap: var(--sp-5);
    }
    .download__specs li { text-align: left; }
    .download__actions :global(.btn) { width: 100%; }
    .phone {
      width: 200px;
      aspect-ratio: 9 / 18;
      transform: rotate(0deg);
      margin: 0 auto;
    }
    .phone__screen {
      padding: 30px 14px 14px;
      gap: 9px;
    }
  }
  @media (max-width: 480px) {
    .download__card { padding: var(--sp-5) var(--sp-4); }
    .phone {
      width: 180px;
      aspect-ratio: 9 / 18;
    }
    .phone__screen {
      padding: 26px 12px 12px;
      gap: 8px;
    }
    .phone__badge {
      font-size: 0.65rem;
      padding: 5px 12px;
    }
  }
  @media (max-width: 360px) {
    .phone { width: 160px; }
  }
</style>
ASTRO_EOF

# ============================================================
# 5. BaseLayout — OG image cambia a OG.jpeg
# ============================================================
sed -i 's|og-image\.png|OG.jpeg|g' src/layouts/BaseLayout.astro

# ============================================================
# 6. global.css — altura del header más grande
# ============================================================
sed -i 's|--header-h: 72px;|--header-h: 96px;|' src/styles/global.css
sed -i 's|--header-h: 88px;|--header-h: 96px;|' src/styles/global.css

echo ""
echo "✅ Todos los arreglos aplicados:"
echo ""
echo "  📌 Header:"
echo "     - Logo 64px (52px en tablet, 44px en mobile pequeño)"
echo "     - Altura del header: 96px"
echo ""
echo "  📌 Footer:"
echo "     - Logo 64px (60px tablet, 52px mobile)"
echo "     - Quitado 'Hecho con 💚 en RD'"
echo "     - Más compacto en mobile"
echo ""
echo "  📌 Download:"
echo "     - Phone arreglado para mobile (180px en pantallas pequeñas)"
echo "     - 'Próximamente' ya no se corta"
echo ""
echo "  📌 OG image:"
echo "     - Cambiada a /OG.jpeg"
echo ""
echo "🔍 Verifica que la imagen exista en: public/OG.jpeg"
echo ""
echo "🚀 Ahora sube los cambios:"
echo ""
echo "   cd ~/Descargas/CORO-WEB"
echo "   git add ."
echo "   git commit -m 'Fix mobile y logos'"
echo "   git push"
echo ""
