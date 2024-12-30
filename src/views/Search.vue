<template>
  <div class="search-page">
    <div class="search-header">
      <button class="back-btn" @click="$router.go(-1)">
        <i class="fas fa-arrow-left"></i>
      </button>
      <h1>Search</h1>
      <button class="add-btn">
        <i class="fas fa-plus"></i>
      </button>
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

      <div class="network-filter">
        <button class="network-btn" @click="toggleNetworkDropdown">
          <i class="fas fa-globe"></i>
          <span>{{ selectedNetwork }}</span>
          <i class="fas fa-chevron-down"></i>
        </button>

        <!-- Network Dropdown -->
        <div v-if="showNetworkDropdown" class="network-dropdown">
          <div 
            v-for="network in networks" 
            :key="network"
            class="network-option"
            :class="{ active: network === selectedNetwork }"
            @click="selectNetwork(network)"
          >
            {{ network }}
          </div>
        </div>
      </div>

      <!-- Liste des cryptomonnaies -->
      <div class="crypto-list">
        <div v-for="crypto in filteredCryptos" :key="crypto.id" class="crypto-item">
          <div class="crypto-info">
            <img :src="crypto.icon" :alt="crypto.name" class="crypto-icon">
            <div class="crypto-details">
              <div class="crypto-name">{{ crypto.name }}</div>
              <div class="crypto-network">{{ crypto.network }}</div>
            </div>
          </div>
          <div class="toggle-wrapper">
            <label class="toggle">
              <input 
                type="checkbox" 
                :checked="crypto.enabled"
                @change="toggleCrypto(crypto)"
              >
              <span class="slider"></span>
            </label>
          </div>
        </div>
      </div>

      <div class="import-link">
        <a href="#" @click.prevent="importCrypto">Didn't see your crypto? Import</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Search',
  data() {
    return {
      searchQuery: '',
      selectedNetwork: 'All Networks',
      showNetworkDropdown: false,
      networks: ['All Networks', 'BNB Smart Chain', 'Bitcoin', 'Ethereum', 'Polygon', 'Cardano'],
      cryptos: [
        {
          id: 'bnb',
          name: 'BNB',
          network: 'BNB Smart Chain',
          icon: 'https://cryptologos.cc/logos/bnb-bnb-logo.png',
          enabled: true
        },
        {
          id: 'btc',
          name: 'BTC',
          network: 'Bitcoin',
          icon: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png',
          enabled: true
        },
        {
          id: 'eth',
          name: 'ETH',
          network: 'Ethereum',
          icon: 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
          enabled: true
        },
        {
          id: 'pol',
          name: 'POL',
          network: 'Polygon',
          icon: 'https://cryptologos.cc/logos/polygon-matic-logo.png',
          enabled: true
        },
        {
          id: 'ada',
          name: 'ADA',
          network: 'Cardano',
          icon: 'https://cryptologos.cc/logos/cardano-ada-logo.png',
          enabled: false
        }
      ]
    }
  },
  computed: {
    filteredCryptos() {
      return this.cryptos.filter(crypto => {
        const matchesSearch = 
          crypto.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
          crypto.network.toLowerCase().includes(this.searchQuery.toLowerCase())
        
        const matchesNetwork = 
          this.selectedNetwork === 'All Networks' || 
          crypto.network === this.selectedNetwork

        return matchesSearch && matchesNetwork
      })
    }
  },
  methods: {
    toggleNetworkDropdown() {
      this.showNetworkDropdown = !this.showNetworkDropdown
    },
    selectNetwork(network) {
      this.selectedNetwork = network
      this.showNetworkDropdown = false
    },
    toggleCrypto(crypto) {
      crypto.enabled = !crypto.enabled
    },
    importCrypto() {
      this.$router.push('/import-token')
    }
  },
  mounted() {
    // Fermer le dropdown quand on clique en dehors
    document.addEventListener('click', (e) => {
      if (!e.target.closest('.network-filter')) {
        this.showNetworkDropdown = false
      }
    })
  },
  beforeUnmount() {
    document.removeEventListener('click', this.closeDropdown)
  }
}
</script>

<style scoped>
.search-page {
  background-color: var(--background-primary);
  min-height: 100vh;
}

.search-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: var(--background-secondary);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.search-header h1 {
  color: var(--text-primary);
  margin: 0;
  font-size: 1.2rem;
}

.back-btn, .add-btn {
  background: none;
  border: none;
  color: var(--text-primary);
  padding: 0.5rem;
  cursor: pointer;
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

.network-filter {
  position: relative;
  margin-bottom: 1rem;
}

.network-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  color: var(--text-primary);
  padding: 0.8rem 1rem;
  border-radius: 8px;
  cursor: pointer;
  width: 100%;
  justify-content: space-between;
}

.network-btn i:last-child {
  transition: transform 0.3s;
}

.network-btn.active i:last-child {
  transform: rotate(180deg);
}

.crypto-list {
  margin-top: 1rem;
}

.crypto-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.crypto-info {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.crypto-icon {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.crypto-details {
  display: flex;
  flex-direction: column;
}

.crypto-name {
  color: var(--text-primary);
  font-weight: bold;
}

.crypto-network {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

/* Style pour le toggle switch */
.toggle {
  position: relative;
  display: inline-block;
  width: 50px;
  height: 24px;
}

.toggle input {
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(255, 255, 255, 0.1);
  transition: .4s;
  border-radius: 34px;
}

.slider:before {
  position: absolute;
  content: "";
  height: 20px;
  width: 20px;
  left: 2px;
  bottom: 2px;
  background-color: white;
  transition: .4s;
  border-radius: 50%;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:checked + .slider:before {
  transform: translateX(26px);
}

.import-link {
  text-align: center;
  margin-top: 2rem;
  padding: 1rem;
}

.import-link a {
  color: #2196F3;
  text-decoration: none;
}

.network-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  width: 200px;
  background-color: var(--background-secondary);
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
  margin-top: 0.5rem;
  z-index: 1000;
  overflow: hidden;
}

.network-option {
  padding: 0.8rem 1rem;
  cursor: pointer;
  color: var(--text-primary);
}

.network-option:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.network-option.active {
  background-color: rgba(255, 255, 255, 0.05);
}
</style> 