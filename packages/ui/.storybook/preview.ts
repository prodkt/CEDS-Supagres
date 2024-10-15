import type { Preview } from "@storybook/react";

import "@prodkt/tailwind/index.scss";
import "@prodkt/tailwind/global.scss";
import "@prodkt/tailwind/base.scss";

const preview: Preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
  },
};

export default preview;
