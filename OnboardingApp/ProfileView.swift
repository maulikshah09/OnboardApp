//
//  ProfileView.swift
//  OnboardingApp
//
//  Created by Maulik Shah on 2/3/25.
//

import SwiftUI

struct ProfileView: View {
    // appstorage
    @AppStorage("name") var currentUsername: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender : String?
    @AppStorage("signed_in") var currentUsersignedIn = false
    
    var body: some View {
        VStack (spacing: 20){
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150,height: 150)
            
            Text("Hello, \(currentUsername ?? "")!")
            Text("This user is \(currentUserAge ?? 0) years old!")
            Text("This gender is \(currentUserGender ?? "Unknown")")
            
            Text("SIGN OUT")
                .foregroundStyle(.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth:.infinity)
                .background(.black)
                .cornerRadius(10)
                .onTapGesture {
                    signOut()
                }
        }
        .font(.title)
        .foregroundStyle(.purple)
        .padding()
        .padding(.vertical,40)
        .background(.white)
        .cornerRadius(10)
        .padding(20)
        .shadow(radius: 10)
    }
    
    func signOut(){
        currentUsername = nil
        currentUserAge = nil
        currentUserGender = nil
        withAnimation(.spring) {
            currentUsersignedIn = false
        }
    }
}

#Preview {
    ProfileView()
}
