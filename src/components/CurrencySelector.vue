<template>
  <div class="modal-page">
    <div class="modal-header">
      <button class="close-btn" @click="$emit('close')">
        <i class="fas fa-times"></i>
      </button>
      <h2>Choose currency</h2>
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
    <div class="currency-list">
      <div 
        v-for="currency in popularCurrencies" 
        :key="currency.code"
        class="currency-item"
        @click="selectCurrency(currency)"
      >
        <div class="currency-info">
          <img :src="currency.icon" :alt="currency.code" class="currency-icon">
          <span>{{ currency.name }}</span>
        </div>
        <i v-if="currency.code === selectedCode" class="fas fa-check"></i>
      </div>
    </div>

    <div class="section-title">Other currencies</div>
    <div class="currency-list">
      <div 
        v-for="currency in otherCurrencies" 
        :key="currency.code"
        class="currency-item"
        @click="selectCurrency(currency)"
      >
        <span>{{ currency.code }} - {{ currency.name }}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CurrencySelector',
  props: {
    selectedCode: String
  },
  data() {
    return {
      search: '',
      popularCurrencies: [
        {
          code: 'USD',
          name: 'US Dollar',
          icon: 'https://cryptologos.cc/logos/usd-coin-usdc-logo.png'
        },
        {
          code: 'EUR',
          name: 'Euro',
          icon: 'path/to/euro.png'
        },
        {
          code: 'GBP',
          name: 'British Pound Sterling',
          icon: 'path/to/gbp.png'
        }
      ],
      otherCurrencies: [
        { code: 'AED', name: 'United Arab Emirates Dirham' },
        { code: 'AFN', name: 'Afghan Afghani' },
        { code: 'ALL', name: 'Albanian Lek' },
        { code: 'AMD', name: 'Armenian Dram' },
        { code: 'ANG', name: 'Netherlands Antillean Guilder' },
        { code: 'AOA', name: 'Angolan Kwanza' },
        { code: 'ARS', name: 'Argentine Peso' },
        { code: 'AUD', name: 'Australian Dollar' }
      ]
    }
  },
  methods: {
    selectCurrency(currency) {
      this.$emit('select', currency)
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

.currency-list {
  padding: 0 16px;
}

.currency-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  cursor: pointer;
  color: #fff;
}

.currency-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.currency-icon {
  width: 24px;
  height: 24px;
  border-radius: 50%;
}

.fa-check {
  color: #0f0;
}
</style> 