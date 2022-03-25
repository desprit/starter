const fs = require("fs");
const path = require("path");
import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

const resolvePath = (str: string) => path.resolve(__dirname, str);

export default defineConfig({
  plugins: [vue()],
  server: {
    port: 4042,
    host: true,
    https: {
      key: fs.readFileSync("/root/data/myproject/certs/server.key"),
      cert: fs.readFileSync("/root/data/myproject/certs/server.crt")
    }
  },
  resolve: {
    alias: {
      "@": resolvePath("src")
    }
  }
});
