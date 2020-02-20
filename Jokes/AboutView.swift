//
//  AboutView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 20/02/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("About").modifier(HeadingLabel())
            
            Text("I built this app to share my favourite kind of humour, the lame kind 😆. In the spirit of sharing, this app is free and open source on https://github.com/alexlittlejohn/jokes 😻")
            
            VStack(alignment: .leading) {
                Text("Jokes supplied by")
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://icanhazdadjoke.com")!)
                }) {
                    Text("https://icanhazdadjoke.com")
                        .foregroundColor(Color("the_color"))
                }
            }
            
            VStack(alignment: .leading) {
                Text("Illustrations by")
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://icons8.com/ouch")!)
                }) {
                    Text("https://icons8.com")
                        .foregroundColor(Color("the_color"))
                }
            }
            
            Image("flame-29").resizable().aspectRatio(contentMode: .fit)
        }
        .padding()
        .frame(minWidth: 1, maxWidth: .infinity, minHeight: 1, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

