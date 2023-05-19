//
//  MeliLocalizables.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 19/05/23.
//

import Foundation
import SwiftUI

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "MeliLocalizable", comment: "")
    }
}

struct MeliLocalizables {
    static let mercadopagoMessage = "mercadopago_message".localized
    static let freeShippingMessage = "free_shipping_message".localized
    static let soldQuantityMessage = "sold_quantity_message".localized
    static let availableQuantityMessage = "available_quantity_message".localized
    static let productPrice = "product_price".localized
    static let installmentsInfo = "installments_info".localized
    static let noInterestMessage = "no_interest_message".localized
    static let searchPlaceholder = "search_placeholder".localized
    static let mainScreenInstructions = "main_screen_instructions".localized
    static let searchNavTitle = "search_nav_title".localized
    static let imageUrl = "image_url".localized
}
