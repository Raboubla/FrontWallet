<template>
  <div class="history-page">
    <Header />
    <div class="search-header">
      <h1>History</h1>
      <div class="search-input">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Search" v-model="searchQuery">
      </div>
    </div>

    <div class="transaction-list">
      <div v-for="transaction in filteredTransactions" 
           :key="transaction.id" 
           class="transaction-item"
      >
        <div class="transaction-icon">
          <i :class="getTransactionIcon(transaction.type)"></i>
        </div>
        
        <div class="transaction-info">
          <div class="transaction-type">{{ transaction.type }}</div>
          <div class="transaction-date">{{ transaction.date }}</div>
        </div>

        <div class="transaction-amount">
          <div class="amount" :class="{ 'negative': transaction.type === 'Send' }">
            {{ transaction.type === 'Send' ? '-' : '+' }}{{ transaction.amount }} {{ transaction.token }}
          </div>
          <div class="value">${{ transaction.value }}</div>
        </div>
      </div>
    </div>
  </div>
<Footer />
</template>

<script>
import Header from '@/components/Header.vue'
import Footer from '@/components/Footer.vue'
export default {
  name: 'History',
  components:{
    Footer,
    Header
  },
  data() {
    return {
      searchQuery: '',
      transactions: [
        {
          id: 1,
          type: 'Buy',
          token: 'ETH',
          amount: '0.5',
          value: '1,663.70',
          date: 'Mar 15, 2024'
        },
        {
          id: 2,
          type: 'Send',
          token: 'BNB',
          amount: '1.2',
          value: '831.94',
          date: 'Mar 14, 2024'
        },
        {
          id: 3,
          type: 'Receive',
          token: 'POL',
          amount: '100',
          value: '45.00',
          date: 'Mar 13, 2024'
        },
        {
          id: 4,
          type: 'Buy',
          token: 'BNB',
          amount: '2.0',
          value: '1,386.56',
          date: 'Mar 12, 2024'
        }
      ]
    }
  },
  computed: {
    filteredTransactions() {
      return this.transactions.filter(tx => 
        tx.type.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        tx.token.toLowerCase().includes(this.searchQuery.toLowerCase())
      )
    }
  },
  methods: {
    getTransactionIcon(type) {
      const icons = {
        'Send': 'fas fa-arrow-up',
        'Receive': 'fas fa-arrow-down',
        'Buy': 'fas fa-shopping-cart'
      }
      return icons[type]
    }
  }
}
</script>

<style scoped>
.history-page {
  background-color: var(--background-primary);
  min-height: 100vh;
  padding-bottom: 4rem;
}

.search-header {
  background-color: var(--background-secondary);
  padding: 1rem;
  position: sticky;
  top: 0;
  z-index: 10;
}

.search-header h1 {
  color: var(--text-primary);
  margin: 0 0 1rem 0;
  font-size: 1.5rem;
  text-align: center;
}

.search-input {
  position: relative;
  margin: 0.5rem 0;
}

.search-input i {
  position: absolute;
  left: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-secondary);
}

.search-input input {
  width: 100%;
  padding: 0.8rem 2.5rem;
  background-color: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 8px;
  color: var(--text-primary);
  font-size: 1rem;
}

.transaction-list {
  padding: 1rem;
}

.transaction-item {
  display: flex;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.transaction-icon {
  width: 40px;
  height: 40px;
  background-color: var(--background-secondary);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 1rem;
}

.transaction-icon i {
  color: var(--text-primary);
  font-size: 1.2rem;
}

.transaction-info {
  flex: 1;
}

.transaction-type {
  color: var(--text-primary);
  font-weight: 500;
}

.transaction-date {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.transaction-amount {
  text-align: right;
}

.amount {
  color: #00ff00;
  font-weight: 500;
}

.amount.negative {
  color: #ff0000;
}

.value {
  color: var(--text-secondary);
  font-size: 0.9rem;
}
</style> 