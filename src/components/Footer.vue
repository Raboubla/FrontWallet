<template>
  <footer class="footer">
    <nav class="footer-nav">
      <router-link to="/" class="nav-item">
        <i class="fas fa-home"></i>
        <span>Accueil</span>
      </router-link>
      <router-link to="/markets" class="nav-item">
        <i class="fas fa-chart-line"></i>
        <span>Markets</span>
      </router-link>
      <router-link to="/history" class="nav-item">
        <i class="fas fa-history"></i>
        <span>Historique</span>
      </router-link>

    </nav>
  </footer>
</template>

<script>
export default {
  name: 'Footer'
}
</script>

<style scoped>
.footer {
  position: fixed;
  bottom: 0;
  width: 100%;
  background-color: #1a1a1a;
  padding: 0.5rem 0;
}

.footer-nav {
  display: flex;
  justify-content: space-around;
  align-items: center;
}

.nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #808080;
  text-decoration: none;
  font-size: 0.8rem;
}

.nav-item.router-link-active {
  color: #00ff00;
}

.nav-item i {
  font-size: 1.2rem;
  margin-bottom: 0.2rem;
}
</style>
