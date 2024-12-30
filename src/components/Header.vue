<template>
  <header class="header">
    <div class="header-left">
      <!-- Mnemonic Selector -->
      <div class="wallet-selector" @click="toggleWalletMenu">
        <img src="@/assets/logo.png" alt="Wallet" class="wallet-icon">
        <span class="wallet-name">{{ selectedWallet }}</span>
        <i class="fas fa-chevron-down"></i>
      </div>
      
      <!-- Menu Wallet -->
      <div v-if="showWalletMenu" class="wallet-menu">
        <div class="wallet-item selected">
          <img src="@/assets/logo.svg" alt="Mnemonic 1" class="wallet-icon">
          <span>Mnemonic 1</span>
          <i class="fas fa-check"></i>
        </div>
        <div class="wallet-actions">
          <button class="action-btn" @click="addNewWallet">
            <i class="fas fa-plus"></i>
            Add new wallet
          </button>
          <button class="action-btn" @click="manageWallets">
            <i class="fas fa-cog"></i>
            Manage wallets
          </button>
        </div>
      </div>
    </div>

    <div class="header-right">
      <!-- Network Selector -->
      <button class="header-btn network-btn" @click="toggleNetworkMenu">
        <i class="fas fa-globe"></i>
      </button>
      
      <!-- Network Menu -->
      <div v-if="showNetworkMenu" class="network-menu">
        <div class="network-search">
          <i class="fas fa-search"></i>
          <input type="text" placeholder="Search networks" v-model="networkSearch">
        </div>
        <div class="network-list">
          <div 
            v-for="network in filteredNetworks" 
            :key="network.id"
            class="network-item"
            :class="{ active: network.id === selectedNetwork }"
            @click="selectNetwork(network)"
          >
            <img :src="network.icon" :alt="network.name">
            <span>{{ network.name }}</span>
            <i v-if="network.id === selectedNetwork" class="fas fa-check"></i>
          </div>
        </div>
      </div>

      <button class="header-btn" @click="toggleSearch">
        <i class="fas fa-search"></i>
      </button>
      <button class="action-btn" @click="$router.push('/profile')">
      <i class="fas fa-user"></i> 
      </button>
      <button class="header-btn" @click="toggleMenu">
        <i class="fas fa-ellipsis-v"></i>
      </button>

      <!-- Menu des 3 points -->
      <div v-if="showMenu" class="menu-dropdown">
        <div class="menu-item" @click="toggleFullscreen">
          <i class="fas fa-expand"></i>
          <span>View fullscreen</span>
        </div>
        <div class="menu-item" @click="openSupport">
          <i class="fas fa-question-circle"></i>
          <span>Support</span>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
  data() {
    return {
      selectedWallet: 'Mnemonic 1',
      selectedNetwork: 'arbitrum',
      showWalletMenu: false,
      showNetworkMenu: false,
      showMenu: false,
      networkSearch: '',
      networks: [
        { id: 'arbitrum', name: 'Arbitrum', icon: '', active: true },
        { id: 'aurora', name: 'Aurora', icon: '' },
        { id: 'avalanche', name: 'Avalanche C-Chain', icon: '' },
        { id: 'base', name: 'Base', icon: '' },
        { id: 'blast', name: 'Blast', icon: '' },
        { id: 'boba', name: 'Boba', icon: '' }
      ]
    }
  },
  computed: {
    filteredNetworks() {
      return this.networks.filter(network => 
        network.name.toLowerCase().includes(this.networkSearch.toLowerCase())
      )
    }
  },
  methods: {
    toggleWalletMenu() {
      this.showWalletMenu = !this.showWalletMenu
      this.showNetworkMenu = false
      this.showMenu = false
    },
    toggleNetworkMenu() {
      this.showNetworkMenu = !this.showNetworkMenu
      this.showWalletMenu = false
      this.showMenu = false
    },
    toggleMenu() {
      this.showMenu = !this.showMenu
      this.showWalletMenu = false
      this.showNetworkMenu = false
    },
    selectNetwork(network) {
      this.selectedNetwork = network.id
      this.showNetworkMenu = false
    },
    addNewWallet() {
      // Implémenter l'ajout d'un nouveau wallet
    },
    manageWallets() {
      // Implémenter la gestion des wallets
    },
    toggleSearch() {
      this.$router.push('/search')
    },
    copyAddress() {
      // Implémenter la copie d'adresse
    },
    toggleFullscreen() {
      if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen()
      } else {
        document.exitFullscreen()
      }
      this.showMenu = false
    },
    openSupport() {
      window.open('https://support.trustwallet.com', '_blank')
      this.showMenu = false
    }
  }
}
</script>

<style scoped>
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: var(--background-secondary);
  color: var(--text-primary);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
}

.header-left {
  position: relative;
}

.wallet-selector {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
  padding: 0.5rem;
  border-radius: 8px;
  background-color: rgba(255, 255, 255, 0.1);
}

.wallet-icon {
  width: 24px;
  height: 24px;
  border-radius: 50%;
}

.wallet-menu {
  position: absolute;
  top: 100%;
  left: 0;
  width: 280px;
  background-color: var(--background-secondary);
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
  margin-top: 0.5rem;
  z-index: 1000;
  overflow: hidden;
}

.wallet-item {
  display: flex;
  align-items: center;
  gap: 0.8rem;
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.wallet-item.selected {
  background-color: rgba(255, 255, 255, 0.05);
}

.wallet-actions {
  padding: 0.5rem;
}

.action-btn {
  display: flex;
  align-items: center;
  gap: 0.8rem;
  width: 100%;
  padding: 0.8rem 1rem;
  background: none;
  border: none;
  color: var(--text-primary);
  cursor: pointer;
  text-align: left;
}

.action-btn:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.network-menu {
  position: absolute;
  top: 100%;
  right: 0;
  width: 280px;
  background-color: var(--background-secondary);
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
  margin-top: 0.5rem;
  z-index: 1000;
}

.network-search {
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
}

.network-search input {
  width: 100%;
  padding: 0.5rem 2rem;
  border-radius: 8px;
  border: none;
  background-color: rgba(255, 255, 255, 0.1);
  color: var(--text-primary);
}

.network-search i {
  position: absolute;
  left: 1.5rem;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-secondary);
}

.network-list {
  max-height: 400px;
  overflow-y: auto;
}

.network-item {
  display: flex;
  align-items: center;
  gap: 0.8rem;
  padding: 0.8rem 1rem;
  cursor: pointer;
}

.network-item.active {
  background-color: rgba(255, 255, 255, 0.05);
}

.network-item:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.header-right {
  display: flex;
  gap: 0.5rem;
  position: relative;
}

.header-btn {
  background: none;
  border: none;
  color: var(--text-primary);
  padding: 0.5rem;
  border-radius: 50%;
  cursor: pointer;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.header-btn:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.menu-dropdown {
  position: absolute;
  top: 100%;
  right: 0;
  width: 200px;
  background-color: var(--background-secondary);
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
  margin-top: 0.5rem;
  z-index: 1000;
}

.menu-item {
  display: flex;
  align-items: center;
  gap: 0.8rem;
  padding: 0.8rem 1rem;
  cursor: pointer;
}

.menu-item:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

/* Styles pour la barre de défilement personnalisée */
.network-list::-webkit-scrollbar {
  width: 6px;
}

.network-list::-webkit-scrollbar-track {
  background: transparent;
}

.network-list::-webkit-scrollbar-thumb {
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 3px;
}
</style> 