//
//  NewUserView.swift
//  SimpleCrudMySQL
//
//  Created by Zakki Mudhoffar on 23/06/23.
//

import SwiftUI

struct NewUserView: View {
    @EnvironmentObject var viewModel : ViewModel
    @Binding var isPresented: Bool
    @Binding var fullname: String
    @Binding var username: String
    @Binding var password: String
    @Binding var status: String
    @State var isAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text( "Create new user" )
                        .font (Font.system(size: 16, weight: .bold))
                    
                    TextField("Name", text: $fullname)
                        .padding ()
                        .background (Color.white)
                        .cornerRadius (6)
                        .padding (.bottom)
                    
                    TextField("Username", text: $username)
                        .padding ()
                        .background (Color.white)
                        .cornerRadius (6)
                        .padding(.bottom)
                    
                    SecureField("Password", text: $password)
                        .padding ()
                        .background (Color.white)
                        .cornerRadius (6)
                        .padding(.bottom)

                    TextField("Status", text: $status)
                        .padding ()
                        .background (Color.white)
                        .cornerRadius (6)
                        .padding(.bottom)
                    
                    Spacer ()
                }
                .padding ()
                .alert(isPresented: $isAlert) {
                    let title = Text("No data")
                    let message = Text("Please fill your data")
                    return Alert(title: title, message: message)
                }
            }
            .navigationBarTitle("New User", displayMode: .inline)
            .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
    
    var leading: some View {
        Button(action: {
            isPresented.toggle()
        }) {
            Text("Cancel")
        }
    }
    
    var trailing: some View {
        Button(action: {
            if fullname != "" && username != "" && password != "" && status != "" {
                let parameters: UserModel = UserModel(id: 0, fullname: fullname, username: username, password: password, status: status)
                viewModel.createUser(userModel: parameters)
                viewModel.fetchUsers()
                
                isPresented.toggle()
            } else {
                isAlert.toggle()
            }
            
        }) {
            Text("Post")
        }
    }
}

//struct NewUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewUserView()
//    }
//}
