// @ts-check
import { defineConfig } from 'astro/config';
import react from '@astrojs/react';
// import tailwind from '@astrojs/tailwind';
import tailwindcss from '@tailwindcss/vite';
const tailwind = tailwindcss;

// https://astro.build/config
export default defineConfig({
    integrations: [react({
        experimentalReactChildren: true,
      }), tailwind(), tailwindcss()],
    vite: {
        plugins: [tailwindcss()],
    }
});
