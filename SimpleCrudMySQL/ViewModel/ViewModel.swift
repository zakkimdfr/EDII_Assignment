//
//  ViewModel.swift
//  SimpleCrudMySQL
//
//  Created by Zakki Mudhoffar on 23/06/23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var items = [UserModel]()
    let urlPrefix = "http://localhost:3000"
    
    init() {
        fetchUsers()
    }
    
    //MARK: - Fetch data
    func fetchUsers() {
        guard let url = URL(string: "\(urlPrefix)/users") else {
            print ( "Not found url")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if error != nil {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder ().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                        
                    }
                } else {
                    print( "No data")
                }
            } catch let JsonError {
                print("fetch: \(error)")
            }
        }.resume ()
    }
    
    //MARK: - Create data
    func createUser(userModel: UserModel) {
        guard let url = URL(string: "\(urlPrefix)/createUser") else {
            print ( "Not found url")
            return
        }
        
        let userModel: [String: Any] = [
            "fullname": userModel.fullname,
            "username": userModel.username,
            "password": userModel.password ?? "",
            "status": userModel.status ?? "",
            
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: userModel)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder ().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                    }
                } else {
                    print( "No data")
                }
            } catch let JsonError {
                print("create: \(error)")
            }
        }.resume ()
    }
    
    //MARK: - Update data
    func updateUser(userModel: UserModel) {
        guard let url = URL(string: "\(urlPrefix)/updateUser") else {
            print ( "Not found url")
            return
        }
        
        let userModel: [String: Any] = [
            "id" : userModel.id,
            "fullname": userModel.fullname,
            "username": userModel.username,
            "password": userModel.password ?? "",
            "status": userModel.status ?? "",
            
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: userModel)
            
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder ().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                    }
                } else {
                    print( "No data")
                }
            } catch let JsonError {
                print("update: \(error)")
            }
        }.resume ()
    }
    
    //MARK: - Delete data
    func deleteUser(parameters: [String: Any]) {
        guard let url = URL(string: "\(urlPrefix)/deleteUser") else {
            print ( "Not found url")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder ().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                    }
                } else {
                    print( "No data")
                }
            } catch let JsonError {
                print("delete: \(error)")
            }
        }.resume ()
    }
    
}
