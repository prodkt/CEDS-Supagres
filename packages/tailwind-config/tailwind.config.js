/** @type {import('tailwindcss').Config} */
export default {
  content: ['./*.{js,jsx,ts,tsx,css,scss}','./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}','./src/stories/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}', '@prodkt/ui/**/*.{js,jsx,ts,tsx,css,scss}', '@prodkt/ui/src/**/*.{js,jsx,ts,tsx,css,scss}'],
  theme: {
    extend: {},
  },
  plugins: [],
}

