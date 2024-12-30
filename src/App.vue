<template>
  <div id="app">
    <router-view></router-view>

  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
:root {
  --background-primary: #0d1117;
  --background-secondary: #161b22;
  --text-primary: #ffffff;
  --text-secondary: #8b949e;
  --accent-color: #1a88f8;
}

#app {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: var(--background-primary);
  min-height: 100vh;
  color: var(--text-primary);
}

body {
  margin: 0;
  padding: 0;
  background-color: var(--background-primary);
}

* {
  box-sizing: border-box;
}
</style>
