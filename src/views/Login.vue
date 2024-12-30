<template>
  <div class="login-page">
    <div class="header">
      <h1>Login</h1>
    </div>

    <form @submit.prevent="handleLogin" class="login-form">
      <div class="form-group">
        <input 
          type="email" 
          v-model="email" 
          placeholder="Email"
          required
        >
      </div>
      
      <div class="form-group">
        <input 
          type="password" 
          v-model="password" 
          placeholder="Password"
          required
        >
      </div>

      <button type="submit" class="submit-btn">Login</button>
      
      <div class="form-footer">
        <router-link to="/register">Create an account</router-link>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: 'Login',
  data() {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    handleLogin() {
      // TODO: Implémenter la logique de connexion
      console.log('Login:', { email: this.email, password: this.password })
      this.$router.push('/')
    }
  }
}
</script>

<style scoped>
.login-page {
  min-height: 100vh;
  background-color: var(--background-primary);
  padding: 1rem;
}

.header {
  text-align: center;
  margin-bottom: 2rem;
}

.header h1 {
  color: var(--text-primary);
  font-size: 1.5rem;
}

.login-form {
  max-width: 400px;
  margin: 0 auto;
}

.form-group {
  margin-bottom: 1rem;
}

input {
  width: 100%;
  padding: 1rem;
  background-color: var(--background-secondary);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  color: var(--text-primary);
  font-size: 1rem;
}

.submit-btn {
  width: 100%;
  padding: 1rem;
  background-color: var(--accent-color);
  border: none;
  border-radius: 8px;
  color: white;
  font-size: 1rem;
  cursor: pointer;
  margin-top: 1rem;
}

.form-footer {
  text-align: center;
  margin-top: 1rem;
}

.form-footer a {
  color: var(--accent-color);
  text-decoration: none;
}
</style> 