import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  optimizeDeps: {
    exclude: ['@storybook/addon-docs', '@prodkt/tailwind']
  },
  plugins: [
    tailwindcss({
      config: './tailwind.config.js', // Path to your Tailwind config
    })
  ],
  css: {
    // preprocessorOptions: {
    //   scss: {
    //     additionalData: `@import "@prodkt/tailwind/global.scss";`
    //   }
    // },
    postcss: {
      plugins: [
        tailwindcss,
      ]
    }
  },
  build: {
    cssCodeSplit: false
  }
});