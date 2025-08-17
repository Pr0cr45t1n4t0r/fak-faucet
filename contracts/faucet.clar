;; title: stx-faucet
;; version: 1.0
;; summary: Simple STX faucet with per-account limits
;; description: Allows users to claim STX tokens with basic limits per account

;; traits
;;

;; token definitions
;;

;; constants
;;

;; data vars
;;

;; data maps
;;

;; public functions
;;

;; read only functions
;;

;; private functions
;;

;; Simple STX Faucet Contract
;; Users can claim STX tokens with basic limits

(define-constant ERR_UNAUTHORIZED u100)
(define-constant ERR_LIMIT_EXCEEDED u101)
(define-constant ERR_FAUCET_EMPTY u102)

;; Owner of the faucet (set when deployed)
(define-constant contract-owner tx-sender)

;; Faucet settings
(define-data-var claim-amount uint u1000000) ;; 1 STX in microSTX
(define-data-var max-claims-per-user uint u5) ;; Max claims per user
(define-data-var total-distributed uint u0) ;; Total STX distributed
(define-data-var faucet-active bool true) ;; Is faucet active

;; Map of user => total claims made
(define-map user-claims principal uint)

;; Claim STX from faucet (simplified version)
(define-public (claim-stx)
  (let (
    (claimer tx-sender)
    (amount (var-get claim-amount))
    (prev-claims (default-to u0 (map-get? user-claims claimer)))
  )
  (begin
    ;; Check if faucet is active
    (asserts! (var-get faucet-active) (err ERR_UNAUTHORIZED))
    
    ;; Check if user hasn't exceeded max claims
    (asserts! (< prev-claims (var-get max-claims-per-user)) (err ERR_LIMIT_EXCEEDED))
    
    ;; Check if faucet has enough funds
    (asserts! (>= (stx-get-balance (as-contract tx-sender)) amount) (err ERR_FAUCET_EMPTY))
    
    ;; Transfer STX from contract to claimer
    (try! (as-contract (stx-transfer? amount tx-sender claimer)))
    
    ;; Update user claims count
    (map-set user-claims claimer (+ prev-claims u1))
    
    ;; Update total distributed
    (var-set total-distributed (+ (var-get total-distributed) amount))
    
    ;; Log the claim
    (print { action: "claim", claimer: claimer, amount: amount, total-claims: (+ prev-claims u1) })
    (ok amount)
  ))
)

;; Owner funds the faucet
(define-public (fund-faucet (amount uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err ERR_UNAUTHORIZED))
    ;; Transfer STX from owner to contract
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    ;; Log funding
    (print { action: "fund", funder: tx-sender, amount: amount })
    (ok true)
  )
)

;; Owner withdraws excess funds
(define-public (withdraw-funds (amount uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err ERR_UNAUTHORIZED))
    (try! (as-contract (stx-transfer? amount tx-sender contract-owner)))
    (ok true)
  )
)

;; Owner sets claim amount
(define-public (set-claim-amount (new-amount uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err ERR_UNAUTHORIZED))
    (var-set claim-amount new-amount)
    (ok true)
  )
)

;; Owner sets max claims per user
(define-public (set-max-claims (new-max uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err ERR_UNAUTHORIZED))
    (var-set max-claims-per-user new-max)
    (ok true)
  )
)

;; Owner toggles faucet active status
(define-public (toggle-faucet)
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err ERR_UNAUTHORIZED))
    (var-set faucet-active (not (var-get faucet-active)))
    (ok (var-get faucet-active))
  )
)

;; Get faucet balance
(define-read-only (get-faucet-balance)
  (stx-get-balance (as-contract tx-sender))
)

;; Get claim amount
(define-read-only (get-claim-amount)
  (var-get claim-amount)
)

;; Get user's claim count
(define-read-only (get-user-claims (user principal))
  (default-to u0 (map-get? user-claims user))
)

;; Get total distributed
(define-read-only (get-total-distributed)
  (var-get total-distributed)
)

;; Check if user can claim (basic check)
(define-read-only (can-user-claim (user principal))
  (let (
    (user-claim-count (default-to u0 (map-get? user-claims user)))
  )
  (and 
    (var-get faucet-active)
    (< user-claim-count (var-get max-claims-per-user))
    (>= (stx-get-balance (as-contract tx-sender)) (var-get claim-amount))
  ))
)