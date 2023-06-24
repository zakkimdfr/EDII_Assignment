//
//  ContentView.swift
//  SimpleCrudMySQL
//
//  Created by Zakki Mudhoffar on 23/06/23.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    @EnvironmentObject var viewModel : ViewModel
    @State var isPresentedNewUser = false
    @State var fullname = ""
    @State var username = ""
    @State var password = ""
    @State var status = ""
    
    private let refreshInterval: TimeInterval = 1.0
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items, id: \.id) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        VStack(alignment: .leading) {
                            Text(item.fullname)
                            Text(item.username)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteUser)
                .onReceive(timer) { _ in
                    viewModel.fetchUsers()
                }
                
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Users")
            .navigationBarItems(trailing: plusButton)
            
            
        }
        .sheet(isPresented: $isPresentedNewUser, content: {
            NewUserView(isPresented: $isPresentedNewUser, fullname: $fullname, username: $username, password: $password, status: $status)
        })
    }
    
    private func deleteUser(indexSet: IndexSet) {
        let id = indexSet.map {viewModel.items[$0].id}
        DispatchQueue.main.async {
            let parameters: [String: Any] = ["id": id[0]]
            self.viewModel.deleteUser(parameters: parameters)
            self.viewModel.fetchUsers()
        }
    }
    
    var plusButton: some View {
        Button(action: {
            isPresentedNewUser.toggle()
        }, label: {
            Image(systemName: "plus")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
