//
//  SimpleCrudMySQLApp.swift
//  SimpleCrudMySQL
//
//  Created by Zakki Mudhoffar on 23/06/23.
//

import SwiftUI

@main
struct SimpleCrudMySQLApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
        }
    }
}
