<template>
  <div class="profile-page">
    <div class="header">
      <button class="back-btn" @click="$router.go(-1)">
        <i class="fas fa-arrow-left"></i>
      </button>
      <h1>Profile</h1>
    </div>

    <div class="profile-content">
      <div class="profile-info">
        <div class="avatar">
          <i class="fas fa-user"></i>
        </div>
        <h2>{{ user.username }}</h2>
        <p>{{ user.email }}</p>
      </div>

      <!-- Section Sécurité -->
      <div v-if="activeSection === 'security'" class="section-content">
        <div class="section-header">
          <button class="back-btn" @click="activeSection = null">
            <i class="fas fa-arrow-left"></i>
          </button>
          <h2>Security</h2>
        </div>

        <div class="security-options">
          <div class="security-item">
            <h3>Change Password</h3>
            <form @submit.prevent="updatePassword" class="password-form">
              <div class="form-group">
                <input 
                  type="password" 
                  v-model="currentPassword"
                  placeholder="Current Password"
                  required
                >
              </div>
              <div class="form-group">
                <input 
                  type="password" 
                  v-model="newPassword"
                  placeholder="New Password"
                  required
                >
              </div>
              <div class="form-group">
                <input 
                  type="password" 
                  v-model="confirmPassword"
                  placeholder="Confirm New Password"
                  required
                >
              </div>
              <button type="submit" class="update-btn">Update Password</button>
            </form>
          </div>

          <div class="security-item">
            <h3>Two-Factor Authentication</h3>
            <button class="toggle-btn" :class="{ active: user.twoFactorEnabled }">
              {{ user.twoFactorEnabled ? 'Enabled' : 'Disabled' }}
            </button>
          </div>

          <div class="security-item">
            <h3>Recovery Phrase</h3>
            <button class="action-btn" @click="showRecoveryPhrase">
              <i class="fas fa-key"></i>
              <span>View Recovery Phrase</span>
            </button>
          </div>
        </div>
      </div>

      <!-- Section Wallet -->
      <div v-else-if="activeSection === 'wallets'" class="section-content">
        <div class="section-header">
          <button class="back-btn" @click="activeSection = null">
            <i class="fas fa-arrow-left"></i>
          </button>
          <h2>Wallets</h2>
        </div>

        <div class="wallet-summary">
          <div class="total-balance">
            <span class="label">Total Balance</span>
            <span class="amount">${{ totalBalance.toLocaleString() }}</span>
          </div>

          <!-- Nouvelle section pour la gestion des fonds -->
          <div class="funds-management">
            <div class="funds-actions">
              <button class="fund-btn deposit" @click="showDepositModal = true">
                <i class="fas fa-arrow-down"></i>
                <span>Deposit</span>
              </button>
              <button class="fund-btn withdraw" @click="showWithdrawModal = true">
                <i class="fas fa-arrow-up"></i>
                <span>Withdraw</span>
              </button>
            </div>
          </div>

          <!-- Modal de dépôt -->
          <div v-if="showDepositModal" class="modal">
            <div class="modal-content">
              <!-- Étape 1: Sélection méthode et montant -->
              <div v-if="depositStep === 1">
                <div class="modal-header">
                  <h3>Deposit Funds</h3>
                  <button class="close-btn" @click="closeDepositModal">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
                
                <div class="modal-body">
                  <div class="payment-methods">
                    <button 
                      v-for="method in paymentMethods" 
                      :key="method.id"
                      class="payment-method"
                      :class="{ active: selectedPaymentMethod === method.id }"
                      @click="selectedPaymentMethod = method.id"
                    >
                      <img :src="method.icon" :alt="method.name">
                      <span>{{ method.name }}</span>
                      <span class="method-fee">{{ method.fee }}</span>
                    </button>
                  </div>

                  <div class="amount-input">
                    <label>Amount</label>
                    <div class="input-group">
                      <span class="currency">$</span>
                      <input 
                        type="number" 
                        v-model="depositAmount"
                        placeholder="0.00"
                        min="10"
                      >
                    </div>
                    <div class="amount-details">
                      <div class="amount-limits">Min: $10.00 - Max: $10,000.00</div>
                      <div class="fee-info" v-if="selectedPaymentMethod && depositAmount">
                        Fee: ${{ calculateFee(depositAmount, selectedPaymentMethod) }}
                        <i class="fas fa-info-circle" @mouseover="showFeeInfo = true" @mouseleave="showFeeInfo = false"></i>
                      </div>
                      <div class="total-amount" v-if="depositAmount">
                        Total: ${{ calculateTotal(depositAmount) }}
                      </div>
                    </div>
                  </div>

                  <button 
                    class="submit-btn"
                    :disabled="!isValidDepositAmount || !selectedPaymentMethod"
                    @click="goToDepositStep(2)"
                  >
                    Continue
                  </button>
                </div>
              </div>

              <!-- Étape 2: Confirmation par email -->
              <div v-if="depositStep === 2">
                <div class="modal-header">
                  <button class="back-btn" @click="depositStep = 1">
                    <i class="fas fa-arrow-left"></i>
                  </button>
                  <h3>Verify Email</h3>
                </div>
                
                <div class="modal-body">
                  <div class="verification-info">
                    <i class="fas fa-envelope"></i>
                    <p>We've sent a verification code to {{ user.email }}</p>
                  </div>

                  <div class="verification-code">
                    <input 
                      v-for="(digit, index) in 6" 
                      :key="index"
                      type="text"
                      maxlength="1"
                      v-model="verificationCode[index]"
                      @input="handleCodeInput($event, index)"
                      @keydown.delete="handleCodeDelete($event, index)"
                      ref="codeInputs"
                    >
                  </div>

                  <div class="verification-actions">
                    <button class="resend-btn" @click="resendVerificationCode" :disabled="resendTimer > 0">
                      {{ resendTimer > 0 ? `Resend code in ${resendTimer}s` : 'Resend code' }}
                    </button>
                  </div>

                  <button 
                    class="submit-btn"
                    :disabled="!isValidVerificationCode"
                    @click="verifyAndProcessDeposit"
                  >
                    Verify and Continue
                  </button>
                </div>
              </div>

              <!-- Étape 3: Confirmation -->
              <div v-if="depositStep === 3">
                <div class="modal-header">
                  <h3>Deposit Successful</h3>
                </div>
                
                <div class="modal-body">
                  <div class="success-animation">
                    <i class="fas fa-check-circle"></i>
                  </div>
                  <div class="success-message">
                    <h4>Your deposit was successful!</h4>
                    <p>Amount: ${{ depositAmount }}</p>
                    <p>Transaction ID: {{ transactionId }}</p>
                  </div>
                  <button class="submit-btn" @click="closeDepositModal">Done</button>
                </div>
              </div>
            </div>
          </div>

          <!-- Modal de retrait -->
          <div v-if="showWithdrawModal" class="modal">
            <div class="modal-content">
              <div class="modal-header">
                <h3>Withdraw Funds</h3>
                <button class="close-btn" @click="closeWithdrawModal">
                  <i class="fas fa-times"></i>
                </button>
              </div>
              
              <div class="modal-body">
                <div class="bank-accounts">
                  <h4>Select Bank Account</h4>
                  <div 
                    v-for="account in bankAccounts" 
                    :key="account.id"
                    class="bank-account"
                    :class="{ active: selectedAccount === account.id }"
                    @click="selectedAccount = account.id"
                  >
                    <img :src="account.bankIcon" :alt="account.bankName">
                    <div class="account-info">
                      <span class="bank-name">{{ account.bankName }}</span>
                      <span class="account-number">****{{ account.lastFour }}</span>
                    </div>
                  </div>
                  <button class="add-account-btn" @click="showAddBankModal">
                    <i class="fas fa-plus"></i>
                    Add New Bank Account
                  </button>
                </div>

                <div class="amount-input">
                  <label>Amount to Withdraw</label>
                  <div class="input-group">
                    <span class="currency">$</span>
                    <input 
                      type="number" 
                      v-model="withdrawAmount"
                      placeholder="0.00"
                      :max="totalBalance"
                    >
                  </div>
                  <div class="amount-limits">
                    Available: ${{ totalBalance.toLocaleString() }}
                  </div>
                </div>

                <button 
                  class="submit-btn"
                  :disabled="!isValidWithdrawAmount"
                  @click="processWithdraw"
                >
                  Withdraw Funds
                </button>
              </div>
            </div>
          </div>

          <!-- Reste du contenu wallet -->
          <div class="portfolio-chart">
            <!-- Ajouter un graphique de portfolio ici -->
          </div>

          <div class="assets-list">
            <h3>Assets</h3>
            <div v-for="asset in assets" :key="asset.id" class="asset-item">
              <div class="asset-info">
                <img :src="asset.icon" :alt="asset.name" class="asset-icon">
                <div class="asset-details">
                  <span class="asset-name">{{ asset.name }}</span>
                  <span class="asset-network">{{ asset.network }}</span>
                </div>
              </div>
              <div class="asset-value">
                <div class="asset-amount">{{ asset.amount }} {{ asset.symbol }}</div>
                <div class="asset-price">${{ asset.value.toLocaleString() }}</div>
              </div>
            </div>
          </div>

          <div class="nft-section">
            <h3>NFTs</h3>
            <div class="nft-grid">
              <div v-for="nft in nfts" :key="nft.id" class="nft-item">
                <img :src="nft.image" :alt="nft.name">
                <div class="nft-info">
                  <span class="nft-name">{{ nft.name }}</span>
                  <span class="nft-collection">{{ nft.collection }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Menu Principal -->
      <div v-else class="profile-actions">
        <button class="action-btn" @click="activeSection = 'security'">
          <i class="fas fa-shield-alt"></i>
          <span>Security</span>
        </button>
        <button class="action-btn" @click="activeSection = 'wallets'">
          <i class="fas fa-wallet"></i>
          <span>Wallets</span>
        </button>
        <button class="action-btn" @click="$router.push('/history')">
          <i class="fas fa-history"></i>
          <span>Transaction History</span>
        </button>
        <button class="action-btn" @click="handleLogout">
          <i class="fas fa-sign-out-alt"></i>
          <span>Logout</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Profile',
  data() {
    return {
      activeSection: null,
      user: {
        username: 'John Doe',
        email: 'john@example.com',
        twoFactorEnabled: false
      },
      currentPassword: '',
      newPassword: '',
      confirmPassword: '',
      totalBalance: 1000.00,
      assets: [
        {
          id: 'btc',
          name: 'Bitcoin',
          symbol: 'BTC',
          network: 'Bitcoin',
          icon: 'path/to/btc.png',
          amount: '0.5',
          value: 20000
        },
        {
          id: 'eth',
          name: 'Ethereum',
          symbol: 'ETH',
          network: 'Ethereum',
          icon: 'path/to/eth.png',
          amount: '2.5',
          value: 5000
        }
      ],
      nfts: [
        {
          id: 1,
          name: 'Bored Ape #123',
          collection: 'BAYC',
          image: 'path/to/nft1.png'
        },
        {
          id: 2,
          name: 'Punk #456',
          collection: 'CryptoPunks',
          image: 'path/to/nft2.png'
        }
      ],
      showDepositModal: false,
      showWithdrawModal: false,
      selectedPaymentMethod: null,
      depositAmount: '',
      selectedAccount: null,
      paymentMethods: [
        { 
          id: 'card', 
          name: 'Credit/Debit Card', 
          icon: 'https://cdn-icons-png.flaticon.com/512/179/179457.png',
          fee: '2.5%'
        },
        { 
          id: 'bank', 
          name: 'Bank Transfer', 
          icon: 'https://cdn-icons-png.flaticon.com/512/2830/2830289.png',
          fee: '0%'
        },
        { 
          id: 'apple', 
          name: 'Apple Pay', 
          icon: 'https://cdn-icons-png.flaticon.com/512/5968/5968631.png',
          fee: '1.5%'
        }
      ],
      bankAccounts: [
        {
          id: 1,
          bankName: 'Chase Bank',
          lastFour: '4567',
          bankIcon: 'https://cdn-icons-png.flaticon.com/512/6821/6821173.png'
        },
        {
          id: 2,
          bankName: 'Bank of America',
          lastFour: '8901',
          bankIcon: 'https://cdn-icons-png.flaticon.com/512/6821/6821173.png'
        }
      ],
      depositStep: 1,
      verificationCode: Array(6).fill(''),
      resendTimer: 0,
      showFeeInfo: false,
      transactionId: null,
      isValidDepositAmount: false,
      withdrawAmount: 0
    }
  },
  computed: {
    isValidVerificationCode() {
      return this.verificationCode.every(digit => digit !== '')
    },
    isValidWithdrawAmount() {
      return this.withdrawAmount > 0 && this.withdrawAmount <= this.totalBalance
    }
  },
  watch: {
    depositAmount(newVal) {
      this.isValidDepositAmount = newVal >= 10 && newVal <= 10000
    }
  },
  methods: {
    updatePassword() {
      // Implémenter la mise à jour du mot de passe
      console.log('Password update:', {
        current: this.currentPassword,
        new: this.newPassword
      })
    },
    showRecoveryPhrase() {
      // Implémenter l'affichage de la phrase de récupération
    },
    handleLogout() {
      this.$router.push('/login')
    },
    goToDepositStep(step) {
      if (step === 2) {
        this.sendVerificationEmail()
      }
      this.depositStep = step
    },
    async sendVerificationEmail() {
      // Simuler l'envoi d'email
      console.log('Sending verification email to:', this.user.email)
      this.startResendTimer()
    },
    startResendTimer() {
      this.resendTimer = 60
      const timer = setInterval(() => {
        this.resendTimer--
        if (this.resendTimer <= 0) {
          clearInterval(timer)
        }
      }, 1000)
    },
    handleCodeInput(event, index) {
      const value = event.target.value
      if (value && index < 5) {
        this.$refs.codeInputs[index + 1].focus()
      }
    },
    handleCodeDelete(event, index) {
      if (!this.verificationCode[index] && index > 0) {
        this.$refs.codeInputs[index - 1].focus()
      }
    },
    async verifyAndProcessDeposit() {
      // Simuler la vérification
      const code = this.verificationCode.join('')
      if (code === '123456') { // Code de test
        this.transactionId = 'TRX' + Date.now()
        this.depositStep = 3
      } else {
        alert('Invalid verification code')
      }
    },
    closeDepositModal() {
      this.showDepositModal = false
      this.depositStep = 1
      this.verificationCode = Array(6).fill('')
      this.selectedPaymentMethod = null
      this.depositAmount = null
    },
    calculateFee(amount, methodId) {
      const method = this.paymentMethods.find(m => m.id === methodId)
      const feePercentage = parseFloat(method.fee)
      return ((amount * feePercentage) / 100).toFixed(2)
    },
    calculateTotal(amount) {
      if (!this.selectedPaymentMethod) return amount
      const fee = this.calculateFee(amount, this.selectedPaymentMethod)
      return (parseFloat(amount) + parseFloat(fee)).toFixed(2)
    },
    closeWithdrawModal() {
      this.showWithdrawModal = false
      this.selectedAccount = null
      this.withdrawAmount = null
    },
    showAddBankModal() {
      // Implémenter l'ajout d'un nouveau compte bancaire
      console.log('Show add bank modal')
    },
    processWithdraw() {
      if (!this.selectedAccount) {
        alert('Please select a bank account')
        return
      }
      if (!this.isValidWithdrawAmount) {
        alert('Please enter a valid amount')
        return
      }
      // Simuler le retrait
      console.log('Processing withdrawal:', {
        amount: this.withdrawAmount,
        account: this.selectedAccount
      })
      // Envoyer le code de vérification
      this.sendVerificationEmail()
      this.withdrawStep = 2
    }
  },
  processDeposit() {
    // Implémenter la logique de dépôt
    console.log('Processing deposit:', {
      amount: this.depositAmount,
      method: this.selectedPaymentMethod
    })
    this.showDepositModal = false
  },
  processWithdraw() {
    // Implémenter la logique de retrait
    console.log('Processing withdrawal:', {
      amount: this.withdrawAmount,
      account: this.selectedAccount
    })
    this.showWithdrawModal = false
  }
}
</script>

