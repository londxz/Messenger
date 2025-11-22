//
//  ProfileView.swift
//  MessengerApp
//
//  Created by Родион Холодов on 22.11.2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color(.systemGray4))

                Text("Bruce Wayne")
                    .font(.title2)
                    .fontWeight(.semibold)
            }

            List {
                Section {
                    ForEach(SettingViewModel.allCases) { options in
                        HStack {
                            Image(systemName: options.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(options.imageColor)

                            Text(options.title)
                                .font(.subheadline)
                        }
                    }
                }

                Section {
                    Button("Logout") {}

                    Button("Delete account") {}
                }
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
