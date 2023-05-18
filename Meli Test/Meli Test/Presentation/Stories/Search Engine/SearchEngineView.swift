//
//  SearchEngineView.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import SwiftUI

struct SearchEngineView: View {
    @StateObject var viewModel = SearchEngineViewModel()
    
    var body: some View {
        VStack {
            VStack {
                TextField("Search here", text: $viewModel.searchText)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .onChange(of: viewModel.searchText) { _ in
                        viewModel.searchProduct()
                    }
            }
            .padding(16)
            .background(Color("primary-light"))
            
            Spacer()
        }
        
    }
}

struct SearchEngineView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEngineView()
    }
}
