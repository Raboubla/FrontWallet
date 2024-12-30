<template>
  <div class="select-token-page">
    <div class="search-header">
      <button class="back-btn" @click="$router.go(-1)">
        <i class="fas fa-arrow-left"></i>
      </button>
      <h1>Select Token To Send</h1>
    </div>

    <div class="search-container">
      <div class="search-input-wrapper">
        <i class="fas fa-search search-icon"></i>
        <input 
          type="text" 
          class="search-input" 
          placeholder="Token name or contract address"
          v-model="searchQuery"
          autofocus
        >
      </div>

      <div class="token-list">
        <div 
          v-for="token in filteredTokens" 
          :key="token.id"
          class="token-item"
          @click="selectToken(token)"
        >
          <div class="token-info">
            <img :src="token.icon" :alt="token.name" class="token-icon">
            <div class="token-details">
              <div class="token-name">{{ token.name }}</div>
              <div class="token-network">{{ token.network }}</div>
            </div>
          </div>
          <div class="token-balance">
            <div class="balance-amount">{{ token.amount }}</div>
            <div class="balance-value">${{ token.value.toFixed(2) }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SelectToken',
  data() {
    return {
      searchQuery: '',
      tokens: [
        {
          id: 'bnb',
          name: 'BNB',
          network: 'BNB Smart Chain',
          icon: 'https://cryptologos.cc/logos/bnb-bnb-logo.png',
          amount: '0',
          price: 695.67,
          value: 0.00,
          change: -1.44
        },
        {
          id: 'eth',
          name: 'ETH',
          network: 'Ethereum',
          icon: 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
          amount: '0',
          price: 3333.43,
          value: 0.00,
          change: -0.39
        },
        {
          id: 'pol',
          name: 'POL',
          network: 'Polygon',
          icon: 'https://cryptologos.cc/logos/polygon-matic-logo.png',
          amount: '0',
          price: 0.45,
          value: 0.00,
          change: -4.55
        },
        {
          id: 'twt',
          name: 'TWT',
          network: 'BNB Smart Chain',
          icon: 'https://cryptologos.cc/logos/trust-wallet-token-twt-logo.png',
          amount: '0',
          price: 1.14,
          value: 0.00,
          change: -2.07
        }
      ]
    }
  },
  computed: {
    filteredTokens() {
      return this.tokens.filter(token => 
        token.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        token.network.toLowerCase().includes(this.searchQuery.toLowerCase())
      )
    }
  },
  methods: {
    selectToken(token) {
      this.$router.push(`/send/${token.id}`)
    }
  }
}
</script>

<style scoped>
.select-token-page {
  background-color: var(--background-primary);
  min-height: 100vh;
}

.search-header {
  display: flex;
  align-items: center;
  padding: 1rem;
  background-color: var(--background-secondary);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.search-header h1 {
  color: var(--text-primary);
  margin: 0 auto;
  font-size: 1.2rem;
}

.back-btn {
  background: none;
  border: none;
  color: var(--text-primary);
  padding: 0.5rem;
  cursor: pointer;
  position: absolute;
}

.search-container {
  padding: 1rem;
}

.search-input-wrapper {
  position: relative;
  margin-bottom: 1rem;
}

.search-input {
  width: 100%;
  padding: 0.8rem 2.5rem;
  background-color: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 8px;
  color: var(--text-primary);
  font-size: 1rem;
}

.search-icon {
  position: absolute;
  left: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-secondary);
}

.token-list {
  margin-top: 1rem;
}

.token-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  cursor: pointer;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.token-item:hover {
  background-color: rgba(255, 255, 255, 0.05);
}

.token-info {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.token-icon {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.token-details {
  display: flex;
  flex-direction: column;
}

.token-name {
  color: var(--text-primary);
  font-weight: bold;
}

.token-network {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.token-balance {
  text-align: right;
}

.balance-amount {
  color: var(--text-primary);
  font-weight: bold;
}

.balance-value {
  color: var(--text-secondary);
  font-size: 0.9rem;
}
</style> 