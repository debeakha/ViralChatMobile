import SwiftUI
import Foundation

struct ChannelListView: View {
    @StateObject private var viewModel = ChannelViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "1A1A2E")
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(Color(hex: "E94560"))
                } else {
                    List(viewModel.channels) { channel in
                        NavigationLink(destination: ChatView(channel: channel)) {
                            ChannelRow(channel: channel)
                        }
                        .listRowBackground(Color(hex: "16213E"))
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Channels")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color(hex: "1A1A2E"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .onAppear {
            viewModel.fetchChannels()
        }
    }
}

struct ChannelRow: View {
    let channel: Channel
    
    var body: some View {
        HStack {
            Image(systemName: "number")
                .foregroundColor(Color(hex: "E94560"))
            
            VStack(alignment: .leading) {
                Text("#\(channel.name)")
                    .font(.headline)
                    .foregroundColor(.white)
                
                if let description = channel.description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(Color(hex: "A0A0A0"))
                }
            }
        }
        .padding(.vertical, 8)
    }
}

@MainActor
class ChannelViewModel: ObservableObject {
    @Published var channels: [Channel] = []
    @Published var isLoading = false
    
    func fetchChannels() {
        isLoading = true
        // Simulated channels - in production, call API
        channels = [
            Channel(id: "1", name: "tech", description: "Technology discussions", createdAt: Date(), updatedAt: Date()),
            Channel(id: "2", name: "trends", description: "What's trending", createdAt: Date(), updatedAt: Date()),
            Channel(id: "3", name: "ideas", description: "Brainstorming", createdAt: Date(), updatedAt: Date()),
            Channel(id: "4", name: "marketing", description: "Marketing strategies", createdAt: Date(), updatedAt: Date())
        ]
        isLoading = false
    }
}
