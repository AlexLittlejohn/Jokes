//
//  PopupContentView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 08/08/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import SwiftUI

struct PopupContent {
    var icon: String = "doc.on.doc"
    var text: String = ""
}

let copyPopupContent = PopupContent(icon: "doc.on.doc", text: "Copied to clipboard")
let addFavouritePopupContent = PopupContent(icon: "heart.fill", text: "Added to favourites")
let removeFavouritePopupContent = PopupContent(icon: "heart", text: "Removed from favourites")
let sharedPopupContent = PopupContent(icon: "square.and.arrow.up", text: "Shared")

struct PopupContentView: View {
    var content: PopupContent
    
    var body: some View {
        HStack(spacing: Measurements.small) {
            Image(systemName: content.icon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .foregroundColor(.systemRed)
            
            Text(content.text)
                .font(.system(size: 12))
                .foregroundColor(.systemBackground)
                .fixedSize(horizontal: false, vertical: true)
        }
        .animation(nil)
        .frame(minWidth: 150)
        .padding(Measurements.medium)
        .background(Color.label.opacity(0.8))
        .clipShape(Capsule())
    }
}
