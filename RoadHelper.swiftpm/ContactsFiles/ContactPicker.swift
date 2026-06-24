//
//  ContactPicker.swift
//  RoadHelper
//
//  Created by Marco Bueno on 15/02/26.
//

import SwiftUI
import ContactsUI

struct ContactPicker: UIViewControllerRepresentable {
    var onSelect: (CNContact) -> Void

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    @MainActor
    class Coordinator: NSObject, @MainActor CNContactPickerDelegate {
        var parent: ContactPicker
        init(_ parent: ContactPicker) { self.parent = parent }

        
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.onSelect(contact)
        }
    }
}
