# 💰 STX Faucet Contract
## 📜 Project Description
This project is a decentralized **STX token faucet** built using the Clarity smart contract language and deployed on the **Stacks blockchain**. The smart contract allows users to claim STX tokens with built-in rate limiting and anti-abuse mechanisms. The faucet is designed to distribute tokens fairly while preventing spam and ensuring sustainable operation through owner-controlled parameters.

The contract handles user claim tracking, balance management, and administrative controls — all in a fully trustless and transparent on-chain environment.

---

## 🔭 Project Vision
The vision behind this project is to **provide accessible STX distribution** for developers, testers, and new users entering the Stacks ecosystem. By building a fair and sustainable faucet system, we aim to:

* Enable easy access to STX tokens for testing and development purposes.
* Demonstrate robust smart contract design with proper access controls and rate limiting.
* Support the growth of the Stacks ecosystem by lowering barriers to entry.
* Provide a template for other token distribution mechanisms.

---

## ⭐ Key Features

* 💸 **Token Distribution:** Users can claim STX tokens directly from the smart contract.
* 🛡️ **Rate Limiting:** Prevents abuse with per-user claim limits (default: 5 claims maximum).
* ⚙️ **Owner Controls:** Contract owner can fund, configure, and manage the faucet.
* 💰 **Configurable Amounts:** Claim amounts can be adjusted based on needs (default: 1 STX).
* 🔐 **Access Control:** Proper authorization ensures only owner can modify settings.
* 📊 **Tracking & Analytics:** Monitors total distributed tokens and user claim history.
* 🎛️ **Emergency Controls:** Owner can pause/unpause faucet operations.
* 💳 **Balance Management:** Real-time balance checking prevents over-distribution.

---

## 🎮 How to Use

### For Users (Claiming STX):
```clarity
;; Claim STX tokens (if eligible)
(contract-call? .stx-faucet claim-stx)

;; Check if you can claim
(contract-call? .stx-faucet can-user-claim 'SP1234...)

;; View your total claims
(contract-call? .stx-faucet get-user-claims 'SP1234...)
```

### For Contract Owner:
```clarity
;; Fund the faucet with STX
(contract-call? .stx-faucet fund-faucet u100000000) ;; 100 STX

;; Change claim amount to 0.5 STX
(contract-call? .stx-faucet set-claim-amount u500000)

;; Set maximum 3 claims per user
(contract-call? .stx-faucet set-max-claims u3)

;; Pause/unpause faucet
(contract-call? .stx-faucet toggle-faucet)

;; Withdraw excess funds
(contract-call? .stx-faucet withdraw-funds u50000000)
```

---

## 📋 Contract Functions

### Public Functions (Users):
- **`claim-stx`** - Claim STX tokens from the faucet
- **`can-user-claim`** - Check eligibility to claim

### Public Functions (Owner Only):
- **`fund-faucet`** - Add STX to the faucet balance
- **`withdraw-funds`** - Remove excess STX from faucet
- **`set-claim-amount`** - Modify the amount users can claim
- **`set-max-claims`** - Change maximum claims per user
- **`toggle-faucet`** - Enable/disable faucet operations

### Read-Only Functions:
- **`get-faucet-balance`** - View current faucet STX balance
- **`get-claim-amount`** - Get current claim amount
- **`get-user-claims`** - View user's total claims
- **`get-total-distributed`** - See total STX distributed
- **`can-user-claim`** - Check if user is eligible to claim

---

## ⚙️ Default Configuration

| Setting | Default Value | Description |
|---------|---------------|-------------|
| Claim Amount | 1 STX | Amount users receive per claim |
| Max Claims | 5 | Maximum lifetime claims per user |
| Faucet Status | Active | Faucet operational status |

---

## 🛡️ Security Features

* **Owner Authorization:** Only contract deployer can modify settings
* **Claim Limits:** Prevents users from draining the faucet
* **Balance Validation:** Ensures sufficient funds before distribution
* **State Tracking:** Maintains accurate records of all transactions
* **Emergency Stop:** Owner can pause operations if needed

---

## 🚀 Future Scope

* ⏰ **Time-based Cooldowns:** Implement daily/weekly claim limits instead of lifetime limits
* 🎯 **Targeted Distribution:** Add whitelist functionality for specific user groups
* 📈 **Dynamic Pricing:** Adjust claim amounts based on STX price or demand
* 🏆 **Gamification:** Add tasks or challenges users must complete to claim
* 📊 **Analytics Dashboard:** Build frontend to visualize faucet usage and statistics
* 🔗 **Multi-token Support:** Extend to support other Stacks-based tokens (SIP-010)
* 🤖 **Automated Refunding:** Implement automatic refill from designated treasury
* 🌐 **Cross-chain Integration:** Enable claims from other blockchain networks

---

## 📊 Contract Analytics

The contract provides comprehensive tracking including:
- Total STX distributed to date
- Individual user claim histories  
- Current faucet balance and status
- All transaction logs with detailed metadata

---

## 🔧 Deployment Information

**Contract Name:** `stx-faucet`
**Network:** Stacks Blockchain
**Language:** Clarity
**Status:** ✅ Active

*Replace with your actual deployment details:*
```
Deployed Contract Address: ST1P3KSBSBZBBV8KDRQ7WZNGASWAE2BKJVN1SXP0T
Deployment Transaction: ST1P3KSBSBZBBV8KDRQ7WZNGASWAE2BKJVN1SXP0T.faucet
```

---

## 🤝 Contributing

This faucet contract serves as a foundation for STX token distribution. Developers are encouraged to:
- Fork and customize for their own projects
- Propose improvements and additional features
- Report issues or security concerns
- Build frontend interfaces for easier user interaction

---

## ⚠️ Important Notes

- **Irreversible Deployment:** Smart contracts cannot be modified after deployment
- **Owner Responsibility:** Contract owner must manage funding and settings
- **Network Fees:** All transactions require STX for network fees
- **Rate Limits:** Users should check eligibility before attempting to claim

---

<img width="916" height="512" alt="{96D8CB8A-3D60-45D7-BAE6-BD8809B8F9A2}" src="https://github.com/user-attachments/assets/c54de3e5-ee13-461c-9e68-962e446b855e" />
