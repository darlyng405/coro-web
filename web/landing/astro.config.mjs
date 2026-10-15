import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://coro-beta.vercel.app',
  output: 'static',
  build: {
    inlineStylesheets: 'auto',
  },
  compressHTML: true,
});
