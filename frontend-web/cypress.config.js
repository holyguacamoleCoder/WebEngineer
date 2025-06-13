const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    baseUrl: 'http://localhost:8080', // 对应你的开发服务器地址
    specPattern: "cypress/e2e/**/*.cy.{js,jsx,ts,tsx}",
    supportFile: "cypress/support/commands.js",
    setupNodeEvents(on, config) {
      // 可用于注册任务或钩子
      return config;
    }
  },
});
