const colors = require("tailwindcss/colors");
const defaultTheme = require("tailwindcss/defaultTheme");
const path = require("path");
const fs = require("fs");
let plugin = require("tailwindcss/plugin");

const navyColor = {
  50: "#E7E9EF",
  100: "#C2C9D6",
  200: "#A3ADC2",
  300: "#697A9B",
  400: "#5C6B8A",
  450: "#465675",
  500: "#384766",
  600: "#313E59",
  700: "#26334D",
  750: "#222E45",
  800: "#202B40",
  900: "#192132",
};

const customColors = {
  navy: navyColor, // We will keep this name to be used as default because LineOne theme has defined it as the main color used in all htmls.
  "slate-150": "#E9EEF5", // Defined to be used in some borders or other places where other darker slate colors are used.
  primary: { DEFAULT: colors.indigo["600"] }, // Used for the main brand color, call-to-action buttons, or key elements.
  "primary-focus": colors.indigo["700"], // Used for focus on primary elements.
  "secondary-light": "#ff57d8", // Used for secondary actions, supporting buttons, or accent elements in DARK mode.
  secondary: { DEFAULT: "#F000B9" }, // Used for secondary actions, supporting buttons, or accent elements.
  "secondary-focus": "#BD0090", // Used for focus on secondary elements.
  "accent-light": colors.indigo["400"], // Used for highlighting, hover states, or attention-grabbing elements in DARK mode.
  accent: { DEFAULT: "#5f5af6" }, // Used for highlighting, links, hover states, or attention-grabbing elements.
  "accent-focus": "#4d47f5", // Used for focus on accent elements.
  info: colors.sky["500"], // Used for information elements like alerts, buttons, labels, icons, etc.
  "info-focus": colors.sky["600"], // Used for focus state on info elements.
  success: colors.emerald["500"], // Used for success elements like alerts, buttons, labels, icons, etc.
  "success-focus": colors.emerald["600"], // Used for focus state on success elements.
  warning: "#ff9800", // Used for warning elements like alerts, buttons, labels, icons, etc.
  "warning-focus": "#e68200", // Used for focus state on warning elements.
  error: "#ff5724", // Used for error elements like alerts, buttons, labels, icons, etc.
  "error-focus": "#f03000", // Used for focus state on error elements.
};

module.exports = {
  content: [
    "./js/**/*.{js,ts}",
    "../lib/components/**/*.*ex",
    "../lib/components/**/*.ex",
  ],
  darkMode: "class",
  safelist: ["h-20", "h-24", "w-20", "w-24"],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Poppins", ...defaultTheme.fontFamily.sans],
        inter: ["Inter", ...defaultTheme.fontFamily.sans],
      },
      fontSize: {
        tiny: ["0.625rem", "0.8125rem"],
        "tiny+": ["0.6875rem", "0.875rem"],
        "xs+": ["0.8125rem", "1.125rem"],
        "sm+": ["0.9375rem", "1.375rem"],
      },
      colors: { ...customColors },
      opacity: {
        15: ".15",
      },
      spacing: {
        4.5: "1.125rem",
        5.5: "1.375rem",
        18: "4.5rem",
      },
      boxShadow: {
        soft: "0 3px 10px 0 rgb(48 46 56 / 6%)",
        "soft-dark": "0 3px 10px 0 rgb(25 33 50 / 30%)",
      },
      zIndex: {
        1: "1",
        2: "2",
        3: "3",
        4: "4",
        5: "5",
      },
      keyframes: {
        "fade-out": {
          "0%": {
            opacity: 1,
            visibility: "visible",
          },
          "100%": {
            opacity: 0,
            visibility: "hidden",
          },
        },
      },
      size: {
        5.5: "1.375rem",
      },
    },
  },
  corePlugins: {
    textOpacity: false,
    backgroundOpacity: false,
    borderOpacity: false,
    divideOpacity: false,
    placeholderOpacity: false,
    ringOpacity: false,
  },
  plugins: [
    require("@tailwindcss/typography"),
    plugin(({ addVariant }) =>
      addVariant("phx-no-feedback", ["&.phx-no-feedback", ".phx-no-feedback &"])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-click-loading", [
        "&.phx-click-loading",
        ".phx-click-loading &",
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-submit-loading", [
        "&.phx-submit-loading",
        ".phx-submit-loading &",
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-change-loading", [
        "&.phx-change-loading",
        ".phx-change-loading &",
      ])
    ),
    plugin(function ({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "./vendor/heroicons/optimized");
      let values = {};
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
      ];
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).map((file) => {
          let name = path.basename(file, ".svg") + suffix;
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) };
        });
      });
      matchComponents(
        {
          hero: ({ name, fullPath }) => {
            let content = fs
              .readFileSync(fullPath)
              .toString()
              .replace(/\r?\n|\r/g, "");
            return {
              [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
              "-webkit-mask": `var(--hero-${name})`,
              mask: `var(--hero-${name})`,
              "background-color": "currentColor",
              "vertical-align": "middle",
              display: "inline-block",
              width: theme("spacing.5"),
              height: theme("spacing.5"),
            };
          },
        },
        { values }
      );
    }),
    function ({ addVariant }) {
      addVariant(
        "supports-backdrop",
        "@supports ((-webkit-backdrop-filter: initial) or (backdrop-filter: initial))"
      );
    },
  ],
};
