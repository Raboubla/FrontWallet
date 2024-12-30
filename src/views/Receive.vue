<template>
  <div class="receive-page">
    <Header />

    <div v-if="!selectedToken" class="token-selector">
      <div class="search-container">
        <i class="fas fa-search"></i>
        <input 
          type="text" 
          v-model="searchQuery"
          placeholder="Token name or contract address"
        >
      </div>

      <div class="tokens-list">
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
            <div class="balance-value">${{ token.value }}</div>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="qr-section">
      <div class="qr-container">
        <div class="qr-code">
          <!-- Utiliser une bibliothèque QR code ici -->
          <img :src="generateQRCode(walletAddress)" alt="QR Code">
        </div>
        <div class="address-container">
          <p class="address">{{ walletAddress }}</p>
          <button class="copy-btn" @click="copyAddress">
            <i class="fas fa-copy"></i>
            Copy
          </button>
        </div>
      </div>
      
      <div class="warning">
        <i class="fas fa-exclamation-triangle"></i>
        <p>Envoyez uniquement  {{ selectedToken.name }} ({{ selectedToken.network }}) à cette adresse. L’envoi d’autres pièces peut entraîner une perte permanente.</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Receive',
  data() {
    return {
      searchQuery: '',
      selectedToken: null,
      walletAddress: '0x742d35Cc6634C0532925a3b844Bc454e4438f44e',
      tokens: [
        {
          id: 'bnb',
          name: 'BNB',
          network: 'BNB Smart Chain',
          icon: 'path/to/bnb.png',
          amount: '0',
          value: '0.00'
        },
        {
          id: 'eth',
          name: 'ETH',
          network: 'Ethereum',
          icon: 'path/to/eth.png',
          amount: '0',
          value: '0.00'
        }
        // ... autres tokens
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
      this.selectedToken = token
    },
    generateQRCode(address) {
      // Implémenter la génération du QR code
      return `https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${address}`
    },
    copyAddress() {
      navigator.clipboard.writeText(this.walletAddress)
      // Ajouter une notification de succès
    }
  }
}
</script>

<style scoped>
.receive-page {
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

.search-container {
  position: relative;
  padding: 1rem;
}

.search-container input {
  width: 100%;
  padding: 1rem 1rem 1rem 2.5rem;
  background-color: var(--background-secondary);
  border: none;
  border-radius: 8px;
  color: var(--text-primary);
  font-size: 1rem;
}

.search-container i {
  position: absolute;
  left: 2rem;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-secondary);
}

.tokens-list {
  padding: 0 1rem;
}

.token-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  cursor: pointer;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
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

.token-name {
  color: var(--text-primary);
  font-weight: 500;
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
  font-weight: 500;
}

.balance-value {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.qr-section {
  padding: 2rem 1rem;
  text-align: center;
}

.qr-container {
  background-color: white;
  padding: 2rem;
  border-radius: 12px;
  margin-bottom: 2rem;
  display: inline-block;
}

.qr-code {
  width: 200px;
  height: 200px;
  margin: 0 auto 1rem;
}

.qr-code img {
  width: 100%;
  height: 100%;
}

.address-container {
  margin-top: 1rem;
}

.address {
  color: var(--text-primary);
  font-size: 0.9rem;
  word-break: break-all;
  margin-bottom: 0.5rem;
}

.copy-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin: 0 auto;
  padding: 0.5rem 1rem;
  background-color: var(--accent-color);
  border: none;
  border-radius: 8px;
  color: white;
  cursor: pointer;
}

.warning {
  display: flex;
  align-items: center;
  gap: 1rem;
  background-color: rgba(255, 193, 7, 0.1);
  padding: 1rem;
  border-radius: 8px;
  margin-top: 2rem;
}

.warning i {
  color: #ffc107;
  font-size: 1.2rem;
}

.warning p {
  color: var(--text-primary);
  font-size: 0.9rem;
  margin: 0;
}
</style> 