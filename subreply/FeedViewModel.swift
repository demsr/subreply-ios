//
//  FeedViewModel.swift
//  subreply
//
//  Created by Dennis Sumser on 23.07.25.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var items: [FeedItem] = []
    @Published var isLoading = false
    private var currentPage = 1
    private var canLoadMorePages = true

    func loadMoreContentIfNeeded(currentItem item: FeedItem?) {
        guard let item = item else {
            loadPage()
            return
        }

        let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
        if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadPage()
        }
    }
    
    func refresh() {
           // Reset and fetch from page 1
           items = []
           currentPage = 1
           canLoadMorePages = true
           loadPage()
       }

    private func loadPage() {
        guard !isLoading && canLoadMorePages else { return }
        isLoading = true

        let urlString = "https://subreply.com/api/discover?p=\(currentPage)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
           

            if let data = data {
                do {
                    let page = try JSONDecoder().decode(FeedPage.self, from: data)
                    DispatchQueue.main.async {
                        self.items.append(contentsOf: page.entries)
                        self.currentPage += 1
                        self.canLoadMorePages = !page.entries.isEmpty
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {
                       self.isLoading = false
                    }
                    
                    print("Decoding error: \(error)")
                }
            }else{
                DispatchQueue.main.async {
                            self.isLoading = false
                        }
            }
        }.resume()
    }
}
