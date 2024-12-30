<template>
  <div class="buy-page">
    <div class="search-header">
      <button class="back-btn" @click="$router.go(-1)">
        <i class="fas fa-arrow-left"></i>
      </button>
      <div class="header-tabs">
        <button 
          class="tab-btn" 
          :class="{ active: activeTab === 'buy' }"
          @click="activeTab = 'buy'"
        >
          Buy
        </button>
        <button 
          class="tab-btn" 
          :class="{ active: activeTab === 'sell' }"
          @click="activeTab = 'sell'"
        >
          Sell
        </button>
      </div>
    </div>

    <div class="buy-container">
      <div class="amount-section">
        <div class="label">I want to spend</div>
        <div class="currency-input dark">
          <div class="currency-selector" @click="showCurrencyModal = true">
            <div class="selector-left">
              <img :src="selectedCurrency.icon" :alt="selectedCurrency.code" class="currency-icon">
              <span class="currency-code">{{ selectedCurrency.code }}</span>
            </div>
            <i class="fas fa-chevron-right"></i>
          </div>
          <input 
            type="number" 
            v-model="amount" 
            class="amount-input"
            placeholder="0"
          >
        </div>
      </div>

      <div class="crypto-section">
        <div class="label">I will buy</div>
        <div class="currency-input dark">
          <div class="currency-selector" @click="showCryptoModal = true">
            <div class="selector-left">
              <img :src="selectedCrypto.icon" :alt="selectedCrypto.name" class="currency-icon">
              <div class="crypto-info">
                <span class="crypto-name">{{ selectedCrypto.name }}</span>
                <span class="crypto-network">{{ selectedCrypto.network }}</span>
              </div>
            </div>
            <i class="fas fa-chevron-right"></i>
          </div>
        </div>
      </div>

      <div class="payment-section">
        <div class="section-header">
          <span>Pay with</span>
          <span class="refresh-text">Quotes refresh in {{ refreshCounter }}s...</span>
        </div>

        <div class="payment-methods">
          <div class="payment-selector" @click="togglePaymentMethods">
            <div class="method-info">
              <div class="card-icons">
                <img src="https://cdn-icons-png.flaticon.com/512/349/349221.png" alt="Visa" class="card-icon">
                <img src="https://cdn-icons-png.flaticon.com/512/349/349228.png" alt="Mastercard" class="card-icon">
              </div>
              <span>Credit Card</span>
            </div>
            <i class="fas fa-chevron-down"></i>
          </div>

          <!-- Menu déroulant des méthodes de paiement -->
          <div v-if="showPaymentMethods" class="payment-dropdown">
            <div class="payment-option selected">
              <div class="method-info">
                <div class="card-icons">
                  <img src="https://cdn-icons-png.flaticon.com/512/349/349221.png" alt="Visa" class="card-icon">
                  <img src="https://cdn-icons-png.flaticon.com/512/349/349228.png" alt="Mastercard" class="card-icon">
                </div>
                <div class="method-details">
                  <span class="method-name">Credit Card</span>
                  <span class="method-type">Instant Transfer</span>
                </div>
              </div>
              <i class="fas fa-check"></i>
            </div>

            <div class="payment-option">
              <div class="method-info">
                <img src="https://cryptologos.cc/logos/binance-usd-busd-logo.png" alt="P2P" class="method-icon">
                <div class="method-details">
                  <span class="method-name">P2P</span>
                  <span class="method-type">Instant Transfer</span>
                </div>
              </div>
            </div>

            <div class="payment-option">
              <div class="method-info">
                <i class="fas fa-university method-icon"></i>
                <div class="method-details">
                  <span class="method-name">Bank Transfer</span>
                  <span class="method-type">Instant Transfer</span>
                </div>
              </div>
            </div>

            <div class="payment-option">
              <div class="method-info">
                <i class="fas fa-wallet method-icon"></i>
                <div class="method-details">
                  <span class="method-name">Digital Wallet</span>
                  <span class="method-type">Instant Transfer</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Liste des providers -->
          <div class="providers">
            <div 
              v-for="provider in providers" 
              :key="provider.id"
              class="provider-item"
              :class="{ 'best-rate': provider.isBestRate }"
            >
              <div class="provider-info">
                <img :src="provider.icon" :alt="provider.name" class="provider-icon">
                <span>{{ provider.name }}</span>
                <span v-if="provider.isBestRate" class="best-rate-badge">Best rate</span>
              </div>
              <div class="provider-rate">
                ≈ {{ provider.rate }} {{ selectedCrypto.name }}
                <i class="fas fa-external-link-alt"></i>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Bouton Buy -->
      <button class="buy-button" :disabled="!isValidAmount">
        Buy {{ selectedCrypto.name }}
      </button>
    </div>

    <CurrencySelector 
      v-if="showCurrencyModal"
      :selectedCode="selectedCurrency.code"
      @select="selectCurrency"
      @close="showCurrencyModal = false"
    />

    <CryptoSelector
      v-if="showCryptoModal"
      :selectedId="selectedCrypto.id"
      @select="selectCrypto"
      @close="showCryptoModal = false"
    />
  </div>
