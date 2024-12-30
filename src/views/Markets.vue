<template>
  <div class="markets-page">
    <Header />
    <div class="search-container">
      <div class="search-input">
        <i class="fas fa-search"></i>
        <input 
          type="text" 
          v-model="searchQuery"
          placeholder="Search"
        >
      </div>
    </div>

    <div class="markets-list">
      <div 
        v-for="market in filteredMarkets" 
        :key="market.id"
        class="market-item"
      >
        <div class="market-info">
          <img :src="market.icon" :alt="market.name" class="market-icon">
          <div class="market-details">
            <span class="market-name">{{ market.name }}</span>
            <span class="market-symbol">{{ market.symbol }}</span>
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
  <Footer />
</template>

<script>
import Footer from '@/components/Footer.vue'
import Header from '@/components/Header.vue'
export default {
  name: 'Markets',
  components:{
    Footer,
    Header
  },
  data() {
    return {
      searchQuery: '',
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
  computed: {
    filteredMarkets() {
      const query = this.searchQuery.toLowerCase()
      return this.markets.filter(market => 
        market.name.toLowerCase().includes(query) ||
        market.symbol.toLowerCase().includes(query)
      )
    }
  },
  methods: {
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
      // Simuler la mise à jour des prix
      this.markets.forEach(market => {
        const change = (Math.random() * 6) - 3 // Change entre -3% et +3%
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
.markets-page {
  background-color: #1a1a1a;
  min-height: 100vh;
  padding-bottom: 60px;
}

.header {
  padding: 1rem;
  text-align: center;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.header h1 {
  margin: 0;
  color: #fff;
  font-size: 1.2rem;
  font-weight: 500;
}

.refresh-info {
  color: #666;
  font-size: 0.9rem;
  margin-top: 0.5rem;
}

.search-container {
  padding: 1rem;
}

.search-input {
  position: relative;
}

.search-input input {
  width: 100%;
  padding: 0.8rem 2.5rem;
  background-color: #2c2c2e;
  border: none;
  border-radius: 8px;
  color: #fff;
  font-size: 1rem;
}

.search-input i {
  position: absolute;
  left: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: #666;
}

.markets-list {
  padding: 0 1rem;
}

.market-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.market-info {
  display: flex;
  align-items: center;
  gap: 1rem;
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
  color: #fff;
  font-weight: 500;
}

.market-symbol {
  color: #666;
  font-size: 0.9rem;
}

.market-data {
  text-align: right;
}

.market-price {
  color: #fff;
  font-weight: 500;
}

.market-change {
  font-size: 0.9rem;
}

.market-change.positive {
  color: #00ff00;
}

.market-change.negative {
  color: #ff0000;
}
</style> 