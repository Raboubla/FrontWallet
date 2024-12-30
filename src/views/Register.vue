<template>
  <div class="register-page">
    <div class="header">
      <button class="back-btn" @click="$router.push('/login')">
        <i class="fas fa-arrow-left"></i>
      </button>
      <h1>Create Account</h1>
    </div>

    <div class="register-content">
      <div class="welcome-text">
        <h2>Welcome to Trust Wallet</h2>
        <p>Create an account to get started</p>
      </div>

      <form @submit.prevent="handleRegister" class="register-form">
        <div class="form-group">
          <div class="input-icon">
            <i class="fas fa-user"></i>
          </div>
          <input 
            type="text" 
            v-model="username" 
            placeholder="Username"
            required
          >
        </div>

        <div class="form-group">
          <div class="input-icon">
            <i class="fas fa-envelope"></i>
          </div>
          <input 
            type="email" 
            v-model="email" 
            placeholder="Email"
            required
          >
        </div>
        
        <div class="form-group">
          <div class="input-icon">
            <i class="fas fa-lock"></i>
          </div>
          <input 
            type="password" 
            v-model="password" 
            placeholder="Password"
            required
          >
        </div>

        <div class="terms">
          <input type="checkbox" id="terms" v-model="acceptTerms" required>
          <label for="terms">I agree to the Terms of Service and Privacy Policy</label>
        </div>

        <button type="submit" class="submit-btn" :disabled="!acceptTerms">
          Create Account
        </button>
        
        <div class="form-footer">
          <span>Already have an account?</span>
          <router-link to="/login">Sign In</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Register',
  data() {
    return {
      username: '',
      email: '',
      password: '',
      acceptTerms: false
    }
  },
  methods: {
    handleRegister() {
      if (!this.acceptTerms) {
        alert('Please accept the terms and conditions')
        return
      }
      console.log('Register:', { 
        username: this.username,
        email: this.email, 
        password: this.password 
      })
      this.$router.push('/login')
    }
  }
}
</script>

<style scoped>
.register-page {
  min-height: 100vh;
  background-color: var(--background-primary);
}

.header {
  display: flex;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.back-btn {
  background: none;
  border: none;
  color: var(--text-primary);
  font-size: 1.2rem;
  cursor: pointer;
  padding: 0.5rem;
}

.header h1 {
  flex: 1;
  text-align: center;
  margin: 0;
  color: var(--text-primary);
  font-size: 1.2rem;
}

.register-content {
  padding: 2rem 1rem;
  max-width: 400px;
  margin: 0 auto;
}

.welcome-text {
  text-align: center;
  margin-bottom: 2rem;
}

.welcome-text h2 {
  color: var(--text-primary);
  font-size: 1.5rem;
  margin-bottom: 0.5rem;
}

.welcome-text p {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.form-group {
  position: relative;
  margin-bottom: 1rem;
}

.input-icon {
  position: absolute;
  left: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-secondary);
}

input[type="text"],
input[type="email"],
input[type="password"] {
  width: 100%;
  padding: 1rem 1rem 1rem 2.5rem;
  background-color: var(--background-secondary);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  color: var(--text-primary);
  font-size: 1rem;
}

input:focus {
  outline: none;
  border-color: var(--accent-color);
}

.terms {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin: 1.5rem 0;
}

.terms label {
  color: var(--text-secondary);
  font-size: 0.8rem;
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
  transition: opacity 0.2s;
}

.submit-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.form-footer {
  text-align: center;
  margin-top: 1.5rem;
  color: var(--text-secondary);
}

.form-footer a {
  color: var(--accent-color);
  text-decoration: none;
  margin-left: 0.5rem;
}
</style> 