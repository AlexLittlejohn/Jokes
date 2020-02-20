//
//  BackgroundView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 20/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import SwiftUI

struct BackgroundView: View {
    
    @EnvironmentObject var store: Store<AppState>
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("the_color"))
                .frame(minWidth: 1, maxWidth: .infinity, minHeight: 1, maxHeight: .infinity, alignment: .topLeading)
                .edgesIgnoringSafeArea(.all)

            GeometryReader { geometry in
                Image("flame-\(self.store.state.imageNumber)")
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.width, alignment: .top)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
