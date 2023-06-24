//
//  DetailView.swift
//  SimpleCrudMySQL
//
//  Created by Zakki Mudhoffar on 23/06/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel : ViewModel
    @Environment(\.presentationMode) var presentationMode
    let item: UserModel
    @State var fullname = ""
    @State var username = ""
    @State var password = ""
    @State var status = ""
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text( "Update user" )
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
            }.padding ()
                .onAppear {
                    self.fullname = item.fullname
                    self.username = item.username
                    self.password = item.password ?? ""
                    self.status = item.status ?? ""
                }
        }
        .navigationBarTitle("Edit User", displayMode: .inline)
        .navigationBarItems(trailing: trailing)
    }
    
    var trailing: some View {
        Button(action: {
            if fullname != ""{
                let parameters: UserModel = UserModel(id: item.id, fullname: fullname, username: username, password: password, status: status)
                viewModel.updateUser(userModel: parameters)
                viewModel.fetchUsers()
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("Save")
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
