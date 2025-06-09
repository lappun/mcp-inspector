import react from "@vitejs/plugin-react";
import path from "path";
import { defineConfig, loadEnv } from "vite";

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), "");
  return {
    plugins: [react()],
    server: {
      host: true,
    },
    resolve: {
      alias: {
        "@": path.resolve(__dirname, "./src"),
      },
    },
    build: {
      minify: false,
      rollupOptions: {
        output: {
          manualChunks: undefined,
        },
      },
    },
    define: {
      "process.env.EXTERNAL_INSPECTOR_PROXY_ADDRESS": JSON.stringify(
        env.EXTERNAL_INSPECTOR_PROXY_ADDRESS,
      ),
      "process.env.EXTERNAL_SERVER_PORT": JSON.stringify(
        env.EXTERNAL_SERVER_PORT,
      ),
    },
  };
});
