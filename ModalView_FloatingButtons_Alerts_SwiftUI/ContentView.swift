import SwiftUI

struct ContentView: View {
    @State var showDetailView = false
    @State var SelectedArticle : Article?
    var body: some View {
        NavigationView {
            List(articles) { article in
                ArticleRow(article: article)
                    .onTapGesture {
                        self.showDetailView = true
                        self.SelectedArticle = article
                    }
            }
            .navigationTitle("Your Reading")
        }
        //Adding Sheet Modal.
        .sheet(isPresented: self.$showDetailView){
            if SelectedArticle != nil {
                ArticleDetails(article: self.SelectedArticle!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ArticleRow: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            
            Text(article.title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .lineLimit(3)
                .padding(.bottom, 0)
            
            Text("By \(article.author)".uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
            
            HStack(spacing: 3) {
                ForEach(1...(article.rating), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            
            Text(article.excerpt)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
}

struct ArticleDetails: View {
    var article: Article
    var body: some View {
        ScrollView {
            VStack(alignment:.leading) {
                Image(article.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Group{ // Group Modifier Allow Apply certain Configuration on multiple views.
                    Text(article.title)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.black)
                        .lineLimit(3)
                    Text("By \(article.author)".uppercased())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .padding(.bottom,0)// Spacing Between Title and author
                Text(article.content)
                    .font(.body)
                    .padding()
                    .lineLimit(.max)
                    .multilineTextAlignment(.leading)
            }
            
        }
    }
}

