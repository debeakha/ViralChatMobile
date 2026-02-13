import SwiftUI

struct ChatView: View {
    let channel: Channel
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        ZStack {
            Color(hex: "1A1A2E")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: viewModel.messages.count) { _, _ in
                        if let last = viewModel.messages.last {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                messageInput
            }
        }
        .navigationTitle("#\(channel.name)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(hex: "1A1A2E"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            viewModel.channelId = channel.id
            viewModel.fetchMessages()
        }
    }
    
    var messageInput: some View {
        HStack {
            TextField("Message...", text: $viewModel.newMessage)
                .textFieldStyle(.plain)
                .padding()
                .background(Color(hex: "16213E"))
                .cornerRadius(8)
                .foregroundColor(.white)
            
            Button(action: viewModel.sendMessage) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color(hex: "E94560"))
                    .padding()
            }
        }
        .padding()
        .background(Color(hex: "0F3460"))
    }
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(Color(hex: "E94560"))
                .frame(width: 36, height: 36)
                .overlay(
                    Text(displayName.prefix(1).uppercased())
                        .foregroundColor(.white)
                        .font(.caption)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(displayName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    if message.isAnonymous {
                        Text("Guest")
                            .font(.caption2)
                            .foregroundColor(Color(hex: "A0A0A0"))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(hex: "16213E"))
                            .cornerRadius(4)
                    }
                }
                
                Text(message.content)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(8)
        .background(Color(hex: "16213E"))
        .cornerRadius(12)
    }
    
    var displayName: String {
        message.isAnonymous ? (message.anonymousName ?? "Guest") : (message.profiles?.displayName ?? "Unknown")
    }
}
