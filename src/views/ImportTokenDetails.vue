<template>
  <div class="import-details-page">
    <div class="search-header">
      <button class="back-btn" @click="$router.go(-1)">
        <i class="fas fa-arrow-left"></i>
      </button>
      <h1>Import token</h1>
    </div>

    <div class="import-container">
      <div class="network-info">
        <img :src="networkIcon" :alt="networkName" class="network-icon">
        <span class="network-name">{{ networkName }}</span>
      </div>

      <div class="form-group">
        <label>Token Contract Address</label>
        <input 
          type="text" 
          v-model="contractAddress"
          placeholder="0x..."
          class="form-input"
        >
      </div>

      <div class="token-info" v-if="tokenInfo">
        <div class="info-row">
          <span class="label">Name</span>
          <span class="value">{{ tokenInfo.name }}</span>
        </div>
        <div class="info-row">
          <span class="label">Symbol</span>
          <span class="value">{{ tokenInfo.symbol }}</span>
        </div>
        <div class="info-row">
          <span class="label">Decimals</span>
          <span class="value">{{ tokenInfo.decimals }}</span>
        </div>
      </div>

      <div class="warning" v-if="showWarning">
        <i class="fas fa-exclamation-triangle"></i>
        <p>Anyone can create a token, including creating fake versions of existing tokens. Learn about scams and security risks.</p>
      </div>

      <button 
        class="import-btn"
        :disabled="!isValidAddress"
        @click="importToken"
      >
        Import
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ImportTokenDetails',
  data() {
    return {
      contractAddress: '',
      networkName: '',
      networkIcon: '',
      tokenInfo: null,
      showWarning: false,
      networks: {
        agoric: { name: 'Agoric', icon: 'path/to/agoric.png' },
        akash: { name: 'Akash', icon: 'path/to/akash.png' },
        aptos: { name: 'Aptos', icon: 'path/to/aptos.png' },
        arbitrum: { name: 'Arbitrum', icon: 'path/to/arbitrum.png' },
        avalanche: { name: 'Avalanche C-Chain', icon: 'path/to/avalanche.png' },
        axelar: { name: 'Axelar', icon: 'path/to/axelar.png' },
        base: { name: 'Base', icon: 'path/to/base.png' },
        binance: { name: 'Binance', icon: 'path/to/binance.png' },
        bitcoin: { name: 'Bitcoin', icon: 'path/to/bitcoin.png' }
      }
    }
  },
  computed: {
    isValidAddress() {
      return this.contractAddress.length > 0
    }
  },
  methods: {
    async importToken() {
      // Implémenter la logique d'import du token
      console.log('Importing token:', this.contractAddress)
    },
    async fetchTokenInfo() {
      // Simuler la récupération des informations du token
      if (this.isValidAddress) {
        this.tokenInfo = {
          name: 'Example Token',
          symbol: 'EXT',
          decimals: 18
        }
        this.showWarning = true
      }
    }
  },
  watch: {
    contractAddress() {
      this.fetchTokenInfo()
    }
  },
  created() {
    const networkId = this.$route.params.network
    const network = this.networks[networkId]
    if (network) {
      this.networkName = network.name
      this.networkIcon = network.icon
    }
  }
}
</script>

<style scoped>
.import-details-page {
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

.import-container {
  padding: 1rem;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.network-info {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background-color: var(--background-secondary);
  border-radius: 8px;
}

.network-icon {
  width: 32px;
  height: 32px;
  border-radius: 50%;
}

.network-name {
  color: var(--text-primary);
  font-size: 1rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.form-group label {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.form-input {
  width: 100%;
  padding: 1rem;
  background-color: var(--background-secondary);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  color: var(--text-primary);
  font-size: 1rem;
}

.token-info {
  background-color: var(--background-secondary);
  border-radius: 8px;
  padding: 1rem;
}

.info-row {
  display: flex;
  justify-content: space-between;
  padding: 0.5rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.info-row:last-child {
  border-bottom: none;
}

.label {
  color: var(--text-secondary);
}

.value {
  color: var(--text-primary);
}

.warning {
  display: flex;
  gap: 1rem;
  padding: 1rem;
  background-color: rgba(255, 193, 7, 0.1);
  border-radius: 8px;
  color: #ffc107;
}

.warning i {
  font-size: 1.2rem;
}

.warning p {
  margin: 0;
  font-size: 0.9rem;
}

.import-btn {
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

.import-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.import-btn:not(:disabled):hover {
  opacity: 0.9;
}
</style> 