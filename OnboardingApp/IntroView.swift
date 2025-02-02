//
//  IntroView.swift
//  OnboardingApp
//
//  Created by Maulik Shah on 2/3/25.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUsersignedIn = false
    
    var body: some View {
        ZStack{
            //background
            RadialGradient(
                colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))],
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            if currentUsersignedIn {
                ProfileView()
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            }else{
                OnboardingView()
                  //  .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                
            }
        }
        .animation(.easeInOut, value: currentUsersignedIn)
    }
}

#Preview {
    IntroView()
}
