//
//  JokeSceneView.swift
//  Jokes
//
//  Created by Alex Littlejohn on 10/07/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Ducks
import PopupView
import SwiftUI
import Shared

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}

struct JokeSceneView: View {
    
    @EnvironmentObject var store: Store<AppState>
    @State var punchlineVisible: Bool = false
    @State var sheetVisible: Bool = false
    @State var shareSheetVisible: Bool = false
    @State var favouritesVisible: Bool = false
    @State var showingPopup: Bool = false
    @State var popupContent: (String, String) = ("", "")
    @State var rotation: Rotation = .zero
    
    static let copyPopupContent = ("doc.on.doc", "Copied to clipboard")
    static let addFavouritePopupContent = ("heart.fill", "Added to favourites")
    static let removeFavouritePopupContent = ("heart", "Removed from favourites")
    static let sharedPopupContent = ("square.and.arrow.up", "Shared")

    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: Measurements.medium) {
                    
                    HStack {
                        favouriteButton
                        
                        Spacer()
                        
                        Image("icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22)
                            .rotationEffect(rotation.value)
                            .animation(.spring())
                            .onTapGesture {
                                self.rotation = self.rotation.next()
                            }
                    }
                    
                    VStack(spacing: Measurements.medium) {
                        setup
                        
                        if !punchlineVisible {
                            revealButton
                        } else {
                            punchline
                        }
                    }.contextMenu(ContextMenu {
                        contextCopyButton
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .transition(.moveAndFade)
                .id("JokeScene" + store.state.joke.setup + store.state.joke.punchline)
            }
            .padding(Measurements.larger)
            .padding(.bottom, Measurements.largest + Measurements.large)
            .frame(width: UIScreen.main.bounds.width, alignment: .top)
        }
        .sheet(isPresented: $sheetVisible, content: {
            if self.shareSheetVisible {
                ShareSheet(activityItems: [self.store.state.joke.shareable])
                    .background(Color.systemGreen)
                    .edgesIgnoringSafeArea(.bottom)
            } else {
                FavouritesView().environmentObject(self.store)
            }
        })
        .popup(isPresented: $showingPopup, type: .floater(), position: .top, animation: Animation.spring(), autohideIn: 2) {
            self.popup
        }
            .overlay(actionBar, alignment: .bottomLeading)
    }
    
    var popup: some View {
        HStack(spacing: Measurements.small) {
            Image(systemName: popupContent.0)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .foregroundColor(.systemRed)
            
            Text(popupContent.1)
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
    
    var actionBar: some View {
        HStack(alignment: .center, spacing: Measurements.medium) {
            Spacer()
            favouritesButton
            shareButton
            nextButton
        }.padding(Measurements.larger)
    }

    var setup: some View {
        Text(store.state.joke.setup)
            .foregroundColor(.label)
            .lineLimit(nil).minimumScaleFactor(0.5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .font(Font.system(size: 44, weight: .heavy))
            .animation(nil)
            .opacity(punchlineVisible ? 0.4 : 1)
            .animation(.spring())
    }
    
    var punchline: some View {
        Text(store.state.joke.punchline)
            .lineLimit(nil)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.label)
            .font(Font.system(size: 32, weight: .heavy))
            .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
            .animation(.spring())
    }
    
    var nextButton: some View {
        Button(action: nextJoke, label: {
            Text("Next joke")
        })
            .buttonStyle(CustomButtonStyle(color: .systemBlue, square: false))
    }
    
    var revealButton: some View {
        Button(action: showPunchline, label: {
            Text("Reveal punchline")
                .font(Font.system(size: 32, weight: .heavy))
                .frame(maxWidth: .infinity, alignment: .leading)
        })
            .transition(.opacity)
            .frame(maxWidth: .infinity, alignment: .leading)
            .animation(.spring())
    }
    
    var shareButton: some View {
        Button(action: showShareSheet, label: {
            Image(systemName: "square.and.arrow.up")
                .padding(.bottom, Measurements.small)
                .padding(.top, Measurements.smallest)
        })
            .buttonStyle(CustomButtonStyle(color: .systemGreen))
            .accessibility(label: Text("Share"))
    }
    
    var favouritesButton: some View {
        Button(action: showFavourites, label: {
            Image(systemName: "heart.fill")
                .padding(.bottom, Measurements.smaller)
                .padding(.top, Measurements.smaller)
        })
            .buttonStyle(CustomButtonStyle(color: .systemPurple))
            .accessibility(label: Text("Show favourites"))
    }
    
    var favouriteButton: some View {
        Button(action: toggleFavourite, label: {
            Image(systemName: store.state.isFavourite() ? "heart.fill" : "heart")
                .padding(.vertical, Measurements.smaller)
                .padding(.trailing, Measurements.smaller)
                .foregroundColor(.systemRed)
                .font(Font.system(size: 18, weight: .semibold))
        })
            .accessibility(label: Text(store.state.isFavourite() ? "Remove as favourite" : "Mark as favourite"))
    }
    
    var contextCopyButton: some View {
        Button(action: {
            UIPasteboard.general.string = self.store.state.joke.shareable
            self.popupContent = JokeSceneView.copyPopupContent
            self.showingPopup = true
        }, label: {
            Image(systemName: "doc.on.doc")
                .foregroundColor(.systemRed)
            Text("Copy")
                .foregroundColor(Color.blue)
        })
    }

    func showPunchline() {
        withAnimation(.spring()) {
            self.punchlineVisible = true
        }
    }
    
    func nextJoke() {
        withAnimation(.spring()) {
            self.punchlineVisible = false
            self.store.dispatch(Actions.randomJoke)
        }
    }
    
    func showShareSheet() {
        shareSheetVisible = true
        favouritesVisible = false
        sheetVisible = true
    }
    
    func showFavourites() {
        shareSheetVisible = false
        favouritesVisible = true
        sheetVisible = true
    }
    
    func toggleFavourite() {
        popupContent = store.state.isFavourite() ? JokeSceneView.removeFavouritePopupContent : JokeSceneView.addFavouritePopupContent
        showingPopup = true
        store.dispatch(Actions.toggleFavourite(store.state.joke))
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct JokeSceneView_Previews: PreviewProvider {
    
    static let store = Store(reducer: reducer, state: AppState.empty, middleware: [favouritesMiddleware])
    
    static var previews: some View {
        Group {
            JokeSceneView()
                .environmentObject(store)
            
            JokeSceneView()
                .environmentObject(store)
                .environment(\.colorScheme, .dark)
        }
    }
}
