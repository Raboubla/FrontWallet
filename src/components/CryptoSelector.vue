<template>
  <div class="modal-page">
    <div class="modal-header">
      <button class="close-btn" @click="$emit('close')">
        <i class="fas fa-times"></i>
      </button>
      <h2>Choose crypto</h2>
    </div>

    <div class="search-container">
      <div class="search-input">
        <i class="fas fa-search"></i>
        <input 
          type="text" 
          placeholder="Search for a supported currency"
          v-model="search"
        >
      </div>
    </div>

    <div class="section-title">Popular</div>
    <div class="crypto-list">
      <div 
        v-for="crypto in popularCryptos" 
        :key="crypto.id"
        class="crypto-item"
        @click="selectCrypto(crypto)"
      >
        <div class="crypto-info">
          <img :src="crypto.icon" :alt="crypto.name" class="crypto-icon">
          <div class="crypto-details">
            <span class="crypto-name">{{ crypto.name }}</span>
            <span class="crypto-network">{{ crypto.network }}</span>
          </div>
        </div>
        <i v-if="crypto.id === selectedId" class="fas fa-check"></i>
      </div>
    </div>

    <div class="section-title">Other currencies</div>
    <div class="crypto-list">
      <div 
        v-for="crypto in otherCryptos" 
        :key="crypto.id"
        class="crypto-item"
        @click="selectCrypto(crypto)"
      >
        <div class="crypto-info">
          <img :src="crypto.icon" :alt="crypto.name" class="crypto-icon">
          <div class="crypto-details">
            <span class="crypto-name">{{ crypto.name }}</span>
            <span class="crypto-network">{{ crypto.network }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CryptoSelector',
  props: {
    selectedId: String
  },
  data() {
    return {
      search: '',
      popularCryptos: [
        {
          id: 'btc',
          name: 'BTC',
          network: 'Bitcoin',
          icon: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png'
        },
        {
          id: 'sol',
          name: 'SOL',
          network: 'Solana',
          icon: 'https://cryptologos.cc/logos/solana-sol-logo.png'
        },
        {
          id: 'eth',
          name: 'ETH',
          network: 'Ethereum',
          icon: 'https://cryptologos.cc/logos/ethereum-eth-logo.png'
        },
        {
          id: 'bnb',
          name: 'BNB',
          network: 'BNB Smart Chain',
          icon: 'https://cryptologos.cc/logos/bnb-bnb-logo.png'
        }
      ],
      otherCryptos: [
        {
          id: 'ada',
          name: 'ADA',
          network: 'Cardano',
          icon: 'https://cryptologos.cc/logos/cardano-ada-logo.png'
        }
      ]
    }
  },
  methods: {
    selectCrypto(crypto) {
      this.$emit('select', crypto)
    }
  }
}
</script>

<style scoped>
.modal-page {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #1a1a1a;
  z-index: 1000;
  font-size: 14px;
}

.modal-header {
  display: flex;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  height: 56px;
}

.close-btn {
  position: absolute;
  left: 16px;
  background: none;
  border: none;
  color: #fff;
  font-size: 18px;
  cursor: pointer;
}

.modal-header h2 {
  flex: 1;
  text-align: center;
  margin: 0;
  color: #fff;
  font-size: 16px;
  font-weight: 500;
}

.search-container {
  padding: 12px 16px;
}

.search-input {
  position: relative;
}

.search-input input {
  width: 100%;
  padding: 12px 40px;
  background-color: #2c2c2e;
  border: none;
  border-radius: 8px;
  color: #fff;
  font-size: 14px;
}

.search-input i {
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: #666;
}

.section-title {
  padding: 8px 16px;
  color: #666;
  font-size: 13px;
}

.crypto-list {
  padding: 0 16px;
}

.crypto-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  cursor: pointer;
  color: #fff;
}

.crypto-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.crypto-icon {
  width: 24px;
  height: 24px;
  border-radius: 50%;
}

.crypto-details {
  display: flex;
  flex-direction: column;
}

.crypto-name {
  font-weight: 500;
}

.crypto-network {
  color: #666;
  font-size: 12px;
}

.fa-check {
  color: #0f0;
}
</style> 