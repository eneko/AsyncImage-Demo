# SwiftUI AsyncImage Demo

This little demo works both to demonstrate and test behavior of the
new `AsyncImage` view in SwiftUI available in Xcode 13.

`AsyncImage` enables users to asynchronously download images from
the network without writing any additional code other than using
the view itself.


## Features

Out of the box, it provides asynchronous downloading, placeholder
support, and, provided by `Image`, scaling and cropping.

However, as seen in the recording below, `AsyncImage` does not provide
any support for caching downloaded images. These means that, as of
Xcode 13 beta 4, images will repeatedly be downloaded from the network
each time they are presented in the UI.

![AsyncImage has no cache](/Media/async-image-xcode13b4.gif)


Note: Xcode 13 beta 4 fixes an issue where images would be downloaded
each time they would appear into view when scrolling through a `List`.


## Usage Examples

`AsyncImage` is really easy to use, as shown in the examples below.


### List Example

```swift
struct ContentView: View {
    @State var modal: Bool = false
    let imageURL = URL(string: "https://ukmadcat.com/wp-content/uploads/2019/04/sleepy-cat.jpg")
    var body: some View {
        List {
            Text("Hello")
            ForEach(0..<10) { index in
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Color.purple.opacity(0.1)
                    }
                }
                .padding()
                .onTapGesture {
                    modal = true
                }
            }
        }
        .sheet(isPresented: $modal) {
            //
        } content: {
            ModalView(imageURL: imageURL)
        }

    }
}
```

### Fullscreen Image Example

```swift
struct ModalView: View {
    let imageURL: URL?
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Color.purple.opacity(0.1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}
```