<style scoped>
.funds-management {
  background-color: var(--background-secondary);
  border-radius: 12px;
  padding: 1.5rem;
  margin-top: 1rem;
}

.funds-actions {
  display: flex;
  gap: 1rem;
}

.fund-btn {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem;
  border: none;
  border-radius: 8px;
  color: white;
  font-size: 1rem;
  cursor: pointer;
}

.fund-btn.deposit {
  background-color: var(--accent-color);
}

.fund-btn.withdraw {
  background-color: #ff4444;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.8);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background-color: var(--background-secondary);
  width: 90%;
  max-width: 500px;
  border-radius: 12px;
  padding: 1.5rem;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

.payment-methods {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.payment-method {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  background-color: var(--background-primary);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  cursor: pointer;
}

.payment-method.active {
  border-color: var(--accent-color);
}

.amount-input {
  margin-bottom: 1.5rem;
}

.input-group {
  display: flex;
  align-items: center;
  background-color: var(--background-primary);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  padding: 0.5rem 1rem;
}

.currency {
  color: var(--text-secondary);
  margin-right: 0.5rem;
}

.amount-details {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.amount-limits {
  color: var(--text-secondary);
  font-size: 0.8rem;
  margin-top: 0.5rem;
}

.fee-info {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--text-secondary);
  font-size: 0.8rem;
}

.fee-info i {
  font-size: 1rem;
  cursor: pointer;
}

.total-amount {
  color: var(--text-primary);
  font-weight: 500;
}

.bank-accounts {
  margin-bottom: 1.5rem;
}

.bank-account {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background-color: var(--background-primary);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  margin-bottom: 0.5rem;
  cursor: pointer;
}

.bank-account.active {
  border-color: var(--accent-color);
}

.add-account-btn {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem;
  background-color: transparent;
  border: 1px dashed rgba(255, 255, 255, 0.3);
  border-radius: 8px;
  color: var(--text-primary);
  cursor: pointer;
}

.profile-page {
  min-height: 100vh;
  background-color: var(--background-primary);
}

.header {
  display: flex;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.back-btn {
  background: none;
  border: none;
  color: var(--text-primary);
  font-size: 1.2rem;
  cursor: pointer;
  padding: 0.5rem;
}

.header h1 {
  flex: 1;
  text-align: center;
  margin: 0;
  color: var(--text-primary);
  font-size: 1.2rem;
}

.profile-content {
  padding: 2rem 1rem;
}

.profile-info {
  text-align: center;
  margin-bottom: 2rem;
}

.avatar {
  width: 80px;
  height: 80px;
  background-color: var(--background-secondary);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1rem;
}

.avatar i {
  font-size: 2rem;
  color: var(--text-secondary);
}

.profile-info h2 {
  color: var(--text-primary);
  margin: 0;
  font-size: 1.2rem;
}

.profile-info p {
  color: var(--text-secondary);
  margin: 0.5rem 0 0;
  font-size: 0.9rem;
}

.profile-actions {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.action-btn {
  display: flex;
  align-items: center;
  gap: 1rem;
  background-color: var(--background-secondary);
  border: none;
  border-radius: 8px;
  padding: 1rem;
  color: var(--text-primary);
  cursor: pointer;
}

.action-btn i {
  width: 24px;
}

.section-content {
  padding: 1rem;
}

.section-header {
  display: flex;
  align-items: center;
  margin-bottom: 2rem;
}

.section-header h2 {
  flex: 1;
  text-align: center;
  margin: 0;
  color: var(--text-primary);
}

.security-options {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.security-item {
  background-color: var(--background-secondary);
  padding: 1.5rem;
  border-radius: 12px;
}

.security-item h3 {
  margin: 0 0 1rem;
  color: var(--text-primary);
}

.password-form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.form-group input {
  width: 100%;
  padding: 1rem;
  background-color: var(--background-primary);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  color: var(--text-primary);
}

.update-btn {
  background-color: var(--accent-color);
  color: white;
  padding: 1rem;
  border: none;
  border-radius: 8px;
  cursor: pointer;
}

.toggle-btn {
  background-color: var(--background-primary);
  color: var(--text-secondary);
  padding: 0.5rem 1rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  cursor: pointer;
}

.toggle-btn.active {
  background-color: var(--accent-color);
  color: white;
}

.wallet-summary {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.total-balance {
  text-align: center;
}

.total-balance .label {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.total-balance .amount {
  display: block;
  color: var(--text-primary);
  font-size: 2rem;
  font-weight: bold;
  margin-top: 0.5rem;
}

.assets-list {
  background-color: var(--background-secondary);
  border-radius: 12px;
  padding: 1rem;
}

.assets-list h3 {
  margin: 0 0 1rem;
  color: var(--text-primary);
}

.asset-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.asset-info {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.asset-icon {
  width: 32px;
  height: 32px;
  border-radius: 50%;
}

.asset-details {
  display: flex;
  flex-direction: column;
}

.asset-name {
  color: var(--text-primary);
  font-weight: 500;
}

.asset-network {
  color: var(--text-secondary);
  font-size: 0.8rem;
}

.asset-value {
  text-align: right;
}

.asset-amount {
  color: var(--text-primary);
  font-weight: 500;
}

.asset-price {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.nft-section {
  margin-top: 2rem;
}

.nft-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 1rem;
  margin-top: 1rem;
}

.nft-item {
  background-color: var(--background-secondary);
  border-radius: 8px;
  overflow: hidden;
}

.nft-item img {
  width: 100%;
  aspect-ratio: 1;
  object-fit: cover;
}

.nft-info {
  padding: 0.5rem;
}

.nft-name {
  display: block;
  color: var(--text-primary);
  font-size: 0.9rem;
  font-weight: 500;
}

.nft-collection {
  display: block;
  color: var(--text-secondary);
  font-size: 0.8rem;
}

.verification-info {
  text-align: center;
  margin-bottom: 2rem;
}

.verification-info i {
  font-size: 3rem;
  color: var(--accent-color);
  margin-bottom: 1rem;
}

.verification-code {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  margin-bottom: 2rem;
}

.verification-code input {
  width: 40px;
  height: 40px;
  text-align: center;
  font-size: 1.2rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  background-color: var(--background-primary);
  color: var(--text-primary);
}

.verification-actions {
  text-align: center;
  margin-bottom: 2rem;
}

.resend-btn {
  background: none;
  border: none;
  color: var(--accent-color);
  cursor: pointer;
}

.resend-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.success-animation {
  text-align: center;
  margin: 2rem 0;
}

.success-animation i {
  font-size: 4rem;
  color: #00ff00;
  animation: scale-in 0.3s ease-out;
}

.success-message {
  text-align: center;
  margin-bottom: 2rem;
}

.success-message h4 {
  color: var(--text-primary);
  margin-bottom: 1rem;
}

.success-message p {
  color: var(--text-secondary);
  margin: 0.5rem 0;
}

@keyframes scale-in {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}

.method-fee {
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.amount-details {
  margin-top: 0.5rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.fee-info {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--text-secondary);
}

.total-amount {
  font-weight: bold;
  color: var(--text-primary);
}

.payment-method img {
  width: 40px;
  height: 40px;
  object-fit: contain;
}

.bank-account img {
  width: 32px;
  height: 32px;
  object-fit: contain;
}

.modal-content {
  max-height: 90vh;
  overflow-y: auto;
}

.submit-btn:not(:disabled) {
  background-color: var(--accent-color);
  cursor: pointer;
}

.submit-btn:disabled {
  background-color: rgba(26, 136, 248, 0.5);
  cursor: not-allowed;
}

.add-account-btn:hover {
  background-color: rgba(255, 255, 255, 0.1);
}
</style> 