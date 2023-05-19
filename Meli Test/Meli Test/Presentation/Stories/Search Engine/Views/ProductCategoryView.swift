//
//  ProductCategoryView.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 19/05/23.
//

import SwiftUI

struct ProductCategoryView: View {
    let category: ProductCategory
    
    var body: some View {
        VStack {
            Text(category.name)
                .foregroundColor(.black)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
        }
        .padding(12)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.11), radius: 26, x: 4, y: 4)
    }
}

struct ProductCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCategoryView(category: .init(id: "", name: "Test Category"))
    }
}
