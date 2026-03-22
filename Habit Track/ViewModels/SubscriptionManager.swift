//
//  PremiumManager.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 22/03/2026.
//

import Foundation
import StoreKit

@MainActor
class SubscriptionManager: ObservableObject {
    @Published var isPremium: Bool = false
    @Published var products: [Product] = []
    
    private let productIDs = ["com.habittrack.premium"]
    
    init() {
        Task {
            await loadProduct()
            await updateCustomerStatus()
        }
    }
    
    func loadProduct() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print("Failed to load products")
        }
    }
    
    func purchase() async {
        guard let product = products.first else { return }
        
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                if case .verified(_) = verification {
                    isPremium = true
                }
            default:
                break
            }
        } catch {
            print("Purchase faild")
        }
    }
    
    func updateCustomerStatus() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                if productIDs.contains(transaction.productID) {
                    isPremium = true
                    return
                }
            }
        }
        
        isPremium = false
    }
    
    func restore() async {
        try? await AppStore.sync()
        await updateCustomerStatus()
    }
}
