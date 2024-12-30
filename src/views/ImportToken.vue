<template>
  <div class="import-page">
    <div class="search-header">
      <button class="back-btn" @click="$router.go(-1)">
        <i class="fas fa-arrow-left"></i>
      </button>
      <h1>Select token network</h1>
    </div>

    <div class="search-container">
      <div class="network-list">
        <div 
          v-for="network in networks" 
          :key="network.id" 
          class="network-item"
          @click="selectNetwork(network)"
        >
          <div class="network-info">
            <img :src="network.icon" :alt="network.name" class="network-icon">
            <span class="network-name">{{ network.name }}</span>
          </div>
          <i v-if="network.selected" class="fas fa-check"></i>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ImportToken',
  data() {
    return {
      networks: [
        {
          id: 'agoric',
          name: 'Agoric',
          icon: 'path/to/agoric.png',
          selected: false
        },
        {
          id: 'akash',
          name: 'Akash',
          icon: 'path/to/akash.png',
          selected: false
        },
        {
          id: 'aptos',
          name: 'Aptos',
          icon: 'path/to/aptos.png',
          selected: false
        },
        {
          id: 'arbitrum',
          name: 'Arbitrum',
          icon: 'path/to/arbitrum.png',
          selected: false
        },
        {
          id: 'avalanche',
          name: 'Avalanche C-Chain',
          icon: 'path/to/avalanche.png',
          selected: false
        },
        {
          id: 'axelar',
          name: 'Axelar',
          icon: 'path/to/axelar.png',
          selected: false
        },
        {
          id: 'base',
          name: 'Base',
          icon: 'path/to/base.png',
          selected: false
        },
        {
          id: 'binance',
          name: 'Binance',
          icon: 'path/to/binance.png',
          selected: false
        },
        {
          id: 'bitcoin',
          name: 'Bitcoin',
          icon: 'path/to/bitcoin.png',
          selected: false
        }
      ]
    }
  },
  methods: {
    selectNetwork(network) {
      this.$router.push(`/import-token/${network.id}`)
    }
  }
}
</script>

<style scoped>
.import-page {
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

.network-list {
  display: flex;
  flex-direction: column;
}

.network-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  cursor: pointer;
  border-radius: 8px;
  margin-bottom: 0.5rem;
  background-color: var(--background-secondary);
}

.network-item:hover {
  background-color: rgba(255, 255, 255, 0.05);
}

.network-info {
  display: flex;
  align-items: center;
  gap: 1rem;
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

.fa-check {
  color: var(--accent-color);
}
</style> 