</template>

<script>
import CurrencySelector from '@/components/CurrencySelector.vue'
import CryptoSelector from '@/components/CryptoSelector.vue'

export default {
  name: 'Buy',
  components: {
    CurrencySelector,
    CryptoSelector
  },
  data() {
    return {
      activeTab: 'buy',
      amount: 150,
      refreshCounter: 10,
      usdIcon: 'https://cryptologos.cc/logos/usd-coin-usdc-logo.png',
      cardIcon: 'https://cdn-icons-png.flaticon.com/512/179/179457.png',
      selectedCrypto: {
        name: 'ETH',
        icon: 'https://cryptologos.cc/logos/ethereum-eth-logo.png'
      },
      providers: [
        {
          id: 'ramp',
          name: 'Ramp',
          icon: 'https://assets.website-files.com/611dbb3c82ba72fbc285d4e7/611fd04e5331ad6d54bb8a1c_ramp-network-logo.svg',
          rate: '0.044231',
          isBestRate: true
        },
        {
          id: 'mercuryo',
          name: 'Mercuryo',
          icon: 'https://mercuryo.io/static/logo-1ab2ad1f61de5b6d10756a64df890c39.svg',
          rate: '0.043351',
          isBestRate: false
        },
        {
          id: 'binance',
          name: 'Binance Connect',
          icon: 'https://cryptologos.cc/logos/binance-usd-busd-logo.png',
          rate: '0.043077',
          isBestRate: false
        },
        {
          id: 'transak',
          name: 'Transak',
          icon: 'https://assets.website-files.com/5f8e21b830b6431600cd03ae/60458b9d9a79a98988759cf2_transak%20logo.svg',
          rate: '0.042988',
          isBestRate: false
        },
        {
          id: 'moonpay',
          name: 'MoonPay',
          icon: 'https://www.moonpay.com/assets/logo-full-white.svg',
          rate: '0.042300',
          isBestRate: false
        }
      ],
      showPaymentMethods: false,
      showCurrencyModal: false,
      showCryptoModal: false,
      currencySearch: '',
      cryptoSearch: '',
      selectedCurrency: {
        code: 'USD',
        icon: 'https://cryptologos.cc/logos/usd-coin-usdc-logo.png'
      },
      currencies: [
        {
          code: 'USD',
          icon: 'https://cryptologos.cc/logos/usd-coin-usdc-logo.png'
        },
        {
          code: 'EUR',
          icon: 'https://cryptologos.cc/logos/euro-eur-logo.png'
        }
      ],
      cryptos: [
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
      ]
    }
  },
  computed: {
    cryptoAmount() {
      const bestProvider = this.providers.find(p => p.isBestRate)
      return bestProvider ? (this.amount * parseFloat(bestProvider.rate)).toFixed(6) : '0'
    },
    isValidAmount() {
      return this.amount > 0
    },
    filteredCurrencies() {
      return this.currencies.filter(currency =>
        currency.code.toLowerCase().includes(this.currencySearch.toLowerCase())
      )
    },
    filteredCryptos() {
      return this.cryptos.filter(crypto =>
        crypto.name.toLowerCase().includes(this.cryptoSearch.toLowerCase()) ||
        crypto.network.toLowerCase().includes(this.cryptoSearch.toLowerCase())
      )
    }
  },
  methods: {
    startRefreshCounter() {
      this.refreshCounter = 10
      this.countdownInterval = setInterval(() => {
        this.refreshCounter--
        if (this.refreshCounter <= 0) {
          this.refreshRates()
        }
      }, 1000)
    },
    refreshRates() {
      this.providers.forEach(provider => {
        provider.rate = (0.04 + Math.random() * 0.005).toFixed(6)
      })
      const maxRate = Math.max(...this.providers.map(p => parseFloat(p.rate)))
      this.providers.forEach(provider => {
        provider.isBestRate = parseFloat(provider.rate) === maxRate
      })
      this.startRefreshCounter()
    },
    togglePaymentMethods() {
      this.showPaymentMethods = !this.showPaymentMethods
    },
    selectCurrency(currency) {
      this.selectedCurrency = currency
      this.showCurrencyModal = false
    },
    selectCrypto(crypto) {
      this.selectedCrypto = crypto
      this.showCryptoModal = false
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
.buy-page {
  background-color: var(--background-primary);
  min-height: 100vh;
}

.search-header {
  background-color: var(--background-secondary);
  padding: 1rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.header-tabs {
  display: flex;
  gap: 1rem;
  justify-content: center;
}

.tab-btn {
  background: none;
  border: none;
  color: var(--text-secondary);
  padding: 0.5rem 2rem;
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

.buy-container {
  padding: 1rem;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.amount-section, .crypto-section {
  background-color: var(--background-secondary);
  padding: 1rem;
  border-radius: 12px;
}

.label {
  color: var(--text-secondary);
  font-size: 0.9rem;
  margin-bottom: 0.5rem;
}

.currency-input.dark {
  background-color: #1c1c1e;
  border-radius: 8px;
  padding: 0.5rem;
  margin-top: 0.5rem;
}

.currency-selector {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.5rem;
  cursor: pointer;
  border-radius: 4px;
}

.selector-left {
  display: flex;
  align-items: center;
  gap: 0.8rem;
}

.currency-icon {
  width: 32px;
  height: 32px;
  border-radius: 50%;
}

.currency-code {
  font-size: 1rem;
  color: var(--text-primary);
  font-weight: 500;
}

.crypto-info {
  display: flex;
  flex-direction: column;
}

.crypto-name {
  font-size: 1rem;
  color: var(--text-primary);
  font-weight: 500;
}

.crypto-network {
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.amount-input {
  width: 100%;
  padding: 0.5rem;
  background: none;
  border: none;
  color: var(--text-primary);
  font-size: 1.2rem;
  text-align: right;
  outline: none;
}

.fa-chevron-right {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.crypto-amount {
  color: var(--text-primary);
  font-size: 1.5rem;
}

.payment-section {
  background-color: var(--background-secondary);
  border-radius: 12px;
  padding: 1rem;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.refresh-text {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.payment-method {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: rgba(255, 255, 255, 0.05);
  border-radius: 8px;
  margin-bottom: 1rem;
}

.method-info {
  display: flex;
  align-items: center;
  gap: 0.8rem;
}

.method-icon {
  width: 32px;
  height: 20px;
}

.providers {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.provider-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: rgba(255, 255, 255, 0.05);
  border-radius: 8px;
  cursor: pointer;
}

.provider-item:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.provider-info {
  display: flex;
  align-items: center;
  gap: 0.8rem;
}

.provider-icon {
  width: 24px;
  height: 24px;
  border-radius: 50%;
}

.best-rate-badge {
  background-color: rgba(0, 255, 0, 0.1);
  color: #00ff00;
  padding: 0.2rem 0.5rem;
  border-radius: 4px;
  font-size: 0.8rem;
}

.provider-rate {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.provider-rate i {
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.payment-selector {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: var(--background-secondary);
  border-radius: 8px;
  cursor: pointer;
  margin-bottom: 1rem;
}

.card-icons {
  display: flex;
  gap: 0.5rem;
}

.card-icon {
  width: 32px;
  height: 20px;
  object-fit: contain;
}

.payment-dropdown {
  background-color: var(--background-secondary);
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 1rem;
}

.payment-option {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  cursor: pointer;
}

.payment-option:hover {
  background-color: rgba(255, 255, 255, 0.05);
}

.payment-option.selected {
  background-color: rgba(255, 255, 255, 0.1);
}

.method-info {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.method-icon {
  width: 24px;
  height: 24px;
  font-size: 1.2rem;
}

.method-details {
  display: flex;
  flex-direction: column;
}

.method-name {
  color: var(--text-primary);
  font-weight: 500;
}

.method-type {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.buy-button {
  width: 100%;
  padding: 1rem;
  background-color: var(--accent-color);
  border: none;
  border-radius: 8px;
  color: white;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  margin-top: 1rem;
  transition: opacity 0.2s;
}

.buy-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.buy-button:not(:disabled):hover {
  opacity: 0.9;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: var(--background-primary);
  z-index: 1000;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-header h2 {
  margin: 0;
  font-size: 1.2rem;
  color: var(--text-primary);
}

.close-btn {
  background: none;
  border: none;
  color: var(--text-primary);
  font-size: 1.2rem;
  cursor: pointer;
}

.search-box {
  position: relative;
  padding: 1rem;
}

.search-box input {
  width: 100%;
  padding: 0.8rem 2.5rem;
  background-color: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 8px;
  color: var(--text-primary);
  font-size: 1rem;
}

.search-box i {
  position: absolute;
  left: 2rem;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-secondary);
}

.section-title {
  padding: 0.5rem 1rem;
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.currency-list,
.crypto-list {
  padding: 0 1rem;
}

.currency-item,
.crypto-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  cursor: pointer;
}

.currency-item:hover,
.crypto-item:hover {
  background-color: rgba(255, 255, 255, 0.05);
}

.crypto-details {
  display: flex;
  flex-direction: column;
}

.crypto-network {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.fa-check {
  color: var(--accent-color);
}
</style> 