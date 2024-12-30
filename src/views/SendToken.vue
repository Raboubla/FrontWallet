<template>
  <div class="send-token-page">
    <div class="search-header">
      <button class="back-btn" @click="$router.go(-1)">
        <i class="fas fa-arrow-left"></i>
      </button>
      <h1>Send {{ token?.name || 'Token' }}</h1>
    </div>

    <div class="send-container">
      <div class="amount-section">
        <div class="token-info">
          <img :src="token?.icon" :alt="token?.name" class="token-icon">
          <span class="token-name">{{ token?.name }}</span>
          <span class="token-balance">Balance: {{ token?.amount }}</span>
        </div>
        
        <div class="amount-input">
          <input 
            type="number" 
            v-model="amount" 
            placeholder="0"
            class="token-amount"
          >
          <div class="amount-value">${{ (amount * (token?.price || 0)).toFixed(2) }}</div>
        </div>

        <button class="max-btn" @click="setMaxAmount">MAX</button>
      </div>

      <div class="recipient-section">
        <label>Send to</label>
        <input 
          type="text" 
          v-model="recipient" 
          placeholder="Wallet address or ENS"
          class="recipient-input"
        >
      </div>

      <div class="network-warning" v-if="showNetworkWarning">
        <i class="fas fa-exclamation-triangle"></i>
        <p>Make sure the recipient address supports {{ token?.network }}</p>
      </div>

      <button 
        class="send-btn"
        :disabled="!isValidForm"
        @click="sendToken"
      >
        Continue
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SendToken',
  data() {
    return {
      amount: '',
      recipient: '',
      showNetworkWarning: true,
      tokens: {
        bnb: {
          name: 'BNB',
          network: 'BNB Smart Chain',
          icon: 'https://cryptologos.cc/logos/bnb-bnb-logo.png',
          amount: '0',
          price: 695.67
        },
        eth: {
          name: 'ETH',
          network: 'Ethereum',
          icon: 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
          amount: '0',
          price: 3333.43
        },
        pol: {
          name: 'POL',
          network: 'Polygon',
          icon: 'https://cryptologos.cc/logos/polygon-matic-logo.png',
          amount: '0',
          price: 0.45
        },
        twt: {
          name: 'TWT',
          network: 'BNB Smart Chain',
          icon: 'https://cryptologos.cc/logos/trust-wallet-token-twt-logo.png',
          amount: '0',
          price: 1.14
        }
      }
    }
  },
  computed: {
    token() {
      return this.tokens[this.$route.params.tokenId]
    },
    isValidForm() {
      return this.amount > 0 && this.recipient.length > 0
    }
  },
  methods: {
    setMaxAmount() {
      this.amount = this.token?.amount || 0
    },
    sendToken() {
      console.log('Sending token:', {
        token: this.token?.name,
        amount: this.amount,
        recipient: this.recipient
      })
    }
  }
}
</script>

<style scoped>
.send-token-page {
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

.send-container {
  padding: 1rem;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.amount-section {
  background-color: var(--background-secondary);
  border-radius: 12px;
  padding: 1rem;
  position: relative;
}

.token-info {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.token-icon {
  width: 24px;
  height: 24px;
  border-radius: 50%;
}

.token-name {
  color: var(--text-primary);
  font-weight: bold;
}

.token-balance {
  color: var(--text-secondary);
  font-size: 0.9rem;
  margin-left: auto;
}

.amount-input {
  text-align: center;
  margin: 1rem 0;
}

.token-amount {
  width: 100%;
  background: none;
  border: none;
  color: var(--text-primary);
  font-size: 2rem;
  text-align: center;
  outline: none;
}

.amount-value {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.max-btn {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  color: var(--accent-color);
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  cursor: pointer;
}

.recipient-section {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.recipient-section label {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.recipient-input {
  width: 100%;
  padding: 1rem;
  background-color: var(--background-secondary);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  color: var(--text-primary);
  font-size: 1rem;
}

.network-warning {
  display: flex;
  gap: 1rem;
  padding: 1rem;
  background-color: rgba(255, 193, 7, 0.1);
  border-radius: 8px;
  color: #ffc107;
}

.network-warning i {
  font-size: 1.2rem;
}

.network-warning p {
  margin: 0;
  font-size: 0.9rem;
}

.send-btn {
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

.send-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.send-btn:not(:disabled):hover {
  opacity: 0.9;
}
</style> 