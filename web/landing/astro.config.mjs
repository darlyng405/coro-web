import { defineConfig } from 'astro/config';

// Cambia `site` cuando tengas dominio propio
export default defineConfig({
  site: 'https://coro.onrender.com',
  output: 'static',
  build: {
    inlineStylesheets: 'auto',
  },
  compressHTML: true,
  vite: {
    build: {
      cssMinify: 'lightningcss',
    },
  },
});