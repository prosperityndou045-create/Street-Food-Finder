//
//  ChatBoard.swift
//  Street Food Finder
//
//  Created by Prosperity on 16/4/2026.
//


import SwiftUI

internal import Combine
struct Conversation: Identifiable {
    var id: String
    var participantIds: [String]
    var lastMessage: String
    var updatedAt: Date
}

struct Message: Identifiable {
    var id: String
    var conversationId: String
    var senderId: String
    var text: String
    var timestamp: Date
}

struct AppTheme: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var primaryColor: Color
}

class ThemeManager: ObservableObject {

    @Published var selectedTheme: AppTheme =
        AppTheme(name: "Blue", primaryColor: .blue)

    let themes: [AppTheme] = [
        AppTheme(name: "Blue", primaryColor: .blue),
        AppTheme(name: "Green", primaryColor: .green),
        AppTheme(name: "Purple", primaryColor: .purple),
        AppTheme(name: "Orange", primaryColor: .orange),
        AppTheme(name: "Black", primaryColor: .black)
    ]
}

struct ChatView: View {
    var conversationId: String
    var currentUserId: String

    @EnvironmentObject var themeManager: ThemeManager

    @State private var messageText = ""

    @State private var messages: [Message] = [
        Message(id: "1", conversationId: "sample", senderId: "user2", text: "Hey ", timestamp: Date()),
        Message(id: "2", conversationId: "sample", senderId: "user1", text: "Hello!", timestamp: Date())
    ]

    var body: some View {
        VStack(spacing: 0) {

            HStack {
                Text("Chats")
                    .font(.headline)
                Spacer()
                NavigationLink("More") {
                    ThemeSettingsView()
                        .environmentObject(themeManager)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(messages) { msg in
                        HStack {
                            if msg.senderId == currentUserId {
                                Spacer()
                                Text(msg.text)
                                    .padding()
                                    .background(themeManager.selectedTheme.primaryColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            } else {
                                Text(msg.text)
                                    .padding()
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(12)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }

            HStack {
                TextField("Type message...", text: $messageText)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    sendMessage()
                }
                .disabled(messageText.isEmpty)
            }
            .padding()
        }
    }

    func sendMessage() {
        let newMessage = Message(
            id: UUID().uuidString,
            conversationId: conversationId,
            senderId: currentUserId,
            text: messageText,
            timestamp: Date()
        )

        messages.append(newMessage)
        messageText = ""
    }
}

struct ThemeSettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        VStack(spacing: 15) {
            Text("Choose TextColor")
                .font(.title2)
                .bold()

            ForEach(themeManager.themes) { theme in
                Button {
                    themeManager.selectedTheme = theme
                } label: {
                    HStack {
                        Circle()
                            .fill(theme.primaryColor)
                            .frame(width: 20, height: 20)

                        Text(theme.name)
                            .foregroundColor(.primary)

                        Spacer()

                        if themeManager.selectedTheme == theme {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        ChatView(
            conversationId: "sample123",
            currentUserId: "user1"
        )
        .environmentObject(ThemeManager())
    }
}
