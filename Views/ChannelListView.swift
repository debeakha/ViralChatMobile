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
        
        Task {
            do {
                let response: ChannelsResponse = try await APIClient.request(
                    endpoint: "/api/channels"
                )
                await MainActor.run {
                    self.channels = response.channels
                }
            } catch {
                print("Error fetching channels: \(error)")
            }
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
}

struct ChannelsResponse: Decodable {
    let channels: [Channel]
}
