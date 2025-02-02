//
//  OnboardingView.swift
//  OnboardingApp
//
//  Created by Maulik Shah on 2/3/25.
//

import SwiftUI

struct OnboardingView: View {
    
   // onboard state
    @State var onboardingState : Int = 0
    let transition : AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    // inputs
    @State var name : String = ""
    @State var gender : String = ""
    @State var age : Double = 50
    
    // alert
    @State var alertTitle = ""
    @State var showAlert = false
    
    // appstorage
    @AppStorage("name") var currentUsername: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender : String?
    @AppStorage("signed_in") var currentUsersignedIn = false

    // Onboarding state
    /*
        0 - Welcome screen
        1 - add name
        2 - add age
        3 - add gender
     */
    
    var body: some View {
        ZStack{
            
            ZStack{
                switch onboardingState {
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    addNameSection
                        .transition(transition)
        
                case 2:
                    addAgeSection
                        .transition(transition)
                case 3:
                    addGenderSection
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.green)
                }
            }
            .alert(alertTitle, isPresented: $showAlert) {
                
            }
            
            VStack{
                Spacer()
                bottomButton
            }.padding(30)
        }
    }

}

// MARK: COMPONENTS
extension OnboardingView {
    private var bottomButton:some View{
        
        Text(onboardingState == 0 ? "SIGN UP" :
                onboardingState == 3 ? "FINISH" : "Next")
            .font(.headline)
            .foregroundStyle(.purple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            .onTapGesture {
                handleNextButtonPress()
            }
    }
    
    private var welcomeSection : some View {
        VStack(spacing: 40) {
            Spacer()
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200,height: 200)
                .foregroundStyle(.white)
            Text("Find your match.")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .overlay (
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y:5)
                        .foregroundStyle(.white)
                    ,alignment:.bottom
                )
            
            Text("This is the #1 app for finding your match online! In this tutorial we are practicing using Appstorage and other SwiftUI techniques.")
                .fontWeight(.medium)
                .foregroundStyle(.white)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    
    
    
    private var addNameSection : some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            TextField("Your name here...", text: $name)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(.white)
                .cornerRadius(10)
                
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addGenderSection : some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What's your Gender?")
            
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            VStack {
                
                Menu {
                    Picker(selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Non-Binary").tag("Non-Binary")
                    } label: {
                        Text("gender picker")
                    }
                    
                } label: {
                    Text(gender.count > 1 ? gender : "Select a gender")
                        .font(.headline)
                        .foregroundStyle(.purple)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var  addAgeSection  : some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What's your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)

            
            Text(
                String(format: "%.0f", age)
            )
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            Slider(value: $age, in: 18...100, step: 1)
                .tint(Color.white)
        
            Spacer()
            Spacer()
        }
        .padding(30)
    }
}

// MARK: FUNCTIONS 

extension OnboardingView{
    func handleNextButtonPress(){
        
        switch onboardingState {
        case 1:
            guard name.count >= 3 else{
                showAlert(title: "Your name must be at least 3 characters long 😔")
                return
            }
        case 3:
            guard gender != "" else{
                showAlert(title: "Please select a gender a before moving forward! 😳")
                return
            }
        default:
            break
        }
        
        // go to next screen
        if onboardingState == 3 {
            // sign in
            signIn()
        }
        else{
            withAnimation(.spring) {
                onboardingState += 1
            }
        }
    }
    
    func signIn() {
        currentUsername = name
        currentUserAge = Int(age)
        currentUserGender = gender
        withAnimation(.spring) {
            currentUsersignedIn = true
        }
    }
    
    
    func showAlert(title : String){
        alertTitle =  title
        showAlert.toggle()
    }
}

#Preview {
    OnboardingView()
        .background(Color.purple)
}
