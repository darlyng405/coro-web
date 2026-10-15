#!/usr/bin/env bash
set -e

# ============================================
# 1. site.ts — corregir URL a Vercel
# ============================================
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

# ============================================
# 2. Header — logo más grande
# ============================================
sed -i 's|height: 40px;|height: 56px;|' src/components/Header.astro
sed -i 's|width="140" height="40"|width="200" height="56"|' src/components/Header.astro
sed -i 's|--header-h: 72px;|--header-h: 88px;|' src/styles/global.css

# ============================================
# 3. Footer — logo grande + sin "Hecho con" + más compacto en mobile
# ============================================
cat > src/components/Footer.astro <<'EOF'
---
import { SITE } from '@/data/site';

const year = new Date().getFullYear();
const social = Object.entries(SITE.social).filter(([, url]) => url);
---

<footer class="footer">
  <div class="container">
    <div class="footer__grid">
      <div class="footer__brand">
        <img src="/logotipo.jpg" alt="CORO" width="160" height="56" />
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
    grid-template-columns: 1.5fr repeat(3, 1fr);
    gap: var(--sp-6);
    margin-bottom: var(--sp-6);
  }
  .footer__brand img {
    height: 56px;
    width: auto;
    margin-bottom: var(--sp-3);
    border-radius: 8px;
    background: white;
    padding: 8px 14px;
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
    margin-bottom: var(--sp-3);
    opacity: 0.85;
  }
  .footer__col ul { display: flex; flex-direction: column; gap: var(--sp-2); }
  .footer__col a {
    color: rgba(255, 255, 255, 0.75);
    font-size: var(--fs-sm);
    transition: color 0.15s ease;
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
      text-align: center;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .footer__brand img {
      height: 48px;
    }
    .footer__tagline {
      max-width: none;
    }
  }
  @media (max-width: 560px) {
    .footer { padding: var(--sp-5) 0 var(--sp-4); }
    .footer__grid {
      grid-template-columns: 1fr 1fr;
      gap: var(--sp-4);
    }
    .footer__col h4 {
      font-size: 0.7rem;
      margin-bottom: var(--sp-2);
    }
    .footer__col ul { gap: var(--sp-1); }
    .footer__col a { font-size: 0.8rem; }
    .footer__bottom {
      font-size: 0.75rem;
    }
  }
</style>
EOF

# ============================================
# 4. Download — arreglar el mockup del teléfono en mobile
# ============================================
cat > src/components/Download.astro <<'EOF'
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
    width: 200px;
    aspect-ratio: 9 / 16;
    background: #0B1219;
    border-radius: 28px;
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
    border-radius: 20px;
    height: 100%;
    padding: 30px 16px 14px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    overflow: hidden;
  }
  .phone__logo {
    font-family: var(--font-display);
    font-weight: 800;
    font-size: 1.25rem;
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
    padding: 5px 12px;
    border-radius: var(--radius-pill);
    text-transform: uppercase;
    letter-spacing: 0.06em;
    white-space: nowrap;
  }
  @media (max-width: 800px) {
    .download { padding: var(--sp-7) 0; }
    .download__card {
      grid-template-columns: 1fr;
      padding: var(--sp-6) var(--sp-5);
      text-align: center;
    }
    .download__specs li { text-align: left; }
    .download__actions :global(.btn) { width: 100%; }
    .phone {
      width: 170px;
      aspect-ratio: 9 / 17;
      transform: rotate(0deg);
    }
    .phone__screen {
      padding: 26px 14px 12px;
      gap: 8px;
    }
  }
  @media (max-width: 420px) {
    .phone {
      width: 150px;
    }
    .phone__screen {
      padding: 22px 12px 10px;
    }
    .phone__badge {
      font-size: 0.65rem;
      padding: 4px 10px;
    }
  }
</style>
EOF

echo ""
echo "✅ Arreglos aplicados:"
echo "  - Header: logo 40px → 56px"
echo "  - Header height: 72px → 88px"
echo "  - Footer: logo 44px → 56px"
echo "  - Footer: quitado 'Hecho con...'"
echo "  - Footer: más compacto en mobile"
echo "  - Download: phone arreglado en mobile"
echo "  - site.ts: URL corregida a coro-beta.vercel.app"
echo ""
echo "Ahora:"
echo "  cd ../.."
echo "  git add ."
echo "  git commit -m 'Fix mobile: footer, logos, phone mockup'"
echo "  git push"
