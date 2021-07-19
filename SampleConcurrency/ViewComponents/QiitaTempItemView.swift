//
//  QiitaTempItemView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/18.
//

import SwiftUI

struct QiitaTempItemView: View {
    private let apiClient = APIClient()
    var item: QiitaItem
    @State var imageData: Data?

    var body: some View {
        HStack {
            if let imageData = imageData {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .mask(RoundedRectangle(cornerRadius: 20))
            } else {
                ProgressView()
                    .tint(.cyan)
                    .frame(width: 40, height: 40)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.body)
                    .frame(height: 48)
                Label(String(item.likesCount),
                      systemImage: "star")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .symbolRenderingMode(.multicolor)
            }
        }
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        async {
            guard imageData == nil else { return }
            imageData = try await apiClient
                .fetchImageData(url: URL(string: item.user.profileImageUrl)!)
        }
    }
}

struct QiitaTempItemView_Previews: PreviewProvider {
    static var previews: some View {
        QiitaTempItemView(item: QiitaItem(
            id: "testId",
            title: "title",
            url: "https://www.google.com",
            commentsCount: 0,
            likesCount: 0,
            reactionsCount: 0,
            tags: [],
            user: QiitaItemUser(
                id: "testUserId",
                name: "name",
                description: "description",
                profileImageUrl: "",
                followeesCount: 0,
                followersCount: 0,
                itemsCount: 0),
            createdAt: "2021-01-01",
            updatedAt: "2021-01-01"))
    }
}
