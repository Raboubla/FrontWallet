<template>
  <div class="home">
    <Header />
    
    <main class="main-content">
      <div class="balance-section">
        <h1 class="balance">$0.00</h1>
        <div class="actions">
          <button class="action-btn" @click="handleSend">
            <i class="fas fa-arrow-up"></i>
            <span>Send</span>
          </button>
          <button class="action-btn" @click="$router.push('/receive')">
            <i class="fas fa-arrow-down"></i>
            <span>Receive</span>
          </button>
          <button class="action-btn">
            <i class="fas fa-exchange-alt"></i>
            <span>Swap</span>
          </button>
          <button class="action-btn" @click="$router.push('/buy')">
            <i class="fas fa-shopping-cart"></i>
            <span>Buy</span>
          </button>
        </div>
      </div>

      <div class="markets-section">
        <div class="refresh-info">
          Updates in {{ refreshCounter }}s
        </div>

        <div class="markets-list">
          <div 
            v-for="market in markets" 
            :key="market.id"
            class="market-item"
          >
            <div class="market-info">
              <img :src="market.icon" :alt="market.name" class="market-icon">
              <div class="market-details">
                <div class="market-name">{{ market.name }}</div>
                <div class="market-network">{{ market.network }}</div>
              </div>
            </div>
            <div class="market-data">
              <div class="market-price">${{ market.price.toLocaleString() }}</div>
              <div 
                class="market-change"
                :class="{ 'positive': market.change > 0, 'negative': market.change < 0 }"
              >
                {{ market.change > 0 ? '+' : ''}}{{ market.change }}%
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="tabs">
        <button 
          class="tab-btn" 
          :class="{ active: activeTab === 'crypto' }"
          @click="activeTab = 'crypto'"
        >
          Crypto
        </button>
        <button 
          class="tab-btn" 
          :class="{ active: activeTab === 'nfts' }"
          @click="activeTab = 'nfts'"
        >
          NFTs
        </button>
      </div>

      <div v-if="activeTab === 'crypto'" class="crypto-list">
        <div v-for="crypto in cryptocurrencies" :key="crypto.id" class="crypto-item">
          <div class="crypto-info">
            <img :src="crypto.icon" :alt="crypto.name" class="crypto-icon">
            <div class="crypto-details">
              <div class="crypto-name">
                <span class="symbol">{{ crypto.name }}</span>
                <span class="network">{{ crypto.fullName }}</span>
              </div>
              <div class="crypto-price">
                <span class="amount">${{ crypto.price.toLocaleString() }}</span>
                <span class="change" :class="{ 'negative': crypto.change < 0 }">
                  {{ crypto.change }}%
                </span>
              </div>
            </div>
          </div>
          <div class="crypto-balance">
            <div class="balance-amount">{{ crypto.amount }}</div>
            <div class="balance-value">${{ crypto.value }}</div>
          </div>
        </div>
      </div>

      <div v-if="activeTab === 'nfts'" class="nft-list">
        <div v-for="nft in nfts" :key="nft.id" class="nft-item">
          <img :src="nft.image" :alt="nft.name" class="nft-image">
          <div class="nft-details">
            <h3>{{ nft.name }}</h3>
            <p>Floor: {{ nft.floorPrice }} {{ nft.currency }}</p>
          </div>
        </div>
      </div>
    </main>

    <Footer />
  </div>
</template>

<script>
import Header from '@/components/Header.vue'
import Footer from '@/components/Footer.vue'
import cryptoData from '@/data/cryptocurrencies.json'
import nftData from '@/data/nfts.json'

export default {
  name: 'Home',
  components: {
    Header,
    Footer
  },
  data() {
    return {
      activeTab: 'crypto',
      cryptocurrencies: cryptoData.cryptocurrencies,
      nfts: nftData.nfts,
      refreshCounter: 10,
      markets: [
        {
          id: 'btc',
          name: 'Bitcoin',
          symbol: 'BTC',
          icon: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png',
          price: 65432.10,
          change: 2.5
        },
        {
          id: 'eth',
          name: 'Ethereum',
          symbol: 'ETH',
          icon: 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
          price: 3327.40,
          change: -0.55
        },
        {
          id: 'bnb',
          name: 'BNB',
          symbol: 'BNB',
          icon: 'https://cryptologos.cc/logos/bnb-bnb-logo.png',
          price: 693.28,
          change: -1.51
        }
      ]
    }
  },
  methods: {
    handleSend() {
      this.$router.push('/select-token')
    },
    startRefreshCounter() {
      this.refreshCounter = 10
      this.countdownInterval = setInterval(() => {
        this.refreshCounter--
        if (this.refreshCounter <= 0) {
          this.updatePrices()
        }
      }, 1000)
    },
    updatePrices() {
      this.markets.forEach(market => {
        const change = (Math.random() * 6) - 3
        market.change = parseFloat(change.toFixed(2))
        market.price = market.price * (1 + (change / 100))
      })
      this.startRefreshCounter()
    }
  },
  mounted() {
    this.startRefreshCounter()
  },
  beforeUnmount() {
    clearInterval(this.countdownInterval)
  }
}
</script>

