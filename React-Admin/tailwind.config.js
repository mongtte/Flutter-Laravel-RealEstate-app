/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        'color1': 'var(--color-color1)',
        'color2': 'var(--color-color2)',
        'color3': 'var(--color-color3)',
        'color4': 'var(--color-color4)',
        'color5': 'var(--color-color5)',
        'color6': 'var(--color-color6)',
        'color7': 'var(--color-color7)',
        'color8': 'var(--color-color8)',
        'tcolor1':'var(--color-tcolor1)',
        'tcolor2':'var(--color-tcolor2)',
        'tcolor3':'var(--color-tcolor3)',
      },
    },
    letterSpacing: {
      widest:'.1em',
      widest:'.25em'
    },
    screens: {
      'sm': '640px', //tablet
      'md': '875px',
      'lg': '1024px', //laptop
      'xl': '1240px', //desktop
      '2xl': '1560px',
    },
    container: {
      center: true,
      padding: {
        DEFAULT: '1rem',
        // sm: '1.3rem',
        // md: '2rem',
        // lg: '2rem',
        // xl: '5rem',
        // '2xl' : '0rem',
      }
    }
  },
  plugins: [require("daisyui")],
};