<style scoped>
.home {
  min-height: 100vh;
  background-color: var(--background-primary);
  color: var(--text-primary);
}

.main-content {
  padding: 1rem;
  margin-bottom: 4rem;
}

.balance-section {
  text-align: center;
  margin: 2rem 0;
}

.balance {
  font-size: 2.5rem;
  margin-bottom: 2rem;
  color: var(--text-primary);
}

.actions {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1rem;
}

.action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  background: none;
  border: none;
  color: var(--text-primary);
  cursor: pointer;
}

.action-btn i {
  font-size: 1.5rem;
  margin-bottom: 0.5rem;
  background-color: var(--background-secondary);
  padding: 1rem;
  border-radius: 50%;
  transition: background-color 0.2s;
}

.action-btn:hover i {
  background-color: var(--accent-color);
}

.action-btn span {
  font-size: 0.9rem;
  color: var(--text-secondary);
}

.tabs {
  display: flex;
  margin: 2rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.tab-btn {
  background: none;
  border: none;
  color: var(--text-secondary);
  padding: 0.5rem 1rem;
  cursor: pointer;
  position: relative;
}

.tab-btn.active {
  color: var(--text-primary);
}

.tab-btn.active::after {
  content: '';
  position: absolute;
  bottom: -1px;
  left: 0;
  width: 100%;
  height: 2px;
  background-color: var(--accent-color);
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
  display: flex;
  flex-direction: column;
}

.symbol {
  font-weight: bold;
  color: var(--text-primary);
}

.network {
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.crypto-price {
  display: flex;
  flex-direction: column;
}

.amount {
  color: var(--text-primary);
}

.change {
  font-size: 0.8rem;
  color: #00ff00;
}

.change.negative {
  color: #ff0000;
}

.crypto-balance {
  text-align: right;
}

.balance-amount {
  color: var(--text-primary);
  font-weight: bold;
}

.balance-value {
  color: var(--text-secondary);
  font-size: 0.8rem;
}

.nft-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 1rem;
  padding: 1rem;
}

.nft-item {
  background: var(--background-secondary);
  border-radius: 12px;
  overflow: hidden;
}

.nft-image {
  width: 100%;
  aspect-ratio: 1;
  object-fit: cover;
}

.nft-details {
  padding: 0.5rem;
}

.nft-details h3 {
  margin: 0;
  font-size: 0.9rem;
  color: var(--text-primary);
}

.nft-details p {
  margin: 0.25rem 0 0;
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.markets-section {
  margin: 1rem 0;
  padding: 0 1rem;
}

.refresh-info {
  color: var(--text-secondary);
  font-size: 0.8rem;
  text-align: right;
  margin-bottom: 0.5rem;
}

.markets-list {
  background-color: var(--background-secondary);
  border-radius: 12px;
  overflow: hidden;
}

.market-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.market-item:last-child {
  border-bottom: none;
}

.market-info {
  display: flex;
  align-items: center;
  gap: 0.8rem;
}

.market-icon {
  width: 32px;
  height: 32px;
  border-radius: 50%;
}

.market-details {
  display: flex;
  flex-direction: column;
}

.market-name {
  color: var(--text-primary);
  font-weight: 500;
  font-size: 0.9rem;
}

.market-network {
  color: var(--text-secondary);
  font-size: 0.8rem;
}

.market-data {
  text-align: right;
}

.market-price {
  color: var(--text-primary);
  font-weight: 500;
  font-size: 0.9rem;
}

.market-change {
  font-size: 0.8rem;
}

.market-change.positive {
  color: #00ff00;
}

.market-change.negative {
  color: #ff0000;
}
</style>